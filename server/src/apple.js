// StoreKit 2 proof verification and current subscription status. Never decode a
// client JWS as entitlement evidence without Apple's certificate-chain verifier.
import { Buffer } from 'node:buffer';
import jwt from 'jsonwebtoken';
import { APPLE_ROOTS_BASE64 } from './apple_roots.js';
import { sha256Hex } from './play.js';
import { readBoundedText } from './ai.js';

const PRODUCTS = Object.freeze({
  nshoptor_pro: 'pro', nshoptor_max: 'max',
  nshoptor_pro_v2: 'pro-v2', nshoptor_max_v2: 'max-v2',
});
const Environment = Object.freeze({ PRODUCTION: 'Production', SANDBOX: 'Sandbox' });
const free = () => ({ tier: 'free', policy: 'free', identity: null });
const busy = () => new Error('apple_entitlement_busy');
const validId = value => typeof value === 'string' && /^[0-9]{1,64}$/.test(value);
const timestamp = value => Number.isSafeInteger(value) && value >= 0 && value <= 8640000000000000;

function configuration(env) {
  const environment = env.APPLE_ENVIRONMENT ?? Environment.PRODUCTION;
  if (environment !== Environment.PRODUCTION &&
      !(environment === Environment.SANDBOX && env.APPLE_ALLOW_SANDBOX === '1')) throw busy();
  const appId = Number(env.APPLE_APP_ID);
  if (typeof env.APPLE_BUNDLE_ID !== 'string' || !/^[A-Za-z0-9.-]{3,255}$/.test(env.APPLE_BUNDLE_ID) ||
      !Number.isSafeInteger(appId) || appId <= 0 ||
      typeof env.APPLE_KEY_ID !== 'string' || !/^[A-Z0-9]{10}$/.test(env.APPLE_KEY_ID) ||
      typeof env.APPLE_ISSUER_ID !== 'string' || !/^[a-f0-9-]{36}$/i.test(env.APPLE_ISSUER_ID) ||
      typeof env.APPLE_PRIVATE_KEY !== 'string' || !env.APPLE_PRIVATE_KEY.includes('BEGIN PRIVATE KEY')) throw busy();
  return { environment, allowSandbox: env.APPLE_ALLOW_SANDBOX === '1', appId, bundleId: env.APPLE_BUNDLE_ID };
}

// All injected trust/online options are direct test-call options. The HTTP
// handler never forwards request fields or env values into this options object.
export async function resolveAppleEntitlement(env, signedTransaction, {
  fetchImpl = fetch, now = Date.now(), testTrust,
} = {}) {
  if (typeof signedTransaction !== 'string' || signedTransaction.length > 8192 ||
      !/^[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+$/.test(signedTransaction)) throw busy();
  const config = configuration(env);
  // jsrsasign (used internally by Apple's verifier) seeds randomness on import.
  // Workers prohibit that during module initialization; load within the request.
  const { SignedDataVerifier, Type } = await import('@apple/app-store-server-library');
  const roots = testTrust?.roots ?? APPLE_ROOTS_BASE64.map(root => Buffer.from(root, 'base64'));
  const environments = config.environment === Environment.PRODUCTION && config.allowSandbox
    ? [Environment.PRODUCTION, Environment.SANDBOX] : [config.environment];
  // Any unverifiable proof, OCSP/network error, or status outage stops before
  // quota reservation. It must not silently spend a paid customer's free quota.
  let submitted, verifier, environment;
  for (const candidate of environments) {
    const candidateVerifier = new SignedDataVerifier(roots, testTrust?.onlineChecks ?? true,
      candidate, config.bundleId, config.appId);
    try {
      submitted = await candidateVerifier.verifyAndDecodeTransaction(signedTransaction);
      verifier = candidateVerifier;
      environment = candidate;
      break;
    } catch { /* Only a complete verification can select an environment. */ }
  }
  if (!submitted) throw busy();
  if (!validId(submitted.originalTransactionId) || !validId(submitted.transactionId)) throw busy();

  const authorization = jwt.sign({ bid: config.bundleId }, env.APPLE_PRIVATE_KEY, {
    algorithm: 'ES256', keyid: env.APPLE_KEY_ID, issuer: env.APPLE_ISSUER_ID,
    audience: 'appstoreconnect-v1', expiresIn: 300,
  });
  const host = environment === Environment.PRODUCTION
    ? 'https://api.storekit.apple.com' : 'https://api.storekit-sandbox.apple.com';
  let status;
  try {
    const response = await fetchImpl(`${host}/inApps/v1/subscriptions/${encodeURIComponent(submitted.originalTransactionId)}`, {
      headers: { authorization: `Bearer ${authorization}`, accept: 'application/json' },
      signal: AbortSignal.timeout(10_000), redirect: 'error',
    });
    if (!response.ok) throw busy();
    status = JSON.parse(await readBoundedText(response, 128 * 1024));
  } catch { throw busy(); }
  // Apple's status schema allows an absent appAppleId in Sandbox. A present
  // value must still match exactly, and Production always requires the ID.
  if (status?.bundleId !== config.bundleId ||
      (status.appAppleId !== config.appId &&
       !(environment === Environment.SANDBOX && !Object.hasOwn(status, 'appAppleId'))) ||
      status.environment !== environment || !Array.isArray(status.data)) throw busy();
  const matches = status.data.flatMap(group => Array.isArray(group?.lastTransactions) ? group.lastTransactions : [])
    .filter(item => item?.originalTransactionId === submitted.originalTransactionId);
  // Missing/ambiguous lineage is not evidence that the purchaser is free.
  if (matches.length !== 1 || typeof matches[0].signedTransactionInfo !== 'string') throw busy();
  if (![1, 2, 3, 4, 5].includes(matches[0].status)) throw busy();
  let current;
  try { current = await verifier.verifyAndDecodeTransaction(matches[0].signedTransactionInfo); }
  catch { throw busy(); }
  if (current.originalTransactionId !== submitted.originalTransactionId || !validId(current.transactionId)) throw busy();
  if (!timestamp(current.expiresDate) || !timestamp(current.purchaseDate) || current.purchaseDate > now ||
      !timestamp(current.signedDate) || current.signedDate > now + 60_000) throw busy();
  const policy = Object.hasOwn(PRODUCTS, current.productId) ? PRODUCTS[current.productId] : null;
  // Only active or cryptographically confirmed billing-grace subscriptions
  // qualify. Revoked/upgraded old transactions cannot grant either path.
  if (![1, 4].includes(matches[0].status) || !policy || current.type !== Type.AUTO_RENEWABLE_SUBSCRIPTION ||
      current.revocationDate !== undefined || current.revocationReason !== undefined || current.isUpgraded === true) return free();
  if (matches[0].status === 4) {
    if (typeof matches[0].signedRenewalInfo !== 'string') throw busy();
    let renewal;
    try { renewal = await verifier.verifyAndDecodeRenewalInfo(matches[0].signedRenewalInfo); }
    catch { throw busy(); }
    if (renewal.originalTransactionId !== current.originalTransactionId || renewal.productId !== current.productId ||
        !timestamp(renewal.signedDate) || renewal.signedDate > now + 60_000) throw busy();
    if (!timestamp(renewal.gracePeriodExpiresDate) || renewal.gracePeriodExpiresDate <= now) return free();
  } else if (current.expiresDate <= now) return free();
  const identity = 'apple:' + await sha256Hex(`${environment}:${config.bundleId}:${current.originalTransactionId}`);
  return { tier: policy.split('-')[0], policy, identity };
}
