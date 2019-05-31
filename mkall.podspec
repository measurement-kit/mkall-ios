Pod::Spec.new do |s|
  s.name = "mkall"
  s.version = 0.5.0
  s.summary = "Measurement Kit iOS libraries"
  s.author = "Simone Basso"
  s.homepage = "https://github.com/measurement-kit"
  s.license = { :type => "BSD" }
  s.source = {
    :http => "https://github.com/measurement-kit/mkall-ios/releases/download/v#{s.version}/mkall.framework.zip",
    :sha256 => "5a17587b866b8e625ac4c86cb5a8561fc09405c0ac10295f98f202c2839fd31c"
  }
  s.platform = :ios, "9.0"
  s.vendored_framework = "mkall.framework"
end
