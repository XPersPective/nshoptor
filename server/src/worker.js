// NShoptor AI vekili. Anahtar, doğrulama
// kimliği ve kota burada; uygulama (açık kaynak) hiçbir sır taşımaz.
import { chatJson, AiError, readBoundedText, configured } from './ai.js';
import { consume } from './quota.js';
import { resolveEntitlement } from './play.js';
import { TASKS } from './tasks.js';
import { observeTrial, registerTrial, trialEnabled } from './trial.js';

const MAX_BODY = 16 * 1024;

const json = (status, body) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'content-type': 'application/json', 'cache-control': 'no-store' },
  });

export async function handleAccess(request, env, { now = new Date() } = {}) {
  if (!trialEnabled(env)) return json(404, { error: 'not_found' });
  const maxBody = 2048;
  if (Number(request.headers.get('content-length') || 0) > maxBody) return json(413, { error: 'too_large' });
  let body;
  try { body = JSON.parse(await readBoundedText(request, maxBody)); }
  catch (e) { return json(e instanceof RangeError ? 413 : 400, { error: e instanceof RangeError ? 'too_large' : 'bad_json' }); }
  if (typeof body?.installId !== 'string' || !/^[a-f0-9]{32}$/.test(body.installId)) return json(400, { error: 'invalid_id' });
  // Epoch milliseconds, bounded to a real nonnegative date. A future hint is
  // clamped to server time; it cannot buy a later deadline.
  const hint = body.firstOpenedAt;
  if (hint !== undefined && (!Number.isSafeInteger(hint) || hint < 0 || hint > 8640000000000000 - 604800000)) {
    return json(400, { error: 'invalid_start' });
  }
  try {
    const trial = await registerTrial(env, body.installId, hint, now.getTime());
    return json(200, { trial });
  } catch { return json(503, { error: 'busy' }); }
}

export async function handleAi(request, env, { fetchImpl = fetch, now = new Date() } = {}) {
  const length = Number(request.headers.get('content-length') || 0);
  if (length > MAX_BODY) return json(413, { error: 'too_large' });
  let raw;
  try { raw = await readBoundedText(request, MAX_BODY); }
  catch (e) { return json(e instanceof RangeError ? 413 : 400, { error: e instanceof RangeError ? 'too_large' : 'bad_json' }); }

  let body;
  try { body = JSON.parse(raw); } catch { return json(400, { error: 'bad_json' }); }
  if (typeof body?.installId !== 'string' || !/^[a-f0-9]{32}$/.test(body.installId)) return json(400, { error: 'invalid_id' });
  const task = typeof body.task === 'string' && Object.hasOwn(TASKS, body.task) ? TASKS[body.task] : null;
  if (!task) return json(400, { error: 'unknown_task' });
  if (JSON.stringify(body.input ?? null).length > (Number(env.MAX_INPUT_CHARS) || 6000)) {
    return json(413, { error: 'input_too_large' });
  }
  const input = task.validate(body.input);
  if (!input) return json(400, { error: 'invalid_input' });

  if (!configured(env)) return json(503, { error: 'busy' });
  let entitlement;
  try { entitlement = await resolveEntitlement(env, body.purchaseToken, { fetchImpl, now: now.getTime() }); }
  catch { return json(503, { error: 'busy' }); }
  let { tier, policy, identity } = entitlement;
  if (tier === 'free' && trialEnabled(env)) {
    try {
      const trial = await observeTrial(env, body.installId, now.getTime());
      if (trial?.active) { tier = 'pro'; policy = 'pro-v2'; }
    } catch { return json(503, { error: 'busy' }); }
  }
  let quota;
  try { quota = await consume(env, identity ?? body.installId, policy, now, { legacyInstallId: body.installId }); }
  catch { return json(503, { error: 'busy' }); }
  if (!quota.ok) {
    return quota.reason === 'quota'
      ? json(429, { error: 'quota', tier, limit: quota.limit, used: quota.used })
      : json(503, { error: 'busy' });
  }

  try {
    const out = await chatJson(env, task.system(body.locale), task.user(input), { fetchImpl, maxTokens: task.maxTokens });
    return json(200, { tier, used: quota.used, limit: quota.limit, result: task.clean(out, input) });
  } catch (e) {
    return json(502, { error: e instanceof AiError ? 'ai_failed' : 'bad_model_output' });
  }
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    if (url.pathname === '/health' && request.method === 'GET') return json(200, { ok: true });
    if (url.pathname === '/v1/ai' && request.method === 'POST') return handleAi(request, env);
    if (url.pathname === '/v1/access' && request.method === 'POST') return handleAccess(request, env);
    return json(404, { error: 'not_found' });
  },
};
