Pod::Spec.new do |s|
  s.name = "mkall"
  s.version = "0.3.1"
  s.summary = "Measurement Kit iOS libraries"
  s.author = "Simone Basso"
  s.homepage = "https://github.com/measurement-kit"
  s.license = { :type => "BSD" }
  s.source = {
    :git => "https://github.com/measurement-kit/mkall-ios.git",
    :tag => "v#{s.version}"
  }
  s.platform = :ios, "9.0"
  s.prepare_command = <<-CMD
    xcodebuild
  CMD
  s.vendored_frameworks = "build/Release-iphoneos/mkall.framework"
end
