#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ios_color_picker.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'ios_color_picker'
  s.version          = '3.0.0'
  s.summary          = 'An iOS-style color picker Flutter plugin.'
  s.description      = <<-DESC
Provides an iOS-style color picker UI for Flutter desktop and mobile apps.
                       DESC
  s.homepage         = 'https://github.com/mokhselim/ios_color_picker'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mohamed Khaled Selim' => 'https://github.com/mokhselim' }

  s.source           = { :path => '.' }
  s.source_files = 'ios_color_picker/Sources/ios_color_picker/**/*.swift'

  # If your plugin requires a privacy manifest, for example if it collects user
  # data, update the PrivacyInfo.xcprivacy file to describe your plugin's
  # privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  s.resource_bundles = {'ios_color_picker_privacy' => ['ios_color_picker/Sources/ios_color_picker/Resources/PrivacyInfo.xcprivacy']}

  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.15'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
