import { DatabaseSync } from 'node:sqlite';
import { readFileSync } from 'node:fs';

// Actual production schema and SQL, adapted only to D1's result shape.
export function sqliteDb() {
  const sqlite = new DatabaseSync(':memory:');
  sqlite.exec(readFileSync(new URL('../migrations/0001_init.sql', import.meta.url), 'utf8'));
  const stmt = (sql, args = []) => ({
    bind: (...values) => stmt(sql, values),
    async first() { return sqlite.prepare(sql).get(...args) ?? null; },
    async run() { return sqlite.prepare(sql).run(...args); },
    all() { return { results: sqlite.prepare(sql).all(...args) }; },
  });
  return { sqlite, prepare: sql => stmt(sql), async batch(statements) {
    sqlite.exec('BEGIN IMMEDIATE');
    try { const result = statements.map(s => s.all()); sqlite.exec('COMMIT'); return result; }
    catch (e) { sqlite.exec('ROLLBACK'); throw e; }
  } };
}
