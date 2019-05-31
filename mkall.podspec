Pod::Spec.new do |s|
  s.name = "mkall"
  s.version = 0.5.0
  s.summary = "Measurement Kit iOS libraries"
  s.author = "Simone Basso"
  s.homepage = "https://github.com/measurement-kit"
  s.license = { :type => "BSD" }
  s.source = {
    :http => "https://github.com/measurement-kit/mkall-ios/releases/download/v#{s.version}/mkall.framework.zip",
    :sha256 => "f9bf341c461b18505fb4d7c6a2f4d7177b210283870feb58aaabd26b407e7f9e"
  }
  s.platform = :ios, "9.0"
  s.vendored_framework = "mkall.framework"
end
