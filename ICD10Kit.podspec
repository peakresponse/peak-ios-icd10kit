#
# Be sure to run `pod lib lint ICD10Kit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ICD10Kit'
  s.version          = '0.1.0'
  s.summary          = 'ICD10Kit is a library for embedding ICD-10-CM codes as a Realm database.'
  s.description      = <<-DESC
ICD10Kit is a library for embedding ICD-10-CM codes as a Realm database. The example
application included with the library can be run on a Mac OS desktop to read ICD-10-CM
code files and generate a compacted Realm database that can be bundled into an iOS app.
                       DESC

  s.homepage         = 'https://github.com/peakresponse/peak-ios-icd10kit'
  s.license          = { :type => 'LGPL', :file => 'LICENSE.md' }
  s.author           = { 'Francis Li' => 'francis@peakresponse.net' }
  s.source           = { :git => 'https://github.com/peakresponse/peak-ios-icd10kit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.4'

  s.source_files = 'ICD10Kit/Classes/**/*'
  s.dependency 'RealmSwift', '>=10.11.0'
end
