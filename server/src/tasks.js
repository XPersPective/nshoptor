// AI görevleri: istem + girdi doğrulama + çıktı temizleme. Model çıktısı asla
// olduğu gibi istemciye gitmez; yalnız şemaya uyan alanlar geçer.
import { CURRENCY_CODES } from './currencies.js';

export const UNITS = [
  'piece', 'kilogram', 'gram', 'litre', 'millilitre', 'package', 'box',
  'bottle', 'jar', 'bunch', 'dozen', 'meter',
];

const decimal = v => {
  if (v === null || v === undefined || v === '') return null;
  const s = String(v).trim().replace(',', '.');
  return /^\d{1,9}(\.\d{1,3})?$/.test(s) ? s : null;
};
const text = (v, max) => (typeof v === 'string' ? v.trim().slice(0, max) : '');

const canonicalMoney = raw => {
  let value = raw.replace(/\s/g, '');
  if (value.includes(',') && value.includes('.')) {
    value = value.lastIndexOf(',') > value.lastIndexOf('.')
      ? value.replaceAll('.', '').replace(',', '.') : value.replaceAll(',', '');
  } else if (value.includes(',')) value = value.replace(',', '.');
  if (!/^\d+(?:\.\d+)?$/.test(value)) return null;
  const [whole, fraction = ''] = value.split('.');
  const tail = fraction.replace(/0+$/, '');
  return whole.replace(/^0+(?=\d)/, '') + (tail ? `.${tail}` : '');
};

// A model boolean alone cannot decide the meaning of money. Require a quoted
// source clause with an explicit cue; missing/contradictory evidence stays open.
const priceMeaning = (item, source = '') => {
  const price = decimal(item?.estimatedPrice);
  if (!price || typeof item?.priceIsUnitPrice !== 'boolean') return null;
  const evidence = text(item?.priceEvidence, 500);
  if (!evidence || !source.includes(evidence) || !evidence.toLocaleLowerCase().includes(text(item?.name, 60).toLocaleLowerCase())) return null;
  // A true cue cannot authorize a different, model-invented money amount.
  // Unsupported word-number/order forms stay open for user confirmation.
  const cues = [...evidence.matchAll(/(?:toplam(?:\s+fiyat[ıi])?|ikisi|hepsi|total|altogether|tanesi|birim(?:\s+fiyat[ıi])?|kilosu|paketi|each|per\s+(?:item|pack|kilo))\s*[:=]?\s*(\d+(?:[.,]\d+)*)/giu)];
  if (cues.length !== 1 || /[,;\n](?!\d)/u.test(evidence)) return null;
  const prefix = evidence.slice(0, cues[0].index).toLocaleLowerCase();
  if (!prefix.includes(text(item.name, 60).toLocaleLowerCase()) || /\b(?:ve|and)\b/iu.test(prefix)) return null;
  if (canonicalMoney(cues[0][1]) !== canonicalMoney(price)) return null;
  const total = /\b(toplam|ikisi|hepsi|total|altogether)\b/iu.test(evidence);
  const unit = /\b(tanesi|birim|kilosu|paketi|each|per)\b/iu.test(evidence);
  return total === unit ? null : unit === item.priceIsUnitPrice ? unit : null;
};

const LOCALE_NOTE = locale =>
  `User locale: ${String(locale || 'en').slice(0, 5)}. Keep product names in the user's language.`;

const literalCurrencies = source => {
  if (/[$¥]|\b(?:frank|franc|peso|yen|yuan|ruble|rouble|rupee|rupi|dinar|dirhem|dirham|manat|kron|krone)\b/iu.test(source)) {
    throw new Error('unverified_currency');
  }
  const codes = new Set([...source.matchAll(/\d\s*([A-Z]{3})\b|\b([A-Z]{3})\s*\d/gi)]
    .map(m => (m[1] || m[2]).toUpperCase()).filter(c => CURRENCY_CODES.has(c)));
  if (/(?:\b(?:TL|lira)\b|₺)/iu.test(source)) codes.add('TRY');
  if (/(?:\b(?:euro|avro)\b|€)/iu.test(source)) codes.add('EUR');
  if (/(?:\bsterlin\b|£)/iu.test(source)) codes.add('GBP');
  if (/\b(?:dolar|dollar)s?\b/iu.test(source)) {
    // A qualified non-US dollar is not silently treated as USD.
    if (/\b(?:kanada|canadian|avustralya|australian|hong\s+kong|singapur|singapore)\b/iu.test(source)) {
      throw new Error('unverified_currency');
    }
    codes.add('USD');
  }
  return codes;
};

const sourceCurrency = (item, source = '') => {
  if (!decimal(item?.estimatedPrice)) return null;
  const all = literalCurrencies(source);
  if (all.size === 1) return [...all][0];
  if (all.size > 1) {
    const quote = text(item?.priceEvidence, 500);
    const own = literalCurrencies(quote);
    if (source.includes(quote) && !/[,;\n](?!\d)/u.test(quote) && own.size === 1 &&
        quote.toLocaleLowerCase().includes(text(item?.name, 60).toLocaleLowerCase())) return [...own][0];
    throw new Error('ambiguous_currency');
  }
  // Unknown currency words, ambiguous symbols or a model-only code cannot be
  // silently replaced with the list currency. Leave this for manual input.
  if (item?.currencyCode) throw new Error('unverified_currency');
  return null;
};

export const TASKS = {
  parse_list: {
    maxTokens: 4096,
    validate(input) {
      if (typeof input?.text !== 'string' || input.text.length > 2000) return null;
      const t = text(input.text, 2000);
      return t ? { text: t, priceSemanticsVersion: input.priceSemanticsVersion === 1 ? 1 : 0 } : null;
    },
    system: locale =>
      'You convert a spoken or typed shopping sentence into a list of separate products. ' +
      'Return ONLY JSON: {"title":string|null,"items":[{"name":string,"brand":string|null,"category":string|null,"quantity":string|null,' +
      `"unit":one of ${JSON.stringify(UNITS)}|null,"estimatedPrice":string|null,"priceIsUnitPrice":boolean|null,"priceEvidence":string|null,"currencyCode":string|null,"priceDestination":"planned"|"actual"}]}. ` +
      'Rules: ' +
      '1) One item per product. A new product starts where a number with an optional unit is followed by a product name ("1 kilo elma 1 ekmek" = two items). ' +
      '2) quantity is the number before the product or its unit ("1 kilo" -> quantity "1", unit "kilogram"; "2 paket" -> "2", "package"). A quantity without a unit is unit "piece". ' +
      '3) estimatedPrice is the spoken money amount, never guess whether it is total or per unit. ' +
      'Use priceIsUnitPrice false only for explicit total/toplam/ikisi/hepsi, true only for each/tanesi/birim fiyatı/kilosu/paketi/per-unit cues. Otherwise null. ' +
      'priceEvidence must quote the exact source clause containing product, amount and price cue; never invent evidence. ' +
      'currencyCode must reflect spoken currency (TRY/EUR/USD etc.), else null. priceDestination is actual for explicit market/çarşı/store purchase prices, else planned. ' +
      '"kilosu 40 lira" or "per kilo 40" is a unit price: priceIsUnitPrice true. A price is never part of the name. ' +
      '4) name is only the product: no quantity, unit, price or filler words ("alacağım", "ekle", "lazım", "add", "buy"). Keep the user\'s language. ' +
      '5) Never invent prices, brands or quantities: use null when not said. ' +
      '6) Use a title only if the input suggests one. Categories: produce, dairy, meat, bakery, drinks, cleaning, personalCare, home, other, or a user custom category. Max 40 items. ' +
      'Examples: "1 kilo elma 1 ekmek" -> [{"name":"elma","quantity":"1","unit":"kilogram"},{"name":"ekmek","quantity":"1","unit":"piece"}]. ' +
      '"1 kilo domates 20 TL" -> [{"name":"domates","quantity":"1","unit":"kilogram","estimatedPrice":"20","priceIsUnitPrice":null,"currencyCode":"TRY"}]. ' +
      '"elma kilosu 40 lira, 2 süt" -> [{"name":"elma","estimatedPrice":"40","priceIsUnitPrice":true},{"name":"süt","quantity":"2","unit":"piece"}]. ' +
      LOCALE_NOTE(locale),
    user: input => input.text,
    clean(out, input) {
      if (!Array.isArray(out?.items) || out.items.length > 40 || out.items.some(i => !text(i?.name, 60))) throw new Error('invalid_items');
      const items = out.items;
      return {
        title: text(out?.title, 80) || null,
        items: items
          .map(i => {
            const meaning = priceMeaning(i, input?.text);
            const currency = sourceCurrency(i, input?.text);
            const legacyUnsafe = input?.priceSemanticsVersion !== 1 &&
              (meaning === null || currency !== null || i?.priceDestination === 'actual');
            return ({
            name: text(i?.name, 60),
            brand: text(i?.brand, 60) || null,
            category: text(i?.category, 60) || null,
            quantity: decimal(i?.quantity),
            unit: UNITS.includes(i?.unit) ? i.unit : null,
            estimatedPrice: legacyUnsafe ? null : decimal(i?.estimatedPrice),
            priceIsUnitPrice: meaning,
            currencyCode: currency,
            priceDestination: i?.priceDestination === 'actual' && /market|çarşı|store|actual/iu.test(text(i?.priceEvidence, 500)) && (input?.text || '').includes(text(i?.priceEvidence, 500)) ? 'actual' : 'planned',
          }); })
          .filter(i => i.name),
      };
    },
  },

  match_receipt: {
    maxTokens: 8192,
    validate(input) {
      if (!Array.isArray(input?.lines) || input.lines.length > 120 || !Array.isArray(input.planned) || input.planned.length > 200) return null;
      const lines = input.lines;
      const planned = input.planned;
      const cleanLines = lines
        .map(l => ({ i: Number.isInteger(l?.i) ? l.i : -1, text: text(l?.text, 80), total: decimal(l?.total) }))
        .filter(l => l.i >= 0 && l.text);
      const cleanPlanned = planned
        .map(p => ({ id: Number.isInteger(p?.id) ? p.id : -1, name: text(p?.name, 60) }))
        .filter(p => p.id >= 0 && p.name);
      return cleanLines.length && cleanPlanned.length && cleanLines.length === lines.length && cleanPlanned.length === planned.length
        && new Set(cleanLines.map(l => l.i)).size === lines.length && new Set(cleanPlanned.map(p => p.id)).size === planned.length
        ? { lines: cleanLines, planned: cleanPlanned } : null;
    },
    system: locale =>
      'You match grocery receipt lines to the items the user planned. Receipt ' +
      'names are abbreviated, uppercase, may contain brand, size or discount ' +
      'words ("INDIRIMLI ELMA KG" matches planned "elma"). Return JSON ' +
      '{"matches":[{"i":int,"plannedId":int|null,"confidence":"high"|"medium"|"low",' +
      '"isDiscount":boolean}]} with one entry per receipt line. Use only plannedId ' +
      'values from the input; null when nothing fits. ' + LOCALE_NOTE(locale),
    user: input => JSON.stringify(input),
    clean(out, input) {
      const lineIds = new Set(input.lines.map(l => l.i));
      const plannedIds = new Set(input.planned.map(p => p.id));
      const matches = Array.isArray(out?.matches) ? out.matches : [];
      if (matches.length !== lineIds.size || new Set(matches.map(m => m?.i)).size !== lineIds.size || matches.some(m => !lineIds.has(m?.i))) throw new Error('incomplete_matches');
      const seen = new Set();
      return {
        matches: matches
          .filter(m => lineIds.has(m?.i) && !seen.has(m.i) && seen.add(m.i))
          .map(m => ({
            i: m.i,
            plannedId: plannedIds.has(m?.plannedId) ? m.plannedId : null,
            confidence: ['high', 'medium', 'low'].includes(m?.confidence) ? m.confidence : 'low',
            isDiscount: m?.isDiscount === true,
          })),
      };
    },
  },

  read_label: {
    maxTokens: 512,
    validate(input) {
      if (typeof input?.text !== 'string' || input.text.length > 1500) return null;
      const t = text(input.text, 1500);
      return t ? { text: t } : null;
    },
    system: locale =>
      'You read OCR text of a supermarket shelf price label. Return JSON ' +
      '{"productName":string|null,"price":string|null,"unitPrice":string|null,' +
      `"unit":one of ${JSON.stringify(UNITS)}|null}. price is the price to pay for ` +
      'one item; unitPrice is per kilogram/litre if printed. Plain decimal strings ' +
      'with a dot. If unsure return null fields. ' + LOCALE_NOTE(locale),
    user: input => input.text,
    clean(out) {
      if (!out || typeof out !== 'object' || Array.isArray(out) || !Object.hasOwn(out, 'price') || !Object.hasOwn(out, 'unitPrice')) throw new Error('invalid_label');
      return {
        productName: text(out?.productName, 60) || null,
        price: decimal(out?.price),
        unitPrice: decimal(out?.unitPrice),
        unit: UNITS.includes(out?.unit) ? out.unit : null,
      };
    },
  },
};
