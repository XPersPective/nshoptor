import assert from 'node:assert/strict';
import test from 'node:test';
import { TASKS } from '../src/tasks.js';

const parse = (source, item) => TASKS.parse_list.clean({ items: [item] }, {
  text: source, priceSemanticsVersion: 2,
}).items[0];

test('compact shelf-style unit prices retain their explicit basis independently from purchased quantity', () => {
  for (const [suffix, basis] of [['kg', 'kilogram'], ['g', 'gram'], ['litre', 'litre'], ['ml', 'millilitre'], ['pack', 'package']]) {
    const source = `400 gram meat 875 USD/${suffix}`;
    const result = parse(source, { name: 'meat', quantity: '400', unit: 'gram',
      estimatedPrice: '875', priceEvidence: source, priceIsUnitPrice: true });
    assert.equal(result.priceIsUnitPrice, true, suffix);
    assert.equal(result.priceUnitCode, basis, suffix);
    assert.equal(result.quantity, '400');
    assert.equal(result.unit, 'gram');
  }
});

test('compact unit cues cannot silently become line totals when the model omits the flag', () => {
  const source = '400 gram meat 875 USD/kg';
  const item = { name: 'meat', quantity: '400', unit: 'gram', estimatedPrice: '875' };
  assert.equal(parse(source, item).priceIsUnitPrice, true);
  assert.equal(parse(source, { ...item, priceIsUnitPrice: false }).priceIsUnitPrice, null);
  assert.equal(parse('400 gram meat total 875 USD/kg', item).priceIsUnitPrice, null);
  assert.equal(parse('400 gram meat 875 USD/unknown', item).priceIsUnitPrice, null);
});

test('receipt discounts preserve signed line totals sent by the app while quantities stay unsigned', () => {
  const input = TASKS.match_receipt.validate({ lines: [
    { i: 0, text: 'MILK', total: '40.00' },
    { i: 1, text: 'DISCOUNT', total: '-5,25' },
  ], planned: [{ id: 1, name: 'milk' }] });
  assert.equal(input.lines[1].total, '-5.25');
  assert.equal(input.lines[0].total, '40.00');
  assert.equal(parse('milk', { name: 'milk', quantity: '-5' }).quantity, null);
  for (const total of ['-1e2', '--5', '-Infinity', '-1.2345', {}]) {
    assert.equal(TASKS.match_receipt.validate({ lines: [{ i: 0, text: 'x', total }],
      planned: [{ id: 1, name: 'x' }] }).lines[0].total, null);
  }
});

test('malformed model numeric containers cannot become valid shopping amounts', () => {
  for (const malformed of [['20'], [20], { value: '20' }, true]) {
    const result = parse('milk 20 USD', { name: 'milk', quantity: malformed,
      estimatedPrice: malformed });
    assert.equal(result.quantity, null);
    assert.equal(result.estimatedPrice, null);
    assert.equal(result.priceIsUnitPrice, null);
  }
  const numeric = parse('milk 20 USD', { name: 'milk', quantity: 2, estimatedPrice: 20 });
  assert.equal(numeric.quantity, '2');
  assert.equal(numeric.estimatedPrice, '20');
});

test('receipt identities outside the JSON safe integer range fall back instead of matching a rounded ID', () => {
  const valid = { lines: [{ i: 0, text: 'milk', total: '20' }], planned: [{ id: 1, name: 'milk' }] };
  for (const id of [Number.MAX_SAFE_INTEGER + 1, 1e100]) {
    assert.equal(TASKS.match_receipt.validate({ ...valid, planned: [{ id, name: 'milk' }] }), null);
    assert.equal(TASKS.match_receipt.validate({ ...valid, lines: [{ i: id, text: 'milk' }] }), null);
  }
});

test('duplicate receipt rows and model matches cannot apply one suggestion twice', () => {
  const input = { lines: [{ i: 0, text: 'milk', total: '20' }, { i: 1, text: 'discount', total: '-2' }],
    planned: [{ id: 1, name: 'milk' }] };
  assert.equal(TASKS.match_receipt.validate({ ...input, lines: [input.lines[0], input.lines[0]] }), null);
  assert.equal(TASKS.match_receipt.validate({ ...input, planned: [input.planned[0], input.planned[0]] }), null);
  const validated = TASKS.match_receipt.validate(input);
  assert.equal(JSON.parse(TASKS.match_receipt.user(validated)).lines[1].total, '-2');
  assert.throws(() => TASKS.match_receipt.clean({ matches: [
    { i: 0, plannedId: 1 }, { i: 0, plannedId: 1 },
  ] }, validated), /incomplete_matches/);
  assert.throws(() => TASKS.match_receipt.clean({ matches: [
    { i: 0, plannedId: 1 }, { i: 99, plannedId: 1 },
  ] }, validated), /incomplete_matches/);
});

test('malformed shelf amounts are unknown and do not replace the local OCR candidates', () => {
  const result = TASKS.read_label.clean({ productName: 'milk', price: ['20'], unitPrice: [40], unit: 'litre' });
  assert.equal(result.price, null);
  assert.equal(result.unitPrice, null);
  assert.throws(() => TASKS.read_label.clean({ productName: 'milk', price: '20' }), /invalid_label/);
});
