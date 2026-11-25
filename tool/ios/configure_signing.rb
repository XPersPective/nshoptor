# Apply ephemeral distribution signing to the Runner target only.
require 'xcodeproj'

project_path = File.expand_path('../../ios/Runner.xcodeproj', __dir__)
project = Xcodeproj::Project.open(project_path)
targets = project.targets.select do |target|
  target.name == 'Runner' && target.product_type == 'com.apple.product-type.application'
end
abort 'Expected exactly one Runner application target' unless targets.length == 1

target = targets.first
required = %w[Debug Release Profile]
names = target.build_configurations.map(&:name)
abort 'Runner target is missing a required build configuration' unless (required - names).empty?

target.build_configurations.each do |configuration|
  settings = configuration.build_settings
  settings['CODE_SIGN_STYLE'] = 'Manual'
  settings['DEVELOPMENT_TEAM'] = '53X3279WA3'
  settings['CODE_SIGN_IDENTITY'] = 'Apple Distribution'
  settings['CODE_SIGN_IDENTITY[sdk=iphoneos*]'] = 'Apple Distribution'
  settings['PROVISIONING_PROFILE_SPECIFIER'] = 'NShoptor AppStore'
end

project.save
puts 'Configured manual Apple Distribution signing for the Runner target.'
