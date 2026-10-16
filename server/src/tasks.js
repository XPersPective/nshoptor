// AI görevleri: istem + girdi doğrulama + çıktı temizleme. Model çıktısı asla
// olduğu gibi istemciye gitmez; yalnız şemaya uyan alanlar geçer.

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

const LOCALE_NOTE = locale =>
  `User locale: ${String(locale || 'en').slice(0, 5)}. Keep product names in the user's language.`;

export const TASKS = {
  parse_list: {
    maxTokens: 4096,
    validate(input) {
      if (typeof input?.text !== 'string' || input.text.length > 2000) return null;
      const t = text(input.text, 2000);
      return t ? { text: t } : null;
    },
    system: locale =>
      'You convert a spoken or typed shopping sentence into a list of separate products. ' +
      'Return ONLY JSON: {"title":string|null,"items":[{"name":string,"brand":string|null,"category":string|null,"quantity":string|null,' +
      `"unit":one of ${JSON.stringify(UNITS)}|null,"estimatedPrice":string|null,"priceIsUnitPrice":boolean}]}. ` +
      'Rules: ' +
      '1) One item per product. A new product starts where a number with an optional unit is followed by a product name ("1 kilo elma 1 ekmek" = two items). ' +
      '2) quantity is the number before the product or its unit ("1 kilo" -> quantity "1", unit "kilogram"; "2 paket" -> "2", "package"). A quantity without a unit is unit "piece". ' +
      '3) estimatedPrice: a price said after a product ("20 TL", "20 lira", "20 euro") is that product\'s estimated line total: estimatedPrice "20", priceIsUnitPrice false. ' +
      '"kilosu 40 lira" or "per kilo 40" is a unit price: priceIsUnitPrice true. A price is never part of the name. ' +
      '4) name is only the product: no quantity, unit, price or filler words ("alacağım", "ekle", "lazım", "add", "buy"). Keep the user\'s language. ' +
      '5) Never invent prices, brands or quantities: use null when not said. ' +
      '6) Use a title only if the input suggests one. Categories: produce, dairy, meat, bakery, drinks, cleaning, personalCare, home, other, or a user custom category. Max 40 items. ' +
      'Examples: "1 kilo elma 1 ekmek" -> [{"name":"elma","quantity":"1","unit":"kilogram"},{"name":"ekmek","quantity":"1","unit":"piece"}]. ' +
      '"1 kilo domates 20 TL" -> [{"name":"domates","quantity":"1","unit":"kilogram","estimatedPrice":"20","priceIsUnitPrice":false}]. ' +
      '"elma kilosu 40 lira, 2 süt" -> [{"name":"elma","estimatedPrice":"40","priceIsUnitPrice":true},{"name":"süt","quantity":"2","unit":"piece"}]. ' +
      LOCALE_NOTE(locale),
    user: input => input.text,
    clean(out) {
      if (!Array.isArray(out?.items) || out.items.length > 40 || out.items.some(i => !text(i?.name, 60))) throw new Error('invalid_items');
      const items = out.items;
      return {
        title: text(out?.title, 80) || null,
        items: items
          .map(i => ({
            name: text(i?.name, 60),
            brand: text(i?.brand, 60) || null,
            category: text(i?.category, 60) || null,
            quantity: decimal(i?.quantity),
            unit: UNITS.includes(i?.unit) ? i.unit : null,
            estimatedPrice: decimal(i?.estimatedPrice),
            priceIsUnitPrice: i?.priceIsUnitPrice === true,
          }))
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
