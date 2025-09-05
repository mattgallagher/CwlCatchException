Pod::Spec.new do |s|
  s.name         = 'CwlCatchExceptionSupport'
  s.version      = '2.2.2'
  s.summary      = 'Objective-C internal library used by CwlCatchException'
  s.homepage     = 'https://github.com/mattgallagher/CwlCatchException'
  s.license      = { :file => 'LICENSE.txt', :type => 'ISC' }
  s.author       = 'Matt Gallagher'
  s.source       = {
                    :git => 'https://github.com/mattgallagher/CwlCatchException.git',
                    :tag => s.version.to_s
                   }
  
  s.source_files = 'Sources/CwlCatchExceptionSupport/CwlCatchException.m', 'Sources/CwlCatchExceptionSupport/include/CwlCatchException.h'
  
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.14'
  s.visionos.deployment_target = '1.0'

  s.swift_version = '5.5'
  
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.14'
end
