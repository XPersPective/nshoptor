// Isolated test worker: never used as the production entry point. Generated
// trust roots enter only resolveAppleEntitlement's direct testTrust option.
import assert from 'node:assert/strict';
import { mkdtemp, readFile, writeFile, rm } from 'node:fs/promises';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { execFileSync } from 'node:child_process';
import { Miniflare } from 'miniflare';
import { now, env, signed, response, testTrust } from './apple_fixture.js';

const serverRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const directory = await mkdtemp(join(serverRoot, '.apple-runtime-'));
let runtime;
try {
  const token = signed();
  const sandboxToken = signed({ environment: 'Sandbox' });
  const graceStatus = response(signed({ expiresDate: now - 1 }), { status: 4 });
  graceStatus.data[0].lastTransactions[0].signedRenewalInfo = signed({ gracePeriodExpiresDate: now + 3600000 });
  const segments = token.split('.');
  segments[2] = (segments[2][0] === 'a' ? 'b' : 'a') + segments[2].slice(1);
  const source = `import { resolveAppleEntitlement } from '../src/apple.js';
    import { Buffer } from 'node:buffer';
    export default { async fetch() {
      const options = { now: ${now}, testTrust: { roots: [Buffer.from(${JSON.stringify([...testTrust.roots[0]])})], onlineChecks: false },
        fetchImpl: async () => Response.json(${JSON.stringify(response(token))}) };
      const valid = await resolveAppleEntitlement(${JSON.stringify(env())}, ${JSON.stringify(token)}, options);
      const dualEnvironment = ${JSON.stringify({ ...env(), APPLE_ALLOW_SANDBOX: '1' })};
      const productionOptIn = await resolveAppleEntitlement(dualEnvironment, ${JSON.stringify(token)}, {
        ...options, fetchImpl: async url => {
          if (!url.startsWith('https://api.storekit.apple.com/')) throw new Error('wrong Production host');
          return Response.json(${JSON.stringify(response(token))});
        } });
      const sandbox = await resolveAppleEntitlement(dualEnvironment, ${JSON.stringify(sandboxToken)}, {
        ...options, fetchImpl: async url => {
          if (!url.startsWith('https://api.storekit-sandbox.apple.com/')) throw new Error('wrong Sandbox host');
          return Response.json(${JSON.stringify(response(sandboxToken, { environment: 'Sandbox' }))});
        } });
      const sandboxStatusWithoutAppId = ${JSON.stringify(response(sandboxToken, { environment: 'Sandbox', appAppleId: undefined }))};
      const sandboxWithoutAppId = await resolveAppleEntitlement(dualEnvironment, ${JSON.stringify(sandboxToken)}, {
        ...options, fetchImpl: async url => {
          if (!url.startsWith('https://api.storekit-sandbox.apple.com/')) throw new Error('wrong Sandbox host');
          return Response.json(sandboxStatusWithoutAppId);
        } });
      let sandboxWrongAppIdsRejected = 0;
      for (const appAppleId of [42, 0, -1, '123456789', null]) {
        try { await resolveAppleEntitlement(dualEnvironment, ${JSON.stringify(sandboxToken)}, {
          ...options, fetchImpl: async () => Response.json({ ...sandboxStatusWithoutAppId, appAppleId }) }); }
        catch { sandboxWrongAppIdsRejected++; }
      }
      let productionWithoutAppIdRejected = false;
      try { await resolveAppleEntitlement(dualEnvironment, ${JSON.stringify(token)}, {
        ...options, fetchImpl: async () => Response.json(${JSON.stringify(response(token, { appAppleId: undefined }))}) }); }
      catch { productionWithoutAppIdRejected = true; }
      let defaultSandboxRejected = false;
      let defaultSandboxLookups = 0;
      try { await resolveAppleEntitlement(${JSON.stringify(env())}, ${JSON.stringify(sandboxToken)}, {
        ...options, fetchImpl: async () => { defaultSandboxLookups++; throw new Error('unexpected lookup'); } }); }
      catch { defaultSandboxRejected = true; }
      const grace = await resolveAppleEntitlement(${JSON.stringify(env())}, ${JSON.stringify(token)}, {
        ...options, fetchImpl: async () => Response.json(${JSON.stringify(graceStatus)}) });
      let tamperedRejected = false;
      try { await resolveAppleEntitlement(${JSON.stringify(env())}, ${JSON.stringify(segments.join('.'))}, options); }
      catch { tamperedRejected = true; }
      return Response.json({ valid, grace, productionOptIn, sandbox, sandboxWithoutAppId,
        sandboxWrongAppIdsRejected, productionWithoutAppIdRejected, defaultSandboxRejected, defaultSandboxLookups, tamperedRejected });
    } };`;
  await writeFile(join(directory, 'fixture-worker.js'), source);
  await writeFile(join(directory, 'wrangler.json'), JSON.stringify({
    name: 'nshoptor-apple-test-only', main: 'fixture-worker.js', compatibility_date: '2026-10-01',
  }));
  // A dry-run only: no credentials, network bindings, or deployment.
  const bundle = join(directory, 'bundle');
  const output = execFileSync(process.execPath, [join(serverRoot, 'node_modules/wrangler/bin/wrangler.js'),
    'deploy', '--dry-run', '--config', join(directory, 'wrangler.json'), '--outdir', bundle], {
    cwd: serverRoot, encoding: 'utf8', env: { ...process.env, WRANGLER_SEND_METRICS: 'false' },
  });
  console.log(output);
  const contents = await readFile(join(bundle, 'fixture-worker.js'), 'utf8');
  // Match the exact Miniflare runtime bundled by the stable Wrangler version;
  // this exercises production's actual October date and automatic Node support.
  runtime = new Miniflare({ workers: [{ config: {
    name: 'apple-test-only', compatibilityDate: '2026-10-01',
    manifest: { mainModule: 'fixture-worker.js', modules: { 'fixture-worker.js': { type: 'esm', contents } } },
  } }] });
  const result = await runtime.dispatchFetch('https://test/verify');
  assert.equal(result.status, 200);
  const outcome = await result.json();
  assert.equal(outcome.valid.tier, 'pro');
  assert.equal(outcome.valid.policy, 'pro-v2');
  assert.equal(outcome.grace.policy, 'pro-v2');
  assert.equal(outcome.grace.identity, outcome.valid.identity);
  assert.match(outcome.valid.identity, /^apple:[a-f0-9]{64}$/);
  assert.deepEqual(outcome.productionOptIn, outcome.valid);
  assert.equal(outcome.sandbox.policy, 'pro-v2');
  assert.match(outcome.sandbox.identity, /^apple:[a-f0-9]{64}$/);
  assert.notEqual(outcome.sandbox.identity, outcome.valid.identity);
  assert.deepEqual(outcome.sandboxWithoutAppId, outcome.sandbox);
  assert.equal(outcome.sandboxWrongAppIdsRejected, 5);
  assert.equal(outcome.productionWithoutAppIdRejected, true);
  assert.equal(outcome.defaultSandboxRejected, true);
  assert.equal(outcome.defaultSandboxLookups, 0);
  assert.equal(outcome.tamperedRejected, true);
  console.log('PASS local workerd: official SignedDataVerifier validates transaction/grace signatures, rejects tampering/default Sandbox, binds status hosts/identities, permits only Sandbox appAppleId omission and rejects present wrong IDs.');
} finally {
  await runtime?.dispose();
  // Only remove the dedicated temporary directory created by this script.
  if (dirname(directory) === serverRoot && directory.startsWith(join(serverRoot, '.apple-runtime-'))) {
    await rm(directory, { recursive: true, force: true });
  }
}
