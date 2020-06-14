Pod::Spec.new do |s|
  s.name             = 'RxSupport'
  s.version          = '1.0.0'
  s.summary          = 'Support for RxSwift'

  s.description      = <<-DESC
  Support for RxSwift. Utility.
  DESC

  s.homepage         = 'https://github.com/outofcoding/RxSupport'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'outofcoding' => 'outofcoding@gmail.com' }
  s.source           = { :git => 'https://github.com/outofcoding/RxSupport.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'RxSupport/Classes/**/*'
  s.swift_version = '4.0'
  s.dependency 'RxSwift', '~> 5.0'
  s.dependency 'RxCocoa', '~> 5.0'
end
