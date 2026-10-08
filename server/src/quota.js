// Aylık kurulum kotası + günlük global tavan (ADR-004 §5). Sayaçlar D1'de;
// içerik değil, yalnız rastgele kurulum kimliği ve dönem tutulur.

export const tierLimit = (env, tier) =>
  Number(
    tier === 'max' ? env.QUOTA_MAX : tier === 'pro' ? env.QUOTA_PRO : env.QUOTA_FREE,
  ) || 0;

const month = now => now.toISOString().slice(0, 7);
const day = now => now.toISOString().slice(0, 10);

async function current(db, sql, ...args) {
  const row = await db.prepare(sql).bind(...args).first();
  return row?.count ?? 0;
}

/// İzin varsa sayacı artırır ve `{ok:true, used, limit}` döner; yoksa sebep.
export async function consume(env, installId, tier, now = new Date()) {
  const db = env.DB;
  const limit = tierLimit(env, tier);
  const globalCap = Number(env.GLOBAL_DAILY) || 0;
  const period = month(now);
  const today = day(now);

  const used = await current(
    db, 'SELECT count FROM usage WHERE install_id = ? AND period = ?', installId, period);
  if (used >= limit) return { ok: false, reason: 'quota', used, limit };

  const globalUsed = await current(db, 'SELECT count FROM global_usage WHERE day = ?', today);
  if (globalCap && globalUsed >= globalCap) return { ok: false, reason: 'busy', used, limit };

  await db.batch([
    db.prepare(
      'INSERT INTO usage(install_id, period, count) VALUES(?, ?, 1) ' +
        'ON CONFLICT(install_id, period) DO UPDATE SET count = count + 1',
    ).bind(installId, period),
    db.prepare(
      'INSERT INTO global_usage(day, count) VALUES(?, 1) ' +
        'ON CONFLICT(day) DO UPDATE SET count = count + 1',
    ).bind(today),
  ]);
  return { ok: true, used: used + 1, limit };
}
