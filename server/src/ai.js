// OpenAI uyumlu sağlayıcı istemcisi (DeepSeek / Qwen). Anahtar yalnız Worker
// secret'ı (AI_KEY); istek/yanıt içeriği hiçbir yerde loglanmaz (ADR-004 §3).

export class AiError extends Error {}

export async function chatJson(env, system, user, { fetchImpl = fetch, maxTokens = 1200 } = {}) {
  const base = String(env.AI_URL || '').replace(/\/+$/, '');
  if (!base.startsWith('https://') || !env.AI_KEY || !env.AI_MODEL) {
    throw new AiError('ai_not_configured');
  }
  const body = {
    model: env.AI_MODEL,
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
      signal: AbortSignal.timeout(Number(env.AI_TIMEOUT_MS) || 20000),
    });
  } catch {
    throw new AiError('ai_unreachable');
  }
  if (!res.ok) throw new AiError('ai_http_' + res.status);
  const data = await res.json().catch(() => null);
  const text = data?.choices?.[0]?.message?.content;
  if (typeof text !== 'string') throw new AiError('ai_schema');
  try {
    return JSON.parse(text.replace(/^```(?:json)?\s*|\s*```$/g, ''));
  } catch {
    throw new AiError('ai_not_json');
  }
}
