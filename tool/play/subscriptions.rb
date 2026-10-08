# NShoptor Play abonelikleri (ADR-004 §6). Tekrar çalıştırılabilir: var olanı atlar.
#   ruby tool/play/subscriptions.rb          # oluştur/etkinleştir
#   ruby tool/play/subscriptions.rb --list   # durum
# Servis hesabı yayın kökünde (repo dışı): APP_PUBLISHING_ROOT.
require 'google/apis/androidpublisher_v3'
require 'googleauth'

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

def usd(units, nanos) = A::Money.new(currency_code: 'USD', units: units, nanos: nanos)

def convert(svc, money)
  svc.convert_monetization_region_prices(PKG, A::ConvertRegionPricesRequest.new(price: money))
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

existing = (svc.list_monetization_subscriptions(PKG).subscriptions || []).map(&:product_id)

PLANS.each do |pid, cfg|
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
        acquisition_rule: A::AcquisitionTargetingRule.new(scope: A::TargetingRuleScope.new(this_subscription: A::TargetingRuleScopeThisSubscription.new))
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
