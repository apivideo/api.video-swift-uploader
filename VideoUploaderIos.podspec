#
# Be sure to run `pod lib lint VideoUploaderIos.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VideoUploaderIos'
  s.version          = '0.0.3'
  s.summary          = 'A library to upload video files to api.video platform.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  A library to upload video files to api.video platform. It manages splitting video files by chunks when uploading big files.
                      DESC

  s.homepage         = 'https://github.com/apivideo/api.video-ios-uploader'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'api.video ecosystem team' => 'ecosystem@api.video' }
  s.source           = { :git => 'https://github.com/apivideo/api.video-ios-uploader.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'VideoUploaderIos/Classes/**/*'
  s.swift_versions = "4.0"
end
