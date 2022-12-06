Pod::Spec.new do |s|
  s.name = 'ApiVideoUploader'
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'
  s.version = '1.1.0'
  s.source = { :git => 'https://github.com/apivideo/api.video-ios-uploader', :tag => 'v1.1.0' }
  s.authors = { 'Ecosystem Team' => 'ecosystem@api.video' }
  s.license = { :type => 'MIT' }
  s.homepage = 'https://docs.api.video'
  s.summary = 'The official iOS video uploader for api.video '
  s.source_files = 'Sources/**/*.swift'
  s.dependency 'AnyCodable-FlightSchool', '~> 0.6.1'
  s.dependency 'Alamofire', '~> 5.4.3'
end
