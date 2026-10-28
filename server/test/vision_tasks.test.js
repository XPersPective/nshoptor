import test, { afterEach } from 'node:test';
import assert from 'node:assert/strict';
import { sqliteDb } from './sqlite_db.js';
import { handleAi } from '../src/worker.js';
import { VISION_TASKS } from '../src/vision_tasks.js';

const R = VISION_TASKS.read_receipt_image;
const L = VISION_TASKS.read_label_image;
const JPEG = '/9j/' + 'A'.repeat(400);

const receipt = () => ({
  schema: 2, status: 'complete', store: 'ŞOK MARKETLER', date: '2024-02-01', time: '20:51:41',
  documentNumber: '0259', currency: 'TRY',
  items: [
    { name: 'OZMO FUN 23G', quantity: null, unit: null, unitPrice: null, lineTotal: '13.50' },
    { name: 'PİLİÇ BAGET', quantity: '1.033', unit: 'kilogram', unitPrice: '99.00', lineTotal: '102.27' },
    { name: 'FINISH QUANTUM', quantity: null, unit: null, unitPrice: null, lineTotal: '259.00' },
  ],
  discounts: [{ label: '25TLFINISH110TL', amount: '149.00' }],
  tax: '46.60', subtotal: null, total: '225.77',
});

test('receipt image input accepts 1-4 base64 JPEG photos only', () => {
  assert.deepEqual(R.validate({ images: [JPEG], currency: 'try' }), { images: [JPEG], currency: 'TRY' });
  for (const images of [[], [JPEG, JPEG, JPEG, JPEG, JPEG], ['iVBORw0KGgo='], [JPEG + '!'], ['/9j/' + 'A'.repeat(1_000_001)], 'x', [1]]) {
    assert.equal(R.validate({ images }), null);
  }
  assert.equal(L.validate({ images: [JPEG, JPEG] }), null);
});

test('a complete receipt must reconcile exactly and keep each row arithmetic', () => {
  const out = R.clean(receipt());
  assert.equal(out.status, 'complete');
  assert.equal(out.items[1].quantity, '1.033');
  assert.equal(out.reconciles, true);
  const bad = [
    o => { o.total = '225.78'; },
    o => { o.items[1].lineTotal = '103.27'; o.total = '226.77'; },
    o => { o.items[0].lineTotal = '13,50'; },
    o => { o.items = []; },
    o => { o.total = null; },
    o => { o.discounts = [{ amount: '-149' }]; },
    o => { o.schema = 1; },
    o => { o.status = 'done'; },
    o => { o.tax = '999.00'; },
  ];
  for (const mutate of bad) { const o = receipt(); mutate(o); assert.throws(() => R.clean(o)); }
});

test('net-priced receipts reconcile without deducting printed discount summaries twice', () => {
  const o = receipt();
  o.items[2].lineTotal = '110.00';
  o.total = '225.77';
  const out = R.clean(o);
  assert.deepEqual(out.discounts, []);
});

test('partial or unusable photos return only the status the app needs to guide the user', () => {
  for (const status of ['top_missing', 'bottom_missing', 'middle_gap', 'not_receipt', 'unreadable']) {
    const out = R.clean({ ...receipt(), status, items: 'garbage', total: 'x' });
    assert.equal(out.status, status);
    assert.deepEqual(out.items, []);
    assert.equal(out.total, null);
  }
});

test('labels require a price and a supported unit basis', () => {
  assert.deepEqual(L.clean({ schema: 1, status: 'ok', productName: 'Milk', price: '42.50', unitPrice: '42.50', unit: 'litre', currency: 'TRY' }),
    { schema: 1, status: 'ok', productName: 'Milk', price: '42.50', unitPrice: '42.50', unit: 'litre', currency: 'TRY' });
  assert.equal(L.clean({ schema: 1, status: 'ok', price: '10', unitPrice: '5', unit: 'parsec' }).unitPrice, null);
  assert.throws(() => L.clean({ schema: 1, status: 'ok', price: null, unitPrice: null }), /missing_price/);
  assert.equal(L.clean({ schema: 1, status: 'unreadable', price: '9' }).price, null);
});

const databases = [];
afterEach(() => { for (const db of databases.splice(0)) db.sqlite.close(); });
const env = () => {
  const DB = sqliteDb(); databases.push(DB);
  return { DB, AI_URL: 'https://ai.example', AI_KEY: 'k', AI_MODEL: 'text-model', AI_VISION_MODEL: 'vision-model',
    QUOTA_FREE: '5', QUOTA_PRO: '5', QUOTA_MAX: '9', GLOBAL_DAILY: '100', MAX_INPUT_CHARS: '6000',
    PACKAGE_NAME: 'com.crazypenguin.nshoptor', GOOGLE_SA_JSON: '{}' };
};
const req = body => new Request('https://x/v1/ai', { method: 'POST', body: JSON.stringify(body) });
const ID = 'b'.repeat(32);

test('image tasks use the vision model, carry photos and retry once without a second charge', async () => {
  const e = env();
  const calls = [];
  const answers = [{ ...receipt(), total: '1.00' }, receipt()];
  const fetchImpl = async (_, init) => {
    const body = JSON.parse(init.body);
    calls.push(body);
    return new Response(JSON.stringify({ choices: [{ message: { content: JSON.stringify(answers[calls.length - 1]) } }] }));
  };
  const big = '/9j/' + 'A'.repeat(600_000);
  const res = await handleAi(req({ installId: ID, task: 'read_receipt_image', input: { images: [big, JPEG] } }), e, { fetchImpl });
  assert.equal(res.status, 200);
  const json = await res.json();
  assert.equal(json.used, 1);
  assert.equal(json.result.total, '225.77');
  assert.equal(calls.length, 2);
  assert.equal(calls[0].model, 'vision-model');
  assert.equal(calls[0].messages[1].content.filter(p => p.type === 'image_url').length, 2);
  assert.match(calls[1].messages[0].content, /rejected by validation \(not_reconciled\)/);
});

test('a second invalid answer fails with a reason; text tasks keep their 16 KiB envelope', async () => {
  const e = env();
  const fetchImpl = async () => new Response(JSON.stringify({ choices: [{ message: { content: '{"schema":2,"status":"complete","items":[]}' } }] }));
  const res = await handleAi(req({ installId: ID, task: 'read_receipt_image', input: { images: [JPEG] } }), e, { fetchImpl });
  assert.equal(res.status, 502);
  assert.deepEqual(await res.json(), { error: 'bad_model_output', reason: 'invalid_items' });
  const text = await handleAi(req({ installId: ID, task: 'parse_list', input: { text: 'x' }, pad: 'p'.repeat(20_000) }), e, { fetchImpl });
  assert.equal(text.status, 413);
});
