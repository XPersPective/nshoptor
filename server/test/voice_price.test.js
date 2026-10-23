import assert from 'node:assert/strict';
import test from 'node:test';
import { readFileSync } from 'node:fs';
import { TASKS } from '../src/tasks.js';
import { CURRENCY_CODES } from '../src/currencies.js';

const parsed = (source, item) => TASKS.parse_list.clean({ items: [item] }, { text: source, priceSemanticsVersion: 1 }).items[0];
const item = { name: 'sigara', quantity: '2', unit: 'package', estimatedPrice: '260', currencyCode: 'TRY' };

test('supported currency table stays aligned with the Flutter money core', () => {
  const dart = readFileSync(new URL('../../lib/core/money/currency.dart', import.meta.url), 'utf8');
  const codes = [...dart.matchAll(/'([A-Z]{3})':/g)].map(m => m[1]);
  assert.deepEqual([...CURRENCY_CODES].sort(), [...new Set(codes)].sort());
});

test('spoken money remains unresolved without explicit source evidence', () => {
  for (const priceIsUnitPrice of [false, true, null, 'true']) {
    const result = parsed('iki paket sigara 260 TL', { ...item, priceIsUnitPrice });
    assert.equal(result.priceIsUnitPrice, null);
    assert.equal(result.estimatedPrice, '260');
    assert.equal(result.currencyCode, 'TRY');
  }
});

test('unit and total cues require a matching literal clause and boolean', () => {
  const total = 'markette iki paket sigara toplam 260 TL';
  const unit = 'iki paket sigara tanesi 130 TL';
  assert.equal(parsed(total, { ...item, priceEvidence: total, priceIsUnitPrice: false }).priceIsUnitPrice, false);
  assert.equal(parsed(unit, { ...item, estimatedPrice: '130', priceEvidence: unit, priceIsUnitPrice: true }).priceIsUnitPrice, true);
  assert.equal(parsed(total, { ...item, priceEvidence: total, priceIsUnitPrice: true }).priceIsUnitPrice, null);
  assert.equal(parsed(total, { ...item, priceEvidence: unit, priceIsUnitPrice: true }).priceIsUnitPrice, null);
  assert.equal(parsed('iki paket süt toplam 260 TL', { ...item, priceEvidence: 'iki paket süt toplam 260 TL', priceIsUnitPrice: false }).priceIsUnitPrice, null);
});

test('actual destination needs market context in the item evidence', () => {
  const source = 'markette iki paket sigara toplam 260 TL';
  assert.equal(parsed(source, { ...item, priceEvidence: source, priceDestination: 'actual' }).priceDestination, 'actual');
  assert.equal(parsed(source, { ...item, priceEvidence: 'iki paket sigara toplam 260 TL', priceDestination: 'actual' }).priceDestination, 'planned');
  assert.equal(parsed('iki paket sigara toplam 260 TL', { ...item, priceEvidence: source, priceDestination: 'actual' }).priceDestination, 'planned');
});

test('quoted price cue never approves a different model amount', () => {
  const unit = 'iki paket sigara tanesi 130 TL';
  assert.equal(parsed(unit, { ...item, priceEvidence: unit, priceIsUnitPrice: true }).priceIsUnitPrice, null);
  const total = 'iki paket sigara toplam fiyatı 1.260,50 TL';
  assert.equal(parsed(total, { ...item, estimatedPrice: '1260.50', priceEvidence: total, priceIsUnitPrice: false }).priceIsUnitPrice, false);
  assert.equal(parsed(total, { ...item, estimatedPrice: '1260.51', priceEvidence: total, priceIsUnitPrice: false }).priceIsUnitPrice, null);
});

test('model numeric amounts normalize safely; another product price stays unresolved', () => {
  const total = 'iki paket sigara toplam 260 TL';
  assert.equal(parsed(total, { ...item, estimatedPrice: 260, priceEvidence: total, priceIsUnitPrice: false }).priceIsUnitPrice, false);
  for (const evidence of ['sigara tanesi 130 TL, makarna tanesi 25 TL', 'sigara tanesi 130 TL, makarna', 'sigara ve makarna tanesi 130 TL']) {
    assert.equal(parsed(evidence, { ...item, name: 'makarna', estimatedPrice: '130', priceEvidence: evidence, priceIsUnitPrice: true }).priceIsUnitPrice, null);
  }
});

test('literal currency overrides invented or omitted model currency', () => {
  const source = 'sigara toplam 260 TL';
  for (const currencyCode of ['EUR', null, undefined]) {
    assert.equal(parsed(source, { ...item, currencyCode, priceEvidence: source }).currencyCode, 'TRY');
  }
  assert.throws(() => parsed('sigara toplam 260', { ...item, currencyCode: 'EUR' }), /unverified_currency/);
  assert.throws(() => parsed('sigara 260 TL ve süt 20 EUR', item), /ambiguous_currency/);
});

test('spoken aliases and lowercase codes survive omitted model currencies', () => {
  for (const [spoken, code] of [['dolar', 'USD'], ['avro', 'EUR'], ['sterlin', 'GBP'], ['usd', 'USD']]) {
    assert.equal(parsed(`sigara toplam 260 ${spoken}`, { ...item, currencyCode: null }).currencyCode, code);
  }
  assert.throws(() => parsed('sigara 260 TL ve süt toplam 20 dolar', { ...item, name: 'süt', currencyCode: null }), /ambiguous_currency/);
  for (const spoken of ['frank', 'kanada doları']) {
    assert.throws(() => parsed(`sigara toplam 260 ${spoken}`, { ...item, currencyCode: null }), /unverified_currency/);
  }
  assert.throws(() => parsed('sigara 260 TL ve süt toplam 20 yuan', { ...item, name: 'süt', currencyCode: null }), /unverified_currency/);
  assert.throws(() => parsed('sigara 260 TL ve süt toplam $20', { ...item, name: 'süt', currencyCode: null }), /unverified_currency/);
});

test('legacy clients never receive prices that need new confirmation/currency/destination handling', () => {
  const source = 'sigara toplam 260 TL';
  const result = TASKS.parse_list.clean({ items: [{ ...item, priceEvidence: source, priceIsUnitPrice: false }] }, { text: source });
  assert.equal(result.items[0].estimatedPrice, null);
  assert.equal(result.items[0].name, 'sigara');
});
