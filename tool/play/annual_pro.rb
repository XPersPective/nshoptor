# Official Play catalog operation. Default is preview; never exposes credentials.
require 'google/apis/androidpublisher_v3'
require 'googleauth'
require 'json'
require 'digest'
require 'time'

module AnnualPro
  A = Google::Apis::AndroidpublisherV3
  PACKAGE = 'com.crazypenguin.nshoptor'
  PRODUCT = 'nshoptor_pro_v2'
  PLAN = 'yearly'
  LIFETIME = 'com.crazypenguin.nshoptor.pro_lifetime'
  PRODUCTS = %w[nshoptor_pro nshoptor_max nshoptor_pro_v2 nshoptor_max_v2].freeze

  def self.canonical(value)
    case value
    when Hash then value.keys.sort.to_h { |k| [k, canonical(value[k])] }
    when Array then value.map { |v| canonical(v) }
    else value
    end
  end

  def self.summary(catalog)
    catalog.sort_by(&:product_id).map do |s|
      { product: s.product_id, plans: s.base_plans.sort_by(&:base_plan_id).map do |b|
        { id: b.base_plan_id, state: b.state,
          period: b.auto_renewing_base_plan_type&.billing_period_duration,
          regions: b.regional_configs.size,
          prices: b.regional_configs.select { |r| %w[US TR].include?(r.region_code) }.map do |r|
            { region: r.region_code, price: r.price.to_h }
          end }
      end }
    end
  end

  def self.run
    root = ENV.fetch('APP_PUBLISHING_ROOT', 'D:/AppPublishing')
    receipt_path = File.join(root, 'apps/nshoptor/original-notes/annual-pro-2026-10-24.json')
    service = A::AndroidPublisherService.new
    File.open(File.join(root, 'publisher/crazypenguin/credentials/google-play/service-account.json')) do |f|
      service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: f, scope: 'https://www.googleapis.com/auth/androidpublisher')
    end
    catalog = PRODUCTS.map { |id| service.get_monetization_subscription(PACKAGE, id) }
    lifetime = service.get_monetization_onetimeproduct(PACKAGE, LIFETIME)
    lifetime_states = lifetime.purchase_options.map { |o| { id: o.purchase_option_id, state: o.state } }
    if ARGV.include?('--status')
      puts JSON.pretty_generate(package: PACKAGE, catalog: summary(catalog), lifetime: lifetime_states)
      return
    end
    target = catalog.find { |s| s.product_id == PRODUCT }
    base = target.base_plans.find { |b| b.base_plan_id == PLAN }
    raise 'Active annual base plan missing' unless base&.state == 'ACTIVE' && base.auto_renewing_base_plan_type&.billing_period_duration == 'P1Y'
    conversion = service.convert_monetization_region_prices(PACKAGE,
      A::ConvertRegionPricesRequest.new(price: A::Money.new(currency_code: 'USD', units: 1, nanos: 0)))
    # Keep current regions/availability; only update their prices. Google returns
    # tax-inclusive regional prices. Never add its taxAmount again.
    body = JSON.parse(target.to_json)
    body['basePlans'].each { |b| b.delete('state'); b.delete('basePlanVersion') }
    yearly = body['basePlans'].find { |b| b['basePlanId'] == PLAN }
    yearly['regionalConfigs'].each do |r|
      converted = conversion.converted_region_prices.fetch(r['regionCode'])
      r['price'] = JSON.parse(converted.price.to_json)
      # Country-specific charm pricing must not turn the requested USD1 into .99.
      r['price'] = { 'currencyCode' => 'USD', 'units' => '1', 'nanos' => 0 } if r['regionCode'] == 'US'
    end
    if yearly['otherRegionsConfig']
      other = JSON.parse(conversion.converted_other_regions_price.to_json)
      yearly['otherRegionsConfig']['usdPrice'] = other.fetch('usdPrice')
      yearly['otherRegionsConfig']['eurPrice'] = other.fetch('eurPrice')
    end
    expected_prices = yearly.fetch('regionalConfigs').to_h { |r| [r.fetch('regionCode'), r.fetch('price')] }
    annual_offers = service.list_monetization_subscription_base_plan_offers(PACKAGE, PRODUCT, PLAN).subscription_offers || []
    intent = { 'package' => PACKAGE, 'product' => PRODUCT, 'plan' => PLAN,
      'base_currency' => 'USD', 'base_units' => 1, 'base_tax_exclusive' => true,
      'region_version' => conversion.region_version.version,
      'prices' => expected_prices,
      'regional_configs' => yearly.fetch('regionalConfigs'),
      'other_regions' => yearly['otherRegionsConfig'],
      'close_annual_offers' => annual_offers.select { |o| o.state == 'ACTIVE' }.map(&:offer_id).sort,
      'lifetime_before' => lifetime_states,
      'before' => JSON.parse(JSON.generate(summary(catalog))) }
    sha = Digest::SHA256.hexdigest(JSON.generate(canonical(intent)))
    receipt = File.exist?(receipt_path) ? JSON.parse(File.read(receipt_path)) : nil
    if receipt && receipt.fetch('operations', {}).values.any? { |o| %w[sent response_unknown].include?(o['state']) }
      raise 'Unresolved operation: read remote status before any retry'
    end
    unless ARGV.include?('--apply')
      record = { 'state' => 'prepared', 'preview_sha256' => sha, 'intent' => intent,
        'before_snapshot' => catalog.map { |s| JSON.parse(s.to_json) },
        'lifetime_snapshot' => JSON.parse(lifetime.to_json), 'operations' => {} }
      raise 'Completed receipt exists; use --status' if receipt && receipt['state'] == 'confirmed'
      File.write(receipt_path, JSON.pretty_generate(record))
      puts JSON.pretty_generate(preview_sha256: sha, annual_product: PRODUCT, annual_plan: PLAN,
        base_price: 'USD 1/year before applicable taxes', monthly_ai_allowance: 100,
        regional_prices: expected_prices.select { |r, _| %w[US TR GB DE].include?(r) },
        active_plans_to_close: summary(catalog).flat_map { |s| s[:plans].select { |b| b[:state] == 'ACTIVE' && [s[:product], b[:id]] != [PRODUCT, PLAN] }.map { |b| "#{s[:product]}/#{b[:id]}" } },
        annual_offers_to_close: intent['close_annual_offers'], lifetime_options_to_close: lifetime_states.select { |o| o[:state] == 'ACTIVE' })
      return
    end
    wanted = ARGV[ARGV.index('--expected-sha').to_i + 1] if ARGV.include?('--expected-sha')
    raise 'Preview changed: prepare and inspect again' unless receipt && wanted == sha && receipt['preview_sha256'] == sha
    save = lambda do
      tmp = receipt_path + '.tmp'
      File.write(tmp, JSON.pretty_generate(receipt))
      File.rename(tmp, receipt_path)
    end
    operation = lambda do |key, &action|
      receipt['operations'][key] = { 'state' => 'sent', 'sent_utc' => Time.now.utc.iso8601 }
      save.call
      begin
        action.call
        receipt['operations'][key]['state'] = 'confirmed'
        receipt['operations'][key]['readback_utc'] = Time.now.utc.iso8601
        save.call
      rescue StandardError
        receipt['operations'][key]['state'] = 'response_unknown'
        save.call
        raise
      end
    end
    operation.call('annual_prices') do
      update = A::Subscription.from_json(JSON.generate(body.slice('packageName', 'productId', 'basePlans')))
      service.patch_monetization_subscription(PACKAGE, PRODUCT, update,
        update_mask: 'basePlans', regions_version_version: conversion.region_version.version)
      current = service.get_monetization_subscription(PACKAGE, PRODUCT).base_plans.find { |b| b.base_plan_id == PLAN }
      raise 'Regional availability changed' unless current.regional_configs.map(&:region_code).sort == expected_prices.keys.sort
      current.regional_configs.each do |r|
        e = expected_prices.fetch(r.region_code)
        raise 'Regional price readback mismatch' unless r.price.currency_code == e['currencyCode'] && r.price.units.to_i == e.fetch('units', 0).to_i && r.price.nanos.to_i == e.fetch('nanos', 0).to_i
        original = yearly['regionalConfigs'].find { |v| v['regionCode'] == r.region_code }
        raise 'Availability flag changed' unless !!r.new_subscriber_availability == !!original['newSubscriberAvailability']
      end
      raise 'Other regions changed' unless canonical(JSON.parse(current.other_regions_config.to_json)) == canonical(yearly['otherRegionsConfig'])
    end
    catalog.each do |s|
      s.base_plans.each do |b|
        next if [s.product_id, b.base_plan_id] == [PRODUCT, PLAN] || b.state != 'ACTIVE'
        operation.call("close:#{s.product_id}/#{b.base_plan_id}") do
          service.batch_monetization_subscription_base_plan_update_states(PACKAGE, s.product_id,
            A::BatchUpdateBasePlanStatesRequest.new(requests: [A::UpdateBasePlanStateRequest.new(
              deactivate_base_plan_request: A::DeactivateBasePlanRequest.new(package_name: PACKAGE,
                product_id: s.product_id, base_plan_id: b.base_plan_id))]))
          now = service.get_monetization_subscription(PACKAGE, s.product_id).base_plans.find { |x| x.base_plan_id == b.base_plan_id }
          raise 'Base plan still active' if now.state == 'ACTIVE'
        end
      end
    end
    # Existing annual offers must not expose a different price or trial contract.
    offers = service.list_monetization_subscription_base_plan_offers(PACKAGE, PRODUCT, PLAN).subscription_offers || []
    raise 'Annual offers changed since preview' unless offers.select { |o| o.state == 'ACTIVE' }.map(&:offer_id).sort == intent['close_annual_offers']
    offers.select { |o| o.state == 'ACTIVE' }.each do |o|
      operation.call("close_offer:#{o.offer_id}") do
        service.deactivate_subscription_offer(PACKAGE, PRODUCT, PLAN, o.offer_id,
          A::DeactivateSubscriptionOfferRequest.new(package_name: PACKAGE, product_id: PRODUCT, base_plan_id: PLAN, offer_id: o.offer_id))
        now = service.get_monetization_subscription_base_plan_offer(PACKAGE, PRODUCT, PLAN, o.offer_id)
        raise 'Offer still active' if now.state == 'ACTIVE'
      end
    end
    lifetime.purchase_options.select { |o| o.state == 'ACTIVE' }.each do |o|
      operation.call("close_lifetime:#{o.purchase_option_id}") do
        service.batch_monetization_onetimeproduct_purchase_option_update_states(PACKAGE, LIFETIME,
          A::BatchUpdatePurchaseOptionStatesRequest.new(requests: [A::UpdatePurchaseOptionStateRequest.new(
            deactivate_purchase_option_request: A::DeactivatePurchaseOptionRequest.new(package_name: PACKAGE,
              product_id: LIFETIME, purchase_option_id: o.purchase_option_id))]))
        now = service.get_monetization_onetimeproduct(PACKAGE, LIFETIME).purchase_options.find { |x| x.purchase_option_id == o.purchase_option_id }
        raise 'Lifetime option still active' if now.state == 'ACTIVE'
      end
    end
    final = PRODUCTS.map { |id| service.get_monetization_subscription(PACKAGE, id) }
    active = final.flat_map { |s| s.base_plans.select { |b| b.state == 'ACTIVE' }.map { |b| [s.product_id, b.base_plan_id] } }
    raise 'Annual Pro not the sole active plan' unless active == [[PRODUCT, PLAN]]
    lifetime_after = service.get_monetization_onetimeproduct(PACKAGE, LIFETIME).purchase_options.map { |o| { id: o.purchase_option_id, state: o.state } }
    raise 'Lifetime remains active' if lifetime_after.any? { |o| o[:state] == 'ACTIVE' }
    offers_after = service.list_monetization_subscription_base_plan_offers(PACKAGE, PRODUCT, PLAN).subscription_offers || []
    raise 'Annual offers remain active' if offers_after.any? { |o| o.state == 'ACTIVE' }
    receipt['state'] = 'confirmed'
    receipt['after'] = summary(final)
    receipt['lifetime_after'] = lifetime_after
    receipt['annual_offers_after'] = offers_after.map { |o| { id: o.offer_id, state: o.state } }
    save.call
    puts JSON.pretty_generate(state: 'confirmed', catalog: summary(final))
  end
end

begin
  AnnualPro.run if $PROGRAM_NAME == __FILE__
rescue StandardError => e
  warn "Annual catalog action stopped: #{e.class}#{e.respond_to?(:status_code) ? " HTTP #{e.status_code}" : ''}; inspect private receipt and remote readback. No credentials displayed."
  exit 1
end
