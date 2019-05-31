Pod::Spec.new do |s|
  s.name = "mkall"
  s.version = "0.5.1"
  s.summary = "Measurement Kit iOS libraries"
  s.author = "Simone Basso"
  s.homepage = "https://github.com/measurement-kit"
  s.license = { :type => "BSD" }
  s.source = {
    :http => "https://github.com/measurement-kit/mkall-ios/releases/download/v#{s.version}/mkall.framework.zip",
    :sha256 => "5b88780b25709c01f9016c9e5ce034bfe1b1ca8c56406a881248d2e022b7c13b"
  }
  s.platform = :ios, "9.0"
  s.vendored_framework = "Carthage/Build/iOS/mkall.framework"
end
