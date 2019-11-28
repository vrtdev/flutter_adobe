#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'adobe_analytics'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin to bridge Adobe Experience Experience Platform SDKs.'
  s.description      = <<-DESC
Uses a Flutter method channel to setup ACPCore and bridge analytics events.
                       DESC
  s.homepage         = 'https://github.com/vrtdev/flutter_adobe_experience_platform'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'VRT' => 'jeremie.vincke@vrt.be' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'ACPAnalytics', '~> 2.0'
  s.dependency 'ACPCore', '~> 2.0'
  s.static_framework = true

  s.ios.deployment_target = '10.0'
end

