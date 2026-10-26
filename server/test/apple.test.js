import test from 'node:test';
import assert from 'node:assert/strict';
import { X509Certificate } from 'node:crypto';
import { Buffer } from 'node:buffer';
import jwt from 'jsonwebtoken';
import { resolveAppleEntitlement } from '../src/apple.js';
import { APPLE_ROOTS_BASE64 } from '../src/apple_roots.js';
import { handleAi } from '../src/worker.js';
import { now, payload, env, signed, response, testTrust, x5c, privateKey, leafPublicKey } from './apple_fixture.js';

const lookup = data => async (url, init) => {
  assert.equal(url, `https://api.storekit.apple.com/inApps/v1/subscriptions/${payload.originalTransactionId}`);
  const authorization = jwt.verify(init.headers.authorization.slice(7), leafPublicKey,
    { algorithms: ['ES256'], audience: 'appstoreconnect-v1', issuer: env().APPLE_ISSUER_ID });
  assert.equal(authorization.bid, payload.bundleId);
  return new Response(JSON.stringify(data));
};
const resolve = (token = signed(), data = response(signed()), extra = {}) =>
  resolveAppleEntitlement(env(), token, { now, testTrust, fetchImpl: lookup(data), ...extra });

test('real chain and signature plus current status grant canonical Apple policy', async () => {
  const actual = await resolve();
  assert.equal(actual.tier, 'pro'); assert.equal(actual.policy, 'pro-v2');
  assert.match(actual.identity, /^apple:[a-f0-9]{64}$/);
  const renewal = await resolve(signed({ transactionId: '1000000000003' }));
  assert.equal(renewal.identity, actual.identity);
  const upgraded = await resolve(signed(), response(signed({ productId: 'nshoptor_max_v2', transactionId: '1000000000004' })));
  assert.equal(upgraded.policy, 'max-v2'); assert.equal(upgraded.identity, actual.identity);
});

test('pinned public roots are valid CA certificates; ephemeral CA is untrusted by production', async () => {
  for (const encoded of APPLE_ROOTS_BASE64) assert.equal(new X509Certificate(Buffer.from(encoded, 'base64')).ca, true);
  await assert.rejects(resolveAppleEntitlement(env(), signed(), { now, fetchImpl: lookup(response(signed())) }));
  await assert.rejects(resolveAppleEntitlement({ ...env(), APPLE_ROOTS: testTrust.roots }, signed(), { now }));
});

test('tampered payload, wrong signature algorithm and missing chain never grant', async () => {
  const parts = signed().split('.');
  parts[1] = Buffer.from(JSON.stringify({ ...payload, productId: 'nshoptor_max' })).toString('base64url');
  for (const token of [parts.join('.'), jwt.sign(payload, 'attacker', { algorithm: 'HS256', header: { x5c } }),
    jwt.sign(payload, privateKey, { algorithm: 'ES256' }), '1000000000001', 'a.b.c']) {
    await assert.rejects(resolve(token));
  }
});

test('wrong bundle, sandbox, Xcode and LocalTesting are never production proof', async () => {
  for (const fields of [{ bundleId: 'com.other' }, { environment: 'Sandbox' },
    { environment: 'Xcode' }, { environment: 'LocalTesting' }]) await assert.rejects(resolve(signed(fields)));
});

test('sandbox requires explicit server-only opt-in and cannot be selected by transaction', async () => {
  const sandbox = { ...env(), APPLE_ENVIRONMENT: 'Sandbox' };
  await assert.rejects(resolveAppleEntitlement(sandbox, signed({ environment: 'Sandbox' }), { now, testTrust }));
  const result = await resolveAppleEntitlement({ ...sandbox, APPLE_ALLOW_SANDBOX: '1' }, signed({ environment: 'Sandbox' }), {
    now, testTrust, fetchImpl: async url => {
      assert.ok(url.startsWith('https://api.storekit-sandbox.apple.com/'));
      return new Response(JSON.stringify(response(signed({ environment: 'Sandbox' }), { environment: 'Sandbox' })));
    },
  });
  assert.equal(result.tier, 'pro'); assert.notEqual(result.identity, (await resolve()).identity);
});

test('missing app/API config never grants or calls Apple', async () => {
  for (const key of ['APPLE_BUNDLE_ID', 'APPLE_APP_ID', 'APPLE_KEY_ID', 'APPLE_ISSUER_ID', 'APPLE_PRIVATE_KEY']) {
    const e = env(); delete e[key];
    await assert.rejects(resolveAppleEntitlement(e, signed(), { now, testTrust,
      fetchImpl: () => { assert.fail('missing configuration must not contact Apple'); } }));
  }
});

test('current signed status controls expiry, revocation, product and purchase type', async () => {
  for (const fields of [{ expiresDate: now }, { revocationDate: now - 1 },
    { revocationReason: 0 }, { isUpgraded: true }, { productId: 'unknown' }, { productId: '__proto__' },
    { type: 'Consumable' }]) {
    assert.equal((await resolve(signed(), response(signed(fields)))).tier, 'free', JSON.stringify(fields));
  }
  for (const fields of [{ expiresDate: undefined }, { purchaseDate: now + 1 }, { signedDate: now + 60001 }]) {
    await assert.rejects(resolve(signed(), response(signed(fields))));
  }
  for (const status of [2, 3, 5]) assert.equal((await resolve(signed(), response(signed(), { status }))).tier, 'free');
});

test('billing grace needs a verified matching renewal with a future grace deadline', async () => {
  const grace = (renewal = signed({ gracePeriodExpiresDate: now + 3600000 }), transaction = signed({ expiresDate: now - 1 })) => {
    const result = response(transaction, { status: 4 });
    result.data[0].lastTransactions[0].signedRenewalInfo = renewal;
    return result;
  };
  const active = await resolve();
  const result = await resolve(signed(), grace());
  assert.equal(result.policy, 'pro-v2'); assert.equal(result.identity, active.identity);
  for (const renewal of [undefined, 'a.b.c', signed({ originalTransactionId: '999', gracePeriodExpiresDate: now + 1 }),
    signed({ productId: 'nshoptor_max', gracePeriodExpiresDate: now + 1 }),
    signed({ environment: 'Sandbox', gracePeriodExpiresDate: now + 1 })]) {
    const data = grace(); data.data[0].lastTransactions[0].signedRenewalInfo = renewal;
    await assert.rejects(resolve(signed(), data));
  }
  assert.equal((await resolve(signed(), grace(signed({ gracePeriodExpiresDate: now })))).tier, 'free');
  assert.equal((await resolve(signed(), grace(undefined, signed({ revocationDate: now - 1 })))).tier, 'free');
});

test('API outages, unverifiable status, mismatch and ambiguous lineage stop without fallback', async () => {
  for (const fetchImpl of [async () => { throw new Error('offline'); }, async () => new Response('{}', { status: 429 }),
    async () => new Response('{}', { status: 401 }), async () => new Response('not JSON')]) {
    await assert.rejects(resolve(signed(), undefined, { fetchImpl }));
  }
  const valid = response(signed());
  for (const data of [response('a.b.c'), response(signed({ originalTransactionId: '999' })),
    response(signed(), { bundleId: 'com.other' }), response(signed(), { appAppleId: 42 }),
    response(signed(), { environment: 'Sandbox' }), response(signed(), { data: [] }),
    response(signed(), { status: 99 }), response(signed(), { status: '1' }),
    { ...valid, data: [...valid.data, ...valid.data] }]) await assert.rejects(resolve(signed(), data));
});

test('HTTP Apple errors and ambiguous proofs never reserve quota or call provider', async () => {
  const base = { installId: 'a'.repeat(32), task: 'parse_list', input: { text: 'milk' } };
  const e = { AI_URL: 'https://ai.example', AI_KEY: 'key', AI_MODEL: 'model',
    DB: { prepare: () => assert.fail('must not touch quota DB'), batch: () => assert.fail('must not reserve') } };
  for (const [proof, expected] of [[{ appleTransaction: signed() }, 503], [{ appleTransaction: '1000000000001' }, 503],
    [{ appleTransaction: signed(), purchaseToken: 'play' }, 400], [{ appleTransaction: '' }, 400],
    [{ appleTransaction: 'x'.repeat(8193) }, 400], [{ appleTransaction: {} }, 400]]) {
    const request = new Request('https://x/v1/ai', { method: 'POST', body: JSON.stringify({ ...base, ...proof }) });
    const result = await handleAi(request, e, { now: new Date(now), fetchImpl: () => assert.fail('provider must not be called') });
    assert.equal(result.status, expected);
  }
});

