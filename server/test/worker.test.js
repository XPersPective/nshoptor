import test from 'node:test';
import assert from 'node:assert/strict';
import { handleAi } from '../src/worker.js';
import { tierFromSubscription, resolveTier } from '../src/play.js';

// D1 yerine yalnız kullanılan ifadeleri anlayan bellek içi sahte.
function fakeDb() {
  const usage = new Map(); const global = new Map(); const cache = new Map();
  const stmt = (sql, args = []) => ({
    bind: (...a) => stmt(sql, a),
    async first() {
      if (sql.startsWith('SELECT count FROM usage')) return usage.has(args.join('|')) ? { count: usage.get(args.join('|')) } : null;
      if (sql.startsWith('SELECT count FROM global_usage')) return global.has(args[0]) ? { count: global.get(args[0]) } : null;
      if (sql.startsWith('SELECT tier')) return cache.get(args[0]) ?? null;
      throw new Error('unexpected ' + sql);
    },
    async run() {
      if (sql.startsWith('INSERT INTO usage')) usage.set(args.join('|'), (usage.get(args.join('|')) ?? 0) + 1);
      else if (sql.startsWith('INSERT INTO global_usage')) global.set(args[0], (global.get(args[0]) ?? 0) + 1);
      else if (sql.startsWith('INSERT INTO entitlement_cache')) cache.set(args[0], { tier: args[1], expires_at: args[2] });
      else throw new Error('unexpected ' + sql);
    },
  });
  return { prepare: sql => stmt(sql), async batch(list) { for (const s of list) await s.run(); }, usage };
}

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
