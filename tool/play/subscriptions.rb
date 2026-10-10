# NShoptor Play abonelikleri (ADR-004 §6). Tekrar çalıştırılabilir: var olanı atlar.
#   ruby tool/play/subscriptions.rb          # oluştur/etkinleştir
#   ruby tool/play/subscriptions.rb --list   # durum
# Servis hesabı yayın kökünde (repo dışı): APP_PUBLISHING_ROOT.
require 'google/apis/androidpublisher_v3'
require 'googleauth'
require 'json'
require 'time'

A = Google::Apis::AndroidpublisherV3
ROOT = ENV.fetch('APP_PUBLISHING_ROOT', 'D:/AppPublishing')
PKG = 'com.crazypenguin.nshoptor'

svc = A::AndroidPublisherService.new
svc.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
  json_key_io: File.open(File.join(ROOT, 'publisher/crazypenguin/credentials/google-play/service-account.json')),
  scope: 'https://www.googleapis.com/auth/androidpublisher'
)

PLANS = {
  'nshoptor_pro' => {
    title: { 'en-US' => 'NShoptor Pro', 'tr-TR' => 'NShoptor Pro' },
    benefits: {
      'en-US' => ['No ads', '200 AI requests a month', 'Backup export and import'],
      'tr-TR' => ['Reklamsız', 'Ayda 200 yapay zekâ isteği', 'Yedeği dışa ve içe aktarma'],
    },
    base_plans: { 'monthly' => ['P1M', 990_000_000, 0], 'yearly' => ['P1Y', 990_000_000, 7] },
    trial_on: 'monthly',
  },
  'nshoptor_max' => {
    title: { 'en-US' => 'NShoptor Max', 'tr-TR' => 'NShoptor Max' },
    benefits: {
      'en-US' => ['No ads', '1000 AI requests a month', 'For big family shopping'],
      'tr-TR' => ['Reklamsız', 'Ayda 1000 yapay zekâ isteği', 'Büyük aile alışverişleri için'],
    },
    base_plans: { 'monthly' => ['P1M', 990_000_000, 2], 'yearly' => ['P1Y', 990_000_000, 24] },
    trial_on: nil,
  },
}.freeze

# New offers are separate products; legacy prices and promises are never rewritten.
V2_PLANS = PLANS.to_h do |pid, cfg|
  pro = pid == 'nshoptor_pro'
  allowance = pro ? 100 : 300
  [pid + '_v2', cfg.merge(
    benefits: cfg[:benefits].transform_values { |items| items.map { |value| value.gsub(/200|1000/, allowance.to_s) } },
    base_plans: { 'monthly' => ['P1M', 990_000_000, pro ? 1 : 3],
                  'yearly' => ['P1Y', 990_000_000, pro ? 19 : 39] }
  )]
end.freeze

if ARGV.include?('--preview-v2')
  puts JSON.pretty_generate(products: V2_PLANS, trial_scope: 'anySubscriptionInApp')
  exit
end

def usd(units, nanos) = A::Money.new(currency_code: 'USD', units: units, nanos: nanos)

def convert(svc, money)
  svc.convert_monetization_region_prices(PKG, A::ConvertRegionPricesRequest.new(price: money))
end

# Read only, exits before any catalog/base-plan mutation.
if ARGV.include?('--prices-json')
  products = (svc.list_monetization_subscriptions(PKG).subscriptions || []).map do |sub|
    {
      product_id: sub.product_id,
      listings: (sub.listings || []).map { |l| { language: l.language_code, title: l.title, benefits: l.benefits } },
      base_plans: (sub.base_plans || []).map do |base|
        { id: base.base_plan_id, state: base.state,
          period: base.auto_renewing_base_plan_type&.billing_period_duration,
          prices: (base.regional_configs || []).select { |r| %w[US TR].include?(r.region_code) }.map do |r|
            { region: r.region_code, available: r.new_subscriber_availability,
              currency: r.price&.currency_code, units: (r.price&.units || 0).to_s, nanos: r.price&.nanos || 0 }
          end }
      end,
    }
  end
  puts JSON.pretty_generate(captured_at: Time.now.utc.iso8601, package: PKG, subscriptions: products)
  exit
end

if ARGV.include?('--list')
  (svc.list_monetization_subscriptions(PKG).subscriptions || []).each do |s|
    puts "#{s.product_id}: " + (s.base_plans || []).map { |b| "#{b.base_plan_id}=#{b.state}" }.join(', ')
    (s.base_plans || []).each do |b|
      offers = svc.list_monetization_subscription_base_plan_offers(PKG, s.product_id, b.base_plan_id).subscription_offers || []
      offers.each { |o| puts "  offer #{b.base_plan_id}/#{o.offer_id}=#{o.state}" }
    end
  end
  lt = svc.get_monetization_onetimeproduct(PKG, 'com.crazypenguin.nshoptor.pro_lifetime')
  puts "lifetime: " + (lt.purchase_options || []).map { |o| "#{o.purchase_option_id}=#{o.state}" }.join(', ')
  exit
end

catalog = svc.list_monetization_subscriptions(PKG).subscriptions || []
existing = catalog.map(&:product_id)
verify_v2 = ARGV.include?('--verify-v2')
v2 = ARGV.include?('--create-v2') || verify_v2
plans = v2 ? V2_PLANS : PLANS
# Fail before any mutation if a prior partial rollout conflicts with the reviewed offer.
if v2
  catalog.select { |sub| plans.key?(sub.product_id) }.each do |sub|
    cfg = plans.fetch(sub.product_id)
    cfg[:benefits].each do |language, benefits|
      raise 'existing v2 benefits differ' unless sub.listings.any? { |l| l.language_code == language && l.benefits == benefits }
    end
    cfg[:base_plans].each do |id, (period, nanos, units)|
      base = sub.base_plans.find { |b| b.base_plan_id == id }
      price = base&.regional_configs&.find { |r| r.region_code == 'US' }&.price
      raise 'existing v2 base plan differs' unless base&.auto_renewing_base_plan_type&.billing_period_duration == period &&
        price&.currency_code == 'USD' && price.units.to_i == units && price.nanos.to_i == nanos
    end
  end
end

if verify_v2
  raise 'missing v2 product' unless plans.keys.all? { |pid| existing.include?(pid) }
  catalog.select { |sub| plans.key?(sub.product_id) }.each do |sub|
    raise 'v2 base not active' unless sub.base_plans.all? { |base| base.state == 'ACTIVE' }
  end
  trial = svc.get_monetization_subscription_base_plan_offer(PKG, 'nshoptor_pro_v2', 'monthly', 'trial7')
  raise 'v2 trial not active/app-wide' unless trial.state == 'ACTIVE' && trial.targeting&.acquisition_rule&.scope&.any_subscription_in_app
  puts 'verified v2 prices/benefits/active bases and app-wide trial; no catalog mutation'
  exit
end

plans.each do |pid, cfg|
  base_plans = cfg[:base_plans].map do |bp_id, (period, nanos, units)|
    conv = convert(svc, usd(units, nanos))
    A::BasePlan.new(
      base_plan_id: bp_id,
      auto_renewing_base_plan_type: A::AutoRenewingBasePlanType.new(
        billing_period_duration: period, grace_period_duration: 'P3D',
        resubscribe_state: 'RESUBSCRIBE_STATE_ACTIVE', legacy_compatible: bp_id == 'monthly'
      ),
      regional_configs: conv.converted_region_prices.map { |region, cp|
        A::RegionalBasePlanConfig.new(region_code: region, price: cp.price, new_subscriber_availability: true)
      },
      other_regions_config: A::OtherRegionsBasePlanConfig.new(
        usd_price: conv.converted_other_regions_price.usd_price,
        eur_price: conv.converted_other_regions_price.eur_price,
        new_subscriber_availability: true
      )
    )
  end
  unless existing.include?(pid)
    sub = A::Subscription.new(
      package_name: PKG, product_id: pid,
      listings: cfg[:title].map { |lang, t|
        A::SubscriptionListing.new(language_code: lang, title: t, benefits: cfg[:benefits][lang])
      },
      base_plans: base_plans
    )
    version = convert(svc, usd(0, 990_000_000)).region_version.version
    svc.create_monetization_subscription(PKG, sub, product_id: pid, regions_version_version: version)
    puts "created #{pid}"
  end
  cfg[:base_plans].each_key do |bp|
    svc.batch_monetization_subscription_base_plan_update_states(PKG, pid, A::BatchUpdateBasePlanStatesRequest.new(
      requests: [A::UpdateBasePlanStateRequest.new(activate_base_plan_request:
        A::ActivateBasePlanRequest.new(package_name: PKG, product_id: pid, base_plan_id: bp))]
    ))
  end
  next unless cfg[:trial_on]

  bp = cfg[:trial_on]
  offers = svc.list_monetization_subscription_base_plan_offers(PKG, pid, bp).subscription_offers || []
  unless offers.any? { |o| o.offer_id == 'trial7' }
    regions = svc.get_monetization_subscription(PKG, pid).base_plans.find { |b| b.base_plan_id == bp }
                 .regional_configs.map(&:region_code)
    offer = A::SubscriptionOffer.new(
      package_name: PKG, product_id: pid, base_plan_id: bp, offer_id: 'trial7',
      phases: [A::SubscriptionOfferPhase.new(
        recurrence_count: 1, duration: 'P7D',
        regional_configs: regions.map { |r| A::RegionalSubscriptionOfferPhaseConfig.new(region_code: r, free: A::RegionalSubscriptionOfferPhaseFreePriceOverride.new) },
        other_regions_config: A::OtherRegionsSubscriptionOfferPhaseConfig.new(free: A::OtherRegionsSubscriptionOfferPhaseFreePriceOverride.new)
      )],
      regional_configs: regions.map { |r| A::RegionalSubscriptionOfferConfig.new(region_code: r, new_subscriber_availability: true) },
      other_regions_config: A::OtherRegionsSubscriptionOfferConfig.new(other_regions_new_subscriber_availability: true),
      targeting: A::SubscriptionOfferTargeting.new(
        acquisition_rule: A::AcquisitionTargetingRule.new(scope: v2 ? A::TargetingRuleScope.new(any_subscription_in_app: A::TargetingRuleScopeAnySubscriptionInApp.new) :
          A::TargetingRuleScope.new(this_subscription: A::TargetingRuleScopeThisSubscription.new))
      )
    )
    version = convert(svc, usd(0, 990_000_000)).region_version.version
    svc.create_monetization_subscription_base_plan_offer(PKG, pid, bp, offer, offer_id: 'trial7', regions_version_version: version)
    puts "created offer #{pid}/#{bp}/trial7"
  end
  svc.activate_subscription_offer(PKG, pid, bp, 'trial7',
    A::ActivateSubscriptionOfferRequest.new(package_name: PKG, product_id: pid, base_plan_id: bp, offer_id: 'trial7'))
end
puts 'done'
