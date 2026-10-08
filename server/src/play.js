// Pro/Max yetkisi: istemci iddiası değil, Play Developer API doğrulaması
// (ADR-004 §7, C-041). Her hata ücretsiz katmana düşer; asla yükseltmez.

const enc = new TextEncoder();
const b64url = bytes =>
  btoa(String.fromCharCode(...new Uint8Array(bytes)))
    .replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
const b64urlJson = obj => b64url(enc.encode(JSON.stringify(obj)));

export async function sha256Hex(s) {
  const d = await crypto.subtle.digest('SHA-256', enc.encode(s));
  return [...new Uint8Array(d)].map(b => b.toString(16).padStart(2, '0')).join('');
}

async function accessToken(sa, fetchImpl) {
  const now = Math.floor(Date.now() / 1000);
  const header = b64urlJson({ alg: 'RS256', typ: 'JWT' });
  const claims = b64urlJson({
    iss: sa.client_email,
    scope: 'https://www.googleapis.com/auth/androidpublisher',
    aud: 'https://oauth2.googleapis.com/token',
    iat: now,
    exp: now + 3600,
  });
  const pem = sa.private_key.replace(/-----[^-]+-----|\s/g, '');
  const der = Uint8Array.from(atob(pem), c => c.charCodeAt(0));
  const key = await crypto.subtle.importKey(
    'pkcs8', der, { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-256' }, false, ['sign']);
  const sig = await crypto.subtle.sign('RSASSA-PKCS1-v1_5', key, enc.encode(`${header}.${claims}`));
  const res = await fetchImpl('https://oauth2.googleapis.com/token', {
    method: 'POST',
    headers: { 'content-type': 'application/x-www-form-urlencoded' },
    body: `grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=${header}.${claims}.${b64url(sig)}`,
  });
  if (!res.ok) throw new Error('oauth_' + res.status);
  return (await res.json()).access_token;
}

export function tierFromSubscription(sub) {
  if (!sub || !['SUBSCRIPTION_STATE_ACTIVE', 'SUBSCRIPTION_STATE_IN_GRACE_PERIOD']
    .includes(sub.subscriptionState)) return { tier: 'free', expiresAt: 0 };
  let tier = 'free';
  let expiresAt = 0;
  for (const item of sub.lineItems ?? []) {
    const exp = Date.parse(item.expiryTime ?? '') || 0;
    if (exp <= Date.now()) continue;
    if (item.productId === 'nshoptor_max') { tier = 'max'; expiresAt = Math.max(expiresAt, exp); }
    else if (item.productId === 'nshoptor_pro' && tier !== 'max') { tier = 'pro'; expiresAt = Math.max(expiresAt, exp); }
  }
  return { tier, expiresAt };
}

/// purchaseToken → 'free' | 'pro' | 'max'. Önbellek: jetonun özeti, en çok 6 saat.
export async function resolveTier(env, purchaseToken, { fetchImpl = fetch, now = Date.now() } = {}) {
  if (typeof purchaseToken !== 'string' || purchaseToken.length < 20 || purchaseToken.length > 4096) {
    return 'free';
  }
  try {
    const hash = await sha256Hex(purchaseToken);
    const cached = await env.DB.prepare(
      'SELECT tier, expires_at FROM entitlement_cache WHERE token_hash = ?').bind(hash).first();
    if (cached && cached.expires_at > now) return cached.tier;

    const sa = JSON.parse(env.GOOGLE_SA_JSON);
    const token = await accessToken(sa, fetchImpl);
    const url = `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/${
      encodeURIComponent(env.PACKAGE_NAME)}/purchases/subscriptionsv2/tokens/${encodeURIComponent(purchaseToken)}`;
    const res = await fetchImpl(url, { headers: { authorization: 'Bearer ' + token } });
    if (!res.ok) return 'free';
    const { tier, expiresAt } = tierFromSubscription(await res.json());
    const cacheUntil = Math.min(expiresAt || now + 600_000, now + 6 * 3600_000);
    await env.DB.prepare(
      'INSERT INTO entitlement_cache(token_hash, tier, expires_at) VALUES(?, ?, ?) ' +
        'ON CONFLICT(token_hash) DO UPDATE SET tier = excluded.tier, expires_at = excluded.expires_at',
    ).bind(hash, tier, cacheUntil).run();
    return tier;
  } catch {
    return 'free';
  }
}
