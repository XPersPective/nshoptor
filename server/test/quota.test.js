import test from 'node:test';
import assert from 'node:assert/strict';
import { consume, tierLimit } from '../src/quota.js';
import { sha256Hex, resolveEntitlement, tierFromSubscription } from '../src/play.js';
import { handleAi } from '../src/worker.js';
import { sqliteDb } from './sqlite_db.js';

const now = new Date('2026-10-10T12:00:00Z');
const env = t => { const DB = sqliteDb(); t.after(() => DB.sqlite.close());
  return { DB, QUOTA_FREE: 10, QUOTA_PRO: 100, QUOTA_MAX: 300, GLOBAL_DAILY: 20,
    AI_URL: 'https://test', AI_KEY: 'test', AI_MODEL: 'test' }; };
const count = (e, table) => e.DB.sqlite.prepare(`SELECT SUM(count) AS total FROM ${table}`).get().total ?? 0;

test('parallel last user slot has one winner; rejected user does not consume global', async t => {
  const e = env(t);
  e.DB.sqlite.exec("INSERT INTO usage VALUES('x', '2026-10', 9)");
  const claims = await Promise.all([consume(e, 'x', 'free', now), consume(e, 'x', 'free', now)]);
  assert.equal(claims.filter(c => c.ok).length, 1);
  assert.equal(count(e, 'usage'), 10); assert.equal(count(e, 'global_usage'), 1);
  assert.equal(claims.find(c => !c.ok).reason, 'quota');
});

test('parallel last global slot has one winner and no losing user increment', async t => {
  const e = env(t); e.GLOBAL_DAILY = 1;
  const claims = await Promise.all([consume(e, 'x', 'free', now), consume(e, 'y', 'free', now)]);
  assert.equal(claims.filter(c => c.ok).length, 1);
  assert.equal(count(e, 'usage'), 1); assert.equal(count(e, 'global_usage'), 1);
  assert.equal(claims.find(c => !c.ok).reason, 'busy');
});

test('global write failure rolls back user claim and seed rows', async t => {
  const e = env(t);
  e.DB.sqlite.exec("CREATE TRIGGER fail_global BEFORE UPDATE ON global_usage BEGIN SELECT RAISE(ABORT, 'injected'); END");
  await assert.rejects(consume(e, 'x', 'free', now));
  assert.equal(count(e, 'usage'), 0); assert.equal(count(e, 'global_usage'), 0);
  e.DB.sqlite.exec('DROP TRIGGER fail_global');
  assert.equal((await consume(e, 'x', 'free', now)).used, 1);
});

test('new month resets only monthly usage; invalid caps fail closed', async t => {
  const e = env(t); e.QUOTA_FREE = 1;
  await consume(e, 'x', 'free', now);
  assert.equal((await consume(e, 'x', 'free', new Date('2026-11-01T00:00:00Z'))).used, 1);
  for (const bad of [0, -1, 'bad', 1.5, Infinity]) {
    e.GLOBAL_DAILY = bad; await assert.rejects(consume(e, 'z', 'free', now));
  }
  assert.equal(count(e, 'usage'), 2);
  assert.equal(tierLimit(e, 'pro'), 200); assert.equal(tierLimit(e, 'max'), 1000);
  assert.equal(tierLimit(e, 'pro-v2'), 100); assert.equal(tierLimit(e, 'max-v2'), 300);
});

test('paid token cache policy shares reservation across installs; migrate current old usage once', async t => {
  const e = env(t), token = 'purchase-token-'.repeat(3), hash = await sha256Hex(token);
  e.DB.sqlite.prepare('INSERT INTO entitlement_cache VALUES(?, ?, ?)').run(hash, 'pro-v2', now.getTime() + 3600000);
  const a = 'a'.repeat(32), b = 'b'.repeat(32);
  e.DB.sqlite.prepare('INSERT INTO usage VALUES(?, ?, ?)').run(a, '2026-10', 98);
  const request = id => new Request('https://x/v1/ai', { method: 'POST', body: JSON.stringify({
    installId: id, purchaseToken: token, task: 'parse_list', input: { text: 'milk' } }) });
  const fetchImpl = async () => new Response(JSON.stringify({ choices: [{ finish_reason: 'stop', message: { content: '{"items":[]}' } }] }));
  assert.equal((await handleAi(request(a), e, { now, fetchImpl })).status, 200);
  assert.equal((await handleAi(request(b), e, { now, fetchImpl })).status, 200);
  const blocked = await handleAi(request(b), e, { now, fetchImpl });
  assert.equal(blocked.status, 429); assert.equal((await blocked.json()).used, 100);
  assert.equal(count(e, 'global_usage'), 2);
  const entitlement = await resolveEntitlement(e, token, { now: now.getTime() });
  assert.equal(entitlement.identity, 'paid:' + hash); assert.equal(entitlement.tier, 'pro');
  e.DB.sqlite.prepare('UPDATE entitlement_cache SET tier = ?').run('pro');
  assert.equal((await resolveEntitlement(e, token, { now: now.getTime() })).policy, 'pro');
  e.DB.sqlite.prepare('UPDATE entitlement_cache SET tier = ?').run('admin');
  assert.equal((await resolveEntitlement(e, token, { now: now.getTime() })).tier, 'free');
});

test('cancelled renewal retains future paid expiry; winner uses its own expiry', () => {
  const sub = { subscriptionState: 'SUBSCRIPTION_STATE_CANCELED', lineItems: [
    { productId: 'nshoptor_max_v2', expiryTime: '2026-10-11T12:00:00Z' },
    { productId: 'nshoptor_pro', expiryTime: '2027-10-10T12:00:00Z' } ] };
  const best = tierFromSubscription(sub, now.getTime());
  assert.equal(best.policy, 'max-v2'); assert.equal(best.expiresAt, Date.parse(sub.lineItems[0].expiryTime));
  for (const state of ['SUBSCRIPTION_STATE_EXPIRED', 'SUBSCRIPTION_STATE_ON_HOLD', 'SUBSCRIPTION_STATE_PAUSED', 'SUBSCRIPTION_STATE_PENDING']) {
    assert.equal(tierFromSubscription({ ...sub, subscriptionState: state }, now.getTime()).tier, 'free');
  }
  assert.equal(tierFromSubscription(sub, Date.parse('2028-01-01')).tier, 'free');
});


test('Play verification maps v2 and caches no longer than its winning expiry', async t => {
  const e = env(t), token = 'real-verification-test-token-123';
  const keys = await crypto.subtle.generateKey({ name: 'RSASSA-PKCS1-v1_5', modulusLength: 2048,
    publicExponent: new Uint8Array([1, 0, 1]), hash: 'SHA-256' }, true, ['sign', 'verify']);
  const der = await crypto.subtle.exportKey('pkcs8', keys.privateKey);
  e.GOOGLE_SA_JSON = JSON.stringify({ client_email: 'test@example.invalid', private_key:
    '-----BEGIN PRIVATE KEY-----\n' + Buffer.from(der).toString('base64') + '\n-----END PRIVATE KEY-----' });
  e.PACKAGE_NAME = 'com.crazypenguin.nshoptor';
  let calls = 0;
  const expiry = new Date(now.getTime() + 600000).toISOString();
  const fetchImpl = async url => { calls++;
    return new Response(JSON.stringify(url.includes('oauth2') ? { access_token: 'synthetic' } : {
      subscriptionState: 'SUBSCRIPTION_STATE_ACTIVE', lineItems: [{ productId: 'nshoptor_max_v2', expiryTime: expiry }] })); };
  const result = await resolveEntitlement(e, token, { now: now.getTime(), fetchImpl });
  assert.equal(result.policy, 'max-v2'); assert.equal(result.tier, 'max'); assert.equal(calls, 2);
  assert.equal((await resolveEntitlement(e, token, { now: now.getTime(), fetchImpl })).identity, result.identity);
  assert.equal(calls, 2);
  assert.equal(e.DB.sqlite.prepare('SELECT expires_at FROM entitlement_cache').get().expires_at, Date.parse(expiry));
});
