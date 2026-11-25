export const TRIAL_MS = 7 * 24 * 60 * 60 * 1000;
export const trialEnabled = env => env.TRIAL_ENABLED === '1';

const snapshot = row => row == null ? null : ({
  startedAt: row.started_at,
  endsAt: row.ends_at,
  serverNow: row.last_seen_at,
  active: row.last_seen_at < row.ends_at,
});

// Every update can shorten the original window, never extend it. Keeping the
// latest observation also prevents a subsequent server clock rollback reopening it.
export async function registerTrial(env, id, firstOpenedAt, now) {
  const start = Math.min(firstOpenedAt ?? now, now);
  const result = await env.DB.prepare(
    'INSERT INTO install_trials(install_id, started_at, ends_at, last_seen_at) VALUES(?, ?, ?, ?) ' +
    'ON CONFLICT(install_id) DO UPDATE SET ' +
    'started_at = MIN(started_at, excluded.started_at), ' +
    'ends_at = MIN(ends_at, excluded.ends_at), ' +
    'last_seen_at = MAX(last_seen_at, excluded.last_seen_at) RETURNING *',
  ).bind(id, start, start + TRIAL_MS, now).first();
  return snapshot(result);
}

export async function observeTrial(env, id, now) {
  const row = await env.DB.prepare(
    'UPDATE install_trials SET last_seen_at = MAX(last_seen_at, ?) WHERE install_id = ? RETURNING *',
  ).bind(now, id).first();
  return snapshot(row);
}
