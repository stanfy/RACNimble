Pod::Spec.new do |s|
  s.name             = 'RACNimble'
  s.version          = '0.1.0'
  s.summary          = 'Custom Nimble matchers for Reactive Cocoa.'
  s.description      = <<-DESC
    Custom Nimble matchers for Reactive Cocoa.
    No need to write own, just use this handy one.
                       DESC

  s.homepage         = 'https://github.com/Stanfy/RACNimble'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Stanfy' => 'hello@stanfy.com'  }
  s.source           = { :git => 'https://github.com/Stanfy/RACNimble.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'CustomMatchers.swift'
  s.dependency 'ReactiveCocoa', '~> 4.1'
  s.dependency 'Nimble', '~> 4.1.0'
  s.weak_framework = "XCTest"
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO', 'OTHER_LDFLAGS' => '-weak-lswiftXCTest', 'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(PLATFORM_DIR)/Developer/Library/Frameworks"' }

end