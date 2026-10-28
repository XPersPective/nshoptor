// OpenAI uyumlu sağlayıcı istemcisi (DeepSeek / Qwen). Anahtar yalnız Worker
// secret'ı (AI_KEY); istek/yanıt içeriği hiçbir yerde loglanmaz (ADR-004 §3).

export class AiError extends Error {}

export async function readBoundedText(source, maxBytes) {
  const reader = source.body?.getReader();
  if (!reader) return '';
  let bytes = 0, text = '';
  const decoder = new TextDecoder('utf-8', { fatal: true });
  try {
    for (;;) {
      const { done, value } = await reader.read();
      if (done) return text + decoder.decode();
      bytes += value.byteLength;
      if (bytes > maxBytes) throw new RangeError('body_too_large');
      text += decoder.decode(value, { stream: true });
    }
  } catch (e) { await reader.cancel().catch(() => {}); throw e; }
  finally { reader.releaseLock(); }
}

export const configured = env => String(env.AI_URL || '').startsWith('https://') && !!env.AI_KEY && !!env.AI_MODEL;

// A model setting may list fallbacks ("a,b,c"): when one model is offline,
// overloaded or unreachable the next one answers. Invalid output does not
// switch models; the task's own retry handles that.
export async function chatJson(env, system, user, options = {}) {
  if (!configured(env)) throw new AiError('ai_not_configured');
  const models = String(options.model || env.AI_MODEL).split(',').map(m => m.trim()).filter(Boolean);
  let last;
  for (const model of models) {
    try {
      return await chatOnce(env, system, user, { ...options, model });
    } catch (e) {
      last = e;
      if (!(e instanceof AiError) || !/^ai_(unreachable|http_(404|408|409|425|429|5\d\d))$/.test(e.message)) throw e;
    }
  }
  throw last ?? new AiError('ai_not_configured');
}

async function chatOnce(env, system, user, { fetchImpl = fetch, maxTokens = 1200, model, timeoutMs } = {}) {
  const base = String(env.AI_URL || '').replace(/\/+$/, '');
  const body = {
    // `user` is a string or OpenAI-compatible content parts (text + image_url).
    model,
    messages: [
      { role: 'system', content: system },
      { role: 'user', content: user },
    ],
    temperature: 0,
    max_tokens: maxTokens,
    response_format: { type: 'json_object' },
    ...(env.AI_NOTHINK === '1' ? { enable_thinking: false } : {}),
  };
  let res;
  try {
    res = await fetchImpl(base + '/chat/completions', {
      method: 'POST',
      headers: { 'content-type': 'application/json', authorization: 'Bearer ' + env.AI_KEY },
      body: JSON.stringify(body),
      signal: AbortSignal.timeout(timeoutMs || Number(env.AI_TIMEOUT_MS) || 20000),
    });
  } catch {
    throw new AiError('ai_unreachable');
  }
  if (!res.ok) throw new AiError('ai_http_' + res.status);
  let data;
  try { data = JSON.parse(await readBoundedText(res, 64 * 1024)); } catch { throw new AiError('ai_schema'); }
  if (['length', 'content_filter'].includes(data?.choices?.[0]?.finish_reason)) throw new AiError('ai_truncated');
  const text = data?.choices?.[0]?.message?.content;
  if (typeof text !== 'string') throw new AiError('ai_schema');
  try {
    return JSON.parse(text.replace(/^```(?:json)?\s*|\s*```$/g, ''));
  } catch {
    throw new AiError('ai_not_json');
  }
}
