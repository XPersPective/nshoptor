# Compatibility entry point: cannot recreate retired monthly/Max plans.
require_relative 'annual_pro'
if (ARGV & %w[--create-v2 --verify-v2 --preview-v2]).any?
  warn 'Obsolete multi-plan operation disabled. Use annual_pro.rb preview/status.'
  exit 1
end
ARGV.map! { |arg| %w[--list --prices-json].include?(arg) ? '--status' : arg }
begin
  AnnualPro.run
rescue StandardError => e
  warn "Catalog action stopped: #{e.class}; inspect private receipt/remote status. No credentials displayed."
  exit 1
end
