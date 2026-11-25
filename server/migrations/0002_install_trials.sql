-- Anonymous first-install trial; no purchase token or user content.
CREATE TABLE IF NOT EXISTS install_trials (
  install_id TEXT PRIMARY KEY,
  started_at INTEGER NOT NULL,
  ends_at INTEGER NOT NULL,
  last_seen_at INTEGER NOT NULL,
  CHECK (ends_at >= started_at)
);
