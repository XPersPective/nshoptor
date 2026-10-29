// NShoptor AI vekili. Anahtar, doğrulama
// kimliği ve kota burada; uygulama (açık kaynak) hiçbir sır taşımaz.
import { chatJson, AiError, readBoundedText, configured } from './ai.js';
import { consume } from './quota.js';
import { resolveEntitlement } from './play.js';
import { resolveAppleEntitlement } from './apple.js';
import { TASKS as TEXT_TASKS } from './tasks.js';
import { VISION_TASKS } from './vision_tasks.js';

const TASKS = { ...TEXT_TASKS, ...VISION_TASKS };
import { observeTrial, registerTrial, trialEnabled } from './trial.js';

const MAX_BODY = 16 * 1024;
// Image tasks carry up to four downscaled JPEG parts as base64.
const MAX_IMAGE_BODY = 4 * 1024 * 1024;

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
  if (length > MAX_IMAGE_BODY) return json(413, { error: 'too_large' });
  let raw;
  try { raw = await readBoundedText(request, MAX_IMAGE_BODY); }
  catch (e) { return json(e instanceof RangeError ? 413 : 400, { error: e instanceof RangeError ? 'too_large' : 'bad_json' }); }

  let body;
  try { body = JSON.parse(raw); } catch { return json(raw.length > MAX_BODY ? 413 : 400, { error: raw.length > MAX_BODY ? 'too_large' : 'bad_json' }); }
  if (typeof body?.installId !== 'string' || !/^[a-f0-9]{32}$/.test(body.installId)) return json(400, { error: 'invalid_id' });
  const task = typeof body.task === 'string' && Object.hasOwn(TASKS, body.task) ? TASKS[body.task] : null;
  if (!task) return json(400, { error: 'unknown_task' });
  // Only image tasks may use the larger envelope; text tasks keep 16 KiB.
  if (!task.maxInputChars && raw.length > MAX_BODY) return json(413, { error: 'too_large' });
  if (JSON.stringify(body.input ?? null).length > (task.maxInputChars || Number(env.MAX_INPUT_CHARS) || 6000)) {
    return json(413, { error: 'input_too_large' });
  }
  const input = task.validate(body.input);
  if (!input) return json(400, { error: 'invalid_input' });

  const hasApple = Object.hasOwn(body, 'appleTransaction');
  if (hasApple && Object.hasOwn(body, 'purchaseToken')) return json(400, { error: 'ambiguous_purchase' });
  if (hasApple && (typeof body.appleTransaction !== 'string' || body.appleTransaction.length === 0 ||
      body.appleTransaction.length > 8192)) return json(400, { error: 'invalid_purchase' });

  if (!configured(env)) return json(503, { error: 'busy' });
  let entitlement;
  try { entitlement = hasApple
    ? await resolveAppleEntitlement(env, body.appleTransaction, { fetchImpl, now: now.getTime() })
    : await resolveEntitlement(env, body.purchaseToken, { fetchImpl, now: now.getTime() }); }
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

  // One paid request may make a second, corrective model call when the first
  // answer fails the task contract. The user is never charged twice.
  const options = { fetchImpl, maxTokens: task.maxTokens, model: task.vision ? env.AI_VISION_MODEL || env.AI_MODEL : undefined, timeoutMs: task.timeoutMs, hedgeAfterMs: task.hedgeAfterMs };
  let failure = 'bad_model_output';
  let shape;
  for (let attempt = 0; attempt < 2; attempt++) {
    const system = task.system(body.locale) + (attempt && task.retryNote ? task.retryNote(failure) : '');
    // Diagnostics without content: top-level field names and a short status.
    const describe = out => out && typeof out === 'object' && !Array.isArray(out)
      ? { keys: Object.keys(out).slice(0, 16).map(k => String(k).replace(/[^A-Za-z_]/g, '').slice(0, 24)),
        status: typeof out.status === 'string' && /^[A-Za-z_ -]{1,24}$/.test(out.status) ? out.status : typeof out.status }
      : { type: Array.isArray(out) ? 'array' : typeof out };
    try {
      const result = await chatJson(env, system, task.user(input), {
        ...options,
        accept: out => { shape = describe(out); return task.clean(out, input); },
        onReject: out => { shape = describe(out); },
      });
      return json(200, { tier, used: quota.used, limit: quota.limit, result });
    } catch (e) {
      if (e instanceof AiError && !['ai_not_json', 'ai_schema', 'ai_truncated'].includes(e.message)) {
        return json(502, { error: 'ai_failed' });
      }
      failure = e instanceof AiError ? e.message : String(e?.message || 'bad_model_output').slice(0, 40);
      if (!task.retryNote) break;
    }
  }
  return json(502, { error: 'bad_model_output', reason: /^[a-z_]{1,40}$/.test(failure) ? failure : 'bad_model_output', ...(task.retryNote && shape ? { shape } : {}) });
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
