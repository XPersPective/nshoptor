import test, { afterEach } from 'node:test';
import assert from 'node:assert/strict';
import { sqliteDb } from './sqlite_db.js';
import { handleAccess, handleAi } from '../src/worker.js';
import { registerTrial, observeTrial, TRIAL_MS } from '../src/trial.js';

const databases = [];
afterEach(() => { for (const db of databases.splice(0)) db.sqlite.close(); });
function makeEnv(overrides = {}) {
  const DB = sqliteDb(); databases.push(DB);
  return { DB, TRIAL_ENABLED: '1', AI_URL: 'https://ai.example', AI_KEY: 'test', AI_MODEL: 'm',
    QUOTA_FREE: '2', QUOTA_PRO: '3', QUOTA_MAX: '9', GLOBAL_DAILY: '100',
    MAX_INPUT_CHARS: '6000', PACKAGE_NAME: 'com.crazypenguin.nshoptor', GOOGLE_SA_JSON: '{}', ...overrides };
}
const ID = 'a'.repeat(32);
const req = (path, body) => new Request(`https://x${path}`, { method: 'POST',
  headers: { 'content-type': 'application/json' }, body: typeof body === 'string' ? body : JSON.stringify(body) });
const access = (id = ID, firstOpenedAt) => ({ installId: id, ...(firstOpenedAt === undefined ? {} : { firstOpenedAt }) });
const ai = () => req('/v1/ai', { installId: ID, task: 'parse_list', input: { text: 'milk' } });
const goodReply = async () => new Response(JSON.stringify({ choices: [{ message: { content: '{"items":[]}' } }] }));
const rows = db => db.sqlite.prepare('SELECT * FROM install_trials').all();

test('access requires enabled flag and validates the bounded registration request', async () => {
  const e = makeEnv({ TRIAL_ENABLED: '0' });
  assert.equal((await handleAccess(req('/v1/access', access()), e)).status, 404);
  e.TRIAL_ENABLED = '1';
  for (const body of [access('x'), access(ID.toUpperCase()), access(ID, -1), access(ID, 1.5), access(ID, Number.MAX_SAFE_INTEGER)]) {
    assert.equal((await handleAccess(req('/v1/access', body), e)).status, 400);
  }
  assert.equal((await handleAccess(req('/v1/access', 'x'.repeat(2049)), e)).status, 413);
  assert.equal(rows(e.DB).length, 0);
});

test('registration clamps future hints, keeps the earliest window, and observes the exact expiry boundary', async () => {
  const e = makeEnv();
  const now = 1_800_000_000_000;
  const future = await handleAccess(req('/v1/access', access(ID, now + 50_000)), e, { now: new Date(now) });
  assert.equal(future.status, 200);
  assert.deepEqual((await future.json()).trial, { startedAt: now, endsAt: now + TRIAL_MS, serverNow: now, active: true });

  const earlier = await handleAccess(req('/v1/access', access(ID, now - 100_000)), e, { now: new Date(now + 10_000) });
  assert.deepEqual((await earlier.json()).trial, {
    startedAt: now - 100_000, endsAt: now - 100_000 + TRIAL_MS, serverNow: now + 10_000, active: true,
  });
  const boundary = await observeTrial(e, ID, now - 100_000 + TRIAL_MS);
  assert.equal(boundary.active, false);
  assert.equal(boundary.serverNow, now - 100_000 + TRIAL_MS);
  assert.equal(rows(e.DB).length, 1);
});

test('rollback observations and concurrent repeated registrations cannot reopen or extend a trial', async () => {
  const e = makeEnv();
  const start = 1_700_000_000_000;
  await registerTrial(e, ID, start, start);
  await observeTrial(e, ID, start + TRIAL_MS);
  const reopened = await observeTrial(e, ID, start + 123);
  assert.equal(reopened.active, false);
  assert.equal(reopened.serverNow, start + TRIAL_MS);

  const results = await Promise.all(Array.from({ length: 12 }, (_, i) =>
    registerTrial(e, ID, start + i * 60_000, start + i * 60_000)));
  assert.equal(rows(e.DB).length, 1);
  for (const result of results) {
    assert.equal(result.startedAt, start);
    assert.equal(result.endsAt, start + TRIAL_MS);
  }
});

test('registration spends neither AI usage nor global budget', async () => {
  const e = makeEnv();
  const res = await handleAccess(req('/v1/access', access()), e, { now: new Date(1_700_000_000_000) });
  assert.equal(res.status, 200);
  assert.equal(e.DB.sqlite.prepare('SELECT COUNT(*) AS n FROM usage').get().n, 0);
  assert.equal(e.DB.sqlite.prepare('SELECT COUNT(*) AS n FROM global_usage').get().n, 0);
});

test('access storage failures return a generic 503', async () => {
  const e = makeEnv();
  e.DB.prepare = () => { throw new Error('private database error'); };
  const res = await handleAccess(req('/v1/access', access()), e);
  assert.equal(res.status, 503);
  assert.deepEqual(await res.json(), { error: 'busy' });
});

test('active trial uses the Pro monthly bucket; expiry preserves usage and UTC month change resets naturally', async () => {
  const e = makeEnv();
  const start = Date.UTC(2026, 0, 1);
  await registerTrial(e, ID, start, start);
  const fetchImpl = goodReply;
  for (let i = 0; i < 3; i++) {
    const res = await handleAi(ai(), e, { fetchImpl, now: new Date(start + i * 1000) });
    assert.equal(res.status, 200);
    assert.equal((await res.json()).tier, 'pro');
  }
  const fullTrial = await handleAi(ai(), e, { fetchImpl, now: new Date(start + 4_000) });
  assert.equal(fullTrial.status, 429);
  assert.deepEqual(await fullTrial.json(), { error: 'quota', tier: 'pro', limit: 3, used: 3 });

  const expired = start + TRIAL_MS;
  const afterExpiry = await handleAi(ai(), e, { fetchImpl, now: new Date(expired) });
  assert.equal(afterExpiry.status, 429);
  assert.deepEqual(await afterExpiry.json(), { error: 'quota', tier: 'free', limit: 2, used: 3 });
  const nextMonth = Date.UTC(2026, 1, 1);
  const reset = await handleAi(ai(), e, { fetchImpl, now: new Date(nextMonth) });
  assert.equal(reset.status, 200);
  assert.deepEqual(((await reset.json()).used), 1);
});

test('unregistered installs retain free quota; turning the trial flag off does not add allowance', async () => {
  const e = makeEnv();
  for (let i = 0; i < 2; i++) assert.equal((await handleAi(ai(), e, { fetchImpl: goodReply })).status, 200);
  const blocked = await handleAi(ai(), e, { fetchImpl: goodReply });
  assert.equal(blocked.status, 429);
  assert.deepEqual(await blocked.json(), { error: 'quota', tier: 'free', limit: 2, used: 2 });
});
