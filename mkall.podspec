Pod::Spec.new do |s|
  s.name = "mkall"
  s.version = "0.3.8"
  s.summary = "Measurement Kit iOS libraries"
  s.author = "Simone Basso"
  s.homepage = "https://github.com/measurement-kit"
  s.license = { :type => "BSD" }
  s.source = {
    :git => "https://github.com/measurement-kit/mkall-ios.git",
    :tag => "v#{s.version}"
  }
  s.prepare_command = <<-CMD
    ./script/cocoapods/prepare
  CMD
  s.platform = :ios, "9.0"
  s.vendored_framework = "mkall.framework"
end
