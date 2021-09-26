Pod::Spec.new do |s|
  s.name         = 'CwlCatchExceptionSupport'
  s.version      = '2.1.0'
  s.summary      = 'Objective-C internal library used by CwlCatchException'
  s.homepage     = 'https://github.com/mattgallagher/CwlCatchException'
  s.license      = { :file => 'LICENSE.txt', :type => 'ISC' }
  s.author       = 'Matt Gallagher'
  s.source       = { :git => 'https://github.com/mattgallagher/CwlCatchException.git', :tag => s.version.to_s }
  
  s.source_files = 'Sources/CwlCatchExceptionSupport/**/*.{h,m}'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
end
