// Monthly reservations and the daily global budget commit together.
export const tierLimit = (env, policy) => policy === 'max' ? 1000 : policy === 'pro' ? 200 :
  Number(policy === 'max-v2' ? env.QUOTA_MAX : policy === 'pro-v2' ? env.QUOTA_PRO : env.QUOTA_FREE);

export async function consume(env, identity, policy, now = new Date(), { legacyInstallId = identity } = {}) {
  const db = env.DB, limit = tierLimit(env, policy), cap = Number(env.GLOBAL_DAILY);
  if (![limit, cap].every(n => Number.isSafeInteger(n) && n > 0)) throw new RangeError('invalid_quota_config');
  const period = now.toISOString().slice(0, 7), today = now.toISOString().slice(0, 10);
  const results = await db.batch([
    // ponytail: anonymous pre-rollout counters cannot identify every old device;
    // seed the current installation once. Verified token identity is shared afterwards.
    db.prepare('INSERT INTO usage(install_id, period, count) VALUES(?, ?, ' +
      'COALESCE((SELECT count FROM usage WHERE install_id = ? AND period = ?), 0)) ' +
      'ON CONFLICT(install_id, period) DO NOTHING').bind(identity, period, legacyInstallId, period),
    db.prepare('INSERT INTO global_usage(day, count) VALUES(?, 0) ON CONFLICT(day) DO NOTHING').bind(today),
    db.prepare('UPDATE usage SET count = count + 1 WHERE install_id = ? AND period = ? AND count < ? ' +
      'AND (SELECT count FROM global_usage WHERE day = ?) < ? RETURNING count').bind(identity, period, limit, today, cap),
    // Must immediately follow the user UPDATE: changes() is its affected rows.
    db.prepare('UPDATE global_usage SET count = count + 1 WHERE day = ? AND changes() = 1 RETURNING count').bind(today),
    db.prepare('SELECT count FROM usage WHERE install_id = ? AND period = ?').bind(identity, period),
  ]);
  const used = results[4].results[0].count;
  return results[2].results.length ? { ok: true, used, limit } :
    { ok: false, reason: used >= limit ? 'quota' : 'busy', used, limit };
}
