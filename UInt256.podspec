
Pod::Spec.new do |s|
  s.name             = 'UInt256'
  s.version          = '1.1.0'
  s.summary          = 'A short description of UInt256.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Sungen/UInt256'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sungen' => 'jokerwu.sunny@gmail.com' }
  s.source           = { :git => 'https://github.com/Sungen/UInt256.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO', 'SWIFT_SUPPRESS_WARNINGS' => 'YES' }
  
  s.source_files = 'UInt256/Source/**/*.{swift,h,c}'
  s.public_header_files = 'UInt256/Source/**/*.h'

end
