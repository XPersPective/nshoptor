-- Kota sayaçları: yalnız rastgele kurulum kimliği + dönem; içerik tutulmaz.
CREATE TABLE IF NOT EXISTS usage (
  install_id TEXT NOT NULL,
  period TEXT NOT NULL,
  count INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (install_id, period)
);

CREATE TABLE IF NOT EXISTS global_usage (
  day TEXT PRIMARY KEY,
  count INTEGER NOT NULL DEFAULT 0
);

-- Doğrulanmış abonelik önbelleği: jetonun SHA-256 özeti, jetonun kendisi değil.
CREATE TABLE IF NOT EXISTS entitlement_cache (
  token_hash TEXT PRIMARY KEY,
  tier TEXT NOT NULL,
  expires_at INTEGER NOT NULL
);
