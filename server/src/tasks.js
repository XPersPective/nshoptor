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
    validate(input) {
      const t = text(input?.text, 2000);
      return t ? { text: t } : null;
    },
    system: locale =>
      'You turn a spoken or typed shopping sentence into list items. ' +
      'Return JSON {"items":[{"name":string,"quantity":string|null,' +
      `"unit":one of ${JSON.stringify(UNITS)}|null,"estimatedPrice":string|null,` +
      '"priceIsUnitPrice":boolean}]}. quantity/estimatedPrice are plain decimal ' +
      'strings with a dot ("1.5", "20"). estimatedPrice is the price the user ' +
      'said; if they said "kilosu 45" or "per kilo" set priceIsUnitPrice true. ' +
      'Never invent prices. Max 40 items. ' + LOCALE_NOTE(locale),
    user: input => input.text,
    clean(out) {
      const items = Array.isArray(out?.items) ? out.items.slice(0, 40) : [];
      return {
        items: items
          .map(i => ({
            name: text(i?.name, 60),
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
    validate(input) {
      const lines = Array.isArray(input?.lines) ? input.lines.slice(0, 120) : [];
      const planned = Array.isArray(input?.planned) ? input.planned.slice(0, 200) : [];
      const cleanLines = lines
        .map(l => ({ i: Number.isInteger(l?.i) ? l.i : -1, text: text(l?.text, 80), total: decimal(l?.total) }))
        .filter(l => l.i >= 0 && l.text);
      const cleanPlanned = planned
        .map(p => ({ id: Number.isInteger(p?.id) ? p.id : -1, name: text(p?.name, 60) }))
        .filter(p => p.id >= 0 && p.name);
      return cleanLines.length && cleanPlanned.length ? { lines: cleanLines, planned: cleanPlanned } : null;
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
    validate(input) {
      const t = text(input?.text, 1500);
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
      return {
        productName: text(out?.productName, 60) || null,
        price: decimal(out?.price),
        unitPrice: decimal(out?.unitPrice),
        unit: UNITS.includes(out?.unit) ? out.unit : null,
      };
    },
  },
};
