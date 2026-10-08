// NShoptor AI vekili (ADR-004). Tek uç: POST /v1/ai. Anahtar, doğrulama
// kimliği ve kota burada; uygulama (açık kaynak) hiçbir sır taşımaz.
import { chatJson, AiError } from './ai.js';
import { consume } from './quota.js';
import { resolveTier } from './play.js';
import { TASKS } from './tasks.js';

const MAX_BODY = 16 * 1024;

const json = (status, body) =>
  new Response(JSON.stringify(body), {
    status,
    headers: { 'content-type': 'application/json', 'cache-control': 'no-store' },
  });

export async function handleAi(request, env, { fetchImpl = fetch, now = new Date() } = {}) {
  const length = Number(request.headers.get('content-length') || 0);
  if (length > MAX_BODY) return json(413, { error: 'too_large' });
  const raw = await request.text();
  if (raw.length > MAX_BODY) return json(413, { error: 'too_large' });

  let body;
  try { body = JSON.parse(raw); } catch { return json(400, { error: 'bad_json' }); }
  if (!/^[a-f0-9]{32}$/.test(body?.installId ?? '')) return json(400, { error: 'invalid_id' });
  const task = TASKS[body.task];
  if (!task) return json(400, { error: 'unknown_task' });
  if (JSON.stringify(body.input ?? null).length > (Number(env.MAX_INPUT_CHARS) || 6000)) {
    return json(413, { error: 'input_too_large' });
  }
  const input = task.validate(body.input);
  if (!input) return json(400, { error: 'invalid_input' });

  const tier = body.purchaseToken
    ? await resolveTier(env, body.purchaseToken, { fetchImpl, now: now.getTime() })
    : 'free';
  const quota = await consume(env, body.installId, tier, now);
  if (!quota.ok) {
    return quota.reason === 'quota'
      ? json(429, { error: 'quota', tier, limit: quota.limit, used: quota.used })
      : json(503, { error: 'busy' });
  }

  try {
    const out = await chatJson(env, task.system(body.locale), task.user(input), { fetchImpl });
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
    return json(404, { error: 'not_found' });
  },
};
