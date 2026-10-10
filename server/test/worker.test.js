import test, { afterEach } from 'node:test';
import { sqliteDb } from './sqlite_db.js';
import assert from 'node:assert/strict';
import { handleAi } from '../src/worker.js';
import { tierFromSubscription, resolveTier } from '../src/play.js';

const databases = [];
afterEach(() => { for (const db of databases.splice(0)) db.sqlite.close(); });
function fakeDb() { const db = sqliteDb(); databases.push(db); return db; }

const env = () => ({
  DB: fakeDb(), AI_URL: 'https://ai.example', AI_KEY: 'k', AI_MODEL: 'm',
  QUOTA_FREE: '2', QUOTA_PRO: '5', QUOTA_MAX: '9', GLOBAL_DAILY: '100',
  MAX_INPUT_CHARS: '6000', PACKAGE_NAME: 'com.crazypenguin.nshoptor',
  GOOGLE_SA_JSON: '{}',
});
const ID = 'a'.repeat(32);
const req = (body, headers = {}) => new Request('https://x/v1/ai', {
  method: 'POST', headers, body: typeof body === 'string' ? body : JSON.stringify(body) });
const aiReply = content => async () => new Response(JSON.stringify({ choices: [{ message: { content: JSON.stringify(content) } }] }));

test('geçersiz kurulum kimliği 400', async () => {
  const res = await handleAi(req({ installId: 'x', task: 'parse_list', input: { text: 'elma' } }), env());
  assert.equal(res.status, 400);
  const array = await handleAi(req({ installId: [ID], task: 'parse_list', input: { text: 'milk' } }), env());
  assert.equal(array.status, 400);
});

test('büyük gövde 413', async () => {
  const res = await handleAi(req('x'.repeat(17 * 1024)), env());
  assert.equal(res.status, 413);
});

test('ücretsiz kota dolunca 429', async () => {
  const e = env();
  const fetchImpl = aiReply({ items: [{ name: 'elma', quantity: '1', unit: 'kilogram', estimatedPrice: '20' }] });
  const body = { installId: ID, task: 'parse_list', input: { text: '1 kilo elma 20 lira' } };
  assert.equal((await handleAi(req(body), e, { fetchImpl })).status, 200);
  assert.equal((await handleAi(req(body), e, { fetchImpl })).status, 200);
  const third = await handleAi(req(body), e, { fetchImpl });
  assert.equal(third.status, 429);
  assert.deepEqual(await third.json(), { error: 'quota', tier: 'free', limit: 2, used: 2 });
});

test('parse_list çıktısı temizlenir: bilinmeyen birim ve uydurma alanlar atılır', async () => {
  const fetchImpl = aiReply({ items: [
    { name: ' elma ', quantity: '1,5', unit: 'kilogram', estimatedPrice: '20', hack: true },
    { name: 'ekmek', quantity: 'iki', unit: 'loaf', estimatedPrice: null },
  ] });
  const res = await handleAi(req({ installId: ID, task: 'parse_list', input: { text: 'x' } }), env(), { fetchImpl });
  const { result } = await res.json();
  assert.deepEqual(result.items, [
    { name: 'elma', brand: null, category: null, quantity: '1.5', unit: 'kilogram', estimatedPrice: '20', priceIsUnitPrice: false },
    { name: 'ekmek', brand: null, category: null, quantity: null, unit: null, estimatedPrice: null, priceIsUnitPrice: false },
  ]);
});

test('match_receipt yalnız gerçek plan kimliklerine izin verir', async () => {
  const fetchImpl = aiReply({ matches: [
    { i: 0, plannedId: 7, confidence: 'high', isDiscount: true },
    { i: 1, plannedId: 999, confidence: 'high' },
  ] });
  const input = { lines: [{ i: 0, text: 'INDIRIMLI ELMA', total: '30' }, { i: 1, text: 'POSET', total: '1' }], planned: [{ id: 7, name: 'elma' }] };
  const res = await handleAi(req({ installId: ID, task: 'match_receipt', input }), env(), { fetchImpl });
  const { result } = await res.json();
  assert.deepEqual(result.matches, [
    { i: 0, plannedId: 7, confidence: 'high', isDiscount: true },
    { i: 1, plannedId: null, confidence: 'high', isDiscount: false },
  ]);
});

test('Play doğrulaması başarısızsa ücretsiz (asla yükseltme yok)', async () => {
  const e = env();
  e.GOOGLE_SA_JSON = 'not json';
  assert.equal(await resolveTier(e, 'x'.repeat(40)), 'free');
  const fetchImpl = aiReply({ items: [] });
  const res = await handleAi(req({ installId: ID, task: 'parse_list', input: { text: 'elma' }, purchaseToken: 'x'.repeat(40) }), e, { fetchImpl });
  assert.equal((await res.json()).tier, 'free');
});

test('abonelik durumu katmana çevrilir', () => {
  const future = new Date(Date.now() + 86400_000).toISOString();
  assert.equal(tierFromSubscription({ subscriptionState: 'SUBSCRIPTION_STATE_ACTIVE', lineItems: [{ productId: 'nshoptor_pro', expiryTime: future }] }).tier, 'pro');
  assert.equal(tierFromSubscription({ subscriptionState: 'SUBSCRIPTION_STATE_ACTIVE', lineItems: [{ productId: 'nshoptor_max', expiryTime: future }] }).tier, 'max');
  assert.equal(tierFromSubscription({ subscriptionState: 'SUBSCRIPTION_STATE_EXPIRED', lineItems: [{ productId: 'nshoptor_max', expiryTime: future }] }).tier, 'free');
  assert.equal(tierFromSubscription({ subscriptionState: 'SUBSCRIPTION_STATE_ACTIVE', lineItems: [{ productId: 'other', expiryTime: future }] }).tier, 'free');
});

test('model JSON dışı yanıt verirse 502', async () => {
  const fetchImpl = async () => new Response(JSON.stringify({ choices: [{ message: { content: 'merhaba' } }] }));
  const res = await handleAi(req({ installId: ID, task: 'parse_list', input: { text: 'elma' } }), env(), { fetchImpl });
  assert.equal(res.status, 502);
});

test('parse_list preserves bounded title/brand/category and unit-price meaning', async () => {
  const fetchImpl = aiReply({ title: ' Weekend ', items: [
    { name: 'Apples', brand: ' Farm ', category: 'produce', quantity: '2', unit: 'kilogram', estimatedPrice: '40', priceIsUnitPrice: true },
    { name: 'Bread', brand: { bad: true }, category: 'x'.repeat(100), quantity: '-1', estimatedPrice: '1e6', priceIsUnitPrice: 'true' },
  ] });
  const res = await handleAi(req({ installId: ID, task: 'parse_list', input: { text: 'x' } }), env(), { fetchImpl });
  const { result } = await res.json();
  assert.equal(result.title, 'Weekend');
  assert.deepEqual(result.items[0], { name: 'Apples', brand: 'Farm', category: 'produce', quantity: '2', unit: 'kilogram', estimatedPrice: '40', priceIsUnitPrice: true });
  assert.equal(result.items[1].brand, null); assert.equal(result.items[1].category.length, 60);
  assert.equal(result.items[1].quantity, null); assert.equal(result.items[1].estimatedPrice, null);
  assert.equal(result.items[1].priceIsUnitPrice, false);
});

const valid = { installId: ID, task: 'parse_list', input: { text: 'milk' } };
const reserved = e => e.DB.sqlite.prepare('SELECT SUM(count) AS total FROM global_usage').get().total ?? 0;

test('chunked UTF8 body is byte-bounded; invalid and oversized input never reserve', async () => {
  const e = env();
  const encoded = new TextEncoder().encode(JSON.stringify({ ...valid, input: { text: 'é'.repeat(9000) } }));
  const stream = new ReadableStream({ start(controller) {
    for (let i = 0; i < encoded.length; i += 1024) controller.enqueue(encoded.slice(i, i + 1024));
    controller.close();
  } });
  const chunked = new Request('https://x/v1/ai', { method: 'POST', body: stream, duplex: 'half' });
  assert.equal((await handleAi(chunked, e)).status, 413);
  for (const body of [ { ...valid, task: '__proto__' }, { ...valid, input: { text: 'x'.repeat(2001) } },
    { ...valid, task: 'match_receipt', input: { lines: Array(121).fill({ i: 0, text: 'x' }), planned: [{ id: 1, name: 'x' }] } } ]) {
    assert.equal((await handleAi(req(body), e)).status, 400);
  }
  assert.equal(reserved(e), 0);
});

test('missing provider and failing DB fail closed without upstream call', async () => {
  const e = env(); let calls = 0;
  const fetchImpl = async () => { calls++; throw new Error('must not call'); };
  e.AI_KEY = '';
  assert.equal((await handleAi(req(valid), e, { fetchImpl })).status, 503);
  assert.equal(reserved(e), 0);
  e.AI_KEY = 'test';
  e.DB.batch = async () => { throw new Error('private database details'); };
  const failed = await handleAi(req(valid), e, { fetchImpl });
  assert.equal(failed.status, 503); assert.deepEqual(await failed.json(), { error: 'busy' });
  assert.equal(calls, 0);
});

test('accepted provider failure consumes one reservation; truncated valid JSON is never success', async () => {
  for (const finish_reason of ['length', 'content_filter']) {
    const e = env();
    const fetchImpl = async () => new Response(JSON.stringify({ choices: [{ finish_reason, message: { content: '{"items":[]}' } }] }));
    assert.equal((await handleAi(req(valid), e, { fetchImpl })).status, 502);
    assert.equal(reserved(e), 1);
  }
});

test('bounded response, schema and cardinality reject partial outputs', async () => {
  for (const reply of [{ bad: true }, { items: [{ name: '' }] }, { items: Array(41).fill({ name: 'milk' }) }]) {
    const e = env();
    assert.equal((await handleAi(req(valid), e, { fetchImpl: aiReply(reply) })).status, 502);
  }
  const e = env();
  assert.equal((await handleAi(req(valid), e, { fetchImpl: async () => new Response('x'.repeat(65537)) })).status, 502);
  const input = { lines: [{ i: 0, text: 'A' }, { i: 1, text: 'B' }], planned: [{ id: 1, name: 'milk' }] };
  const f = env();
  assert.equal((await handleAi(req({ ...valid, task: 'match_receipt', input }), f,
    { fetchImpl: aiReply({ matches: [{ i: 0, plannedId: 1 }] }) })).status, 502);
});

test('each task sends its bounded output allowance to the current provider', async () => {
  const cases = [
    ['parse_list', { text: 'milk' }, { items: [] }, 4096],
    ['read_label', { text: 'MILK 20' }, { price: '20', unitPrice: null }, 512],
    ['match_receipt', { lines: [{ i: 0, text: 'A' }], planned: [{ id: 1, name: 'milk' }] },
      { matches: [{ i: 0, plannedId: null }] }, 8192],
  ];
  for (const [task, input, out, limit] of cases) {
    const e = env();
    const fetchImpl = async (_, init) => { assert.equal(JSON.parse(init.body).max_tokens, limit); return aiReply(out)(); };
    assert.equal((await handleAi(req({ ...valid, task, input }), e, { fetchImpl })).status, 200);
  }
});
