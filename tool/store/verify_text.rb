# Read-only text metadata verification against reviewed local files.
require 'json'
require 'google/apis/androidpublisher_v3'
require 'googleauth'
root = ENV.fetch('APP_PUBLISHING_ROOT', 'D:/AppPublishing')
service = Google::Apis::AndroidpublisherV3::AndroidPublisherService.new
File.open(File.join(root, 'publisher/crazypenguin/credentials/google-play/service-account.json')) do |f|
 service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(json_key_io: f, scope: 'https://www.googleapis.com/auth/androidpublisher')
end
package = 'com.crazypenguin.nshoptor'
edit = nil
begin
 edit = service.insert_edit(package)
 listings = service.list_edit_listings(package, edit.id).listings || []
 metadata = File.join(root, 'apps/nshoptor/stores/google-play/metadata')
 expected = Dir.children(metadata).select { |l| File.file?(File.join(metadata,l,'full_description.txt')) }
 errors = []
 expected.each do |locale|
  remote = listings.find { |l| l.language == locale }
  if remote.nil?
   errors << "#{locale}:missing"
   next
  end
  { 'title.txt' => :title, 'short_description.txt' => :short_description, 'full_description.txt' => :full_description }.each do |name, field|
   errors << "#{locale}:#{name}" unless remote.public_send(field).to_s.strip == File.read(File.join(metadata,locale,name),encoding:'UTF-8').strip
  end
 end
 puts JSON.pretty_generate(package: package, checked_locales: expected.size, mismatches: errors)
 exit(errors.empty? ? 0 : 1)
rescue StandardError => e
 warn "Metadata readback failed: #{e.class}#{e.respond_to?(:status_code) ? " HTTP #{e.status_code}" : ''}"
 exit 1
ensure
 service.delete_edit(package,edit.id) if edit
end
