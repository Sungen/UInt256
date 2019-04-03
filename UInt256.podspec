
Pod::Spec.new do |s|
  s.name             = 'UInt256'
  s.version          = '1.0.2'
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
  
  s.subspec 'CUInt256' do |ss|
    ss.source_files = 'Sources/CUInt256/**/*.{h,c}'
    ss.public_header_files = 'Sources/CUInt256/**/*.h'
  end

  s.subspec 'UInt256' do |ss|
    ss.source_files = 'Sources/UInt256/**/*.{swift}'
  end

end
