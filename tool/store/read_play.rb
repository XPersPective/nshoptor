# Read only release/product summary. The temporary edit is never committed.
# Usage: ruby tool/store/read_play.rb <service-account-file> <package-name>
require 'json'
require 'google/apis/androidpublisher_v3'
require 'googleauth'

service = Google::Apis::AndroidpublisherV3::AndroidPublisherService.new
File.open(ARGV.fetch(0)) do |key|
  service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
    json_key_io: key, scope: 'https://www.googleapis.com/auth/androidpublisher')
end
package = ARGV.fetch(1)
edit = nil
begin
  edit = service.insert_edit(package)
  tracks = service.list_edit_tracks(package, edit.id).tracks || []
  listings = service.list_edit_listings(package, edit.id).listings || []
  bundles = service.list_edit_bundles(package, edit.id).bundles || []
  subscriptions = []
  token = nil
  loop do
    page = service.list_monetization_subscriptions(package, page_size: 100, page_token: token)
    subscriptions.concat((page.subscriptions || []).map { |s|
      {product_id: s.product_id, plans: (s.base_plans || []).map { |b|
        {id: b.base_plan_id, state: b.state} }} })
    token = page.next_page_token
    break if token.nil? || token.empty?
  end
  puts JSON.pretty_generate({package: package,
    bundles: bundles.map { |b| {version_code: b.version_code, sha256: b.sha256} },
    tracks: tracks.map { |t| {track: t.track, releases: (t.releases || []).map { |r|
      {name: r.name, status: r.status, version_codes: r.version_codes} }} },
    listing_locales: listings.map(&:language).sort, subscriptions: subscriptions})
rescue StandardError => e
  warn "Play readback failed: #{e.class}#{e.respond_to?(:status_code) ? " HTTP #{e.status_code}" : ''}"
  exit 1
ensure
  if edit
    begin
      service.delete_edit(package, edit.id)
    rescue StandardError => e
      warn "Temporary edit cleanup unconfirmed: #{edit.id} #{e.class}"
    end
  end
end
