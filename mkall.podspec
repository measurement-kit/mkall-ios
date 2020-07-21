Pod::Spec.new do |s|
  s.name = "mkall"
  s.version = "0.10.0"
  s.summary = "Measurement Kit iOS libraries"
  s.author = "Simone Basso"
  s.homepage = "https://github.com/measurement-kit"
  s.license = { :type => "BSD" }
  s.source = {
    :git => "https://github.com/measurement-kit/mkall-ios.git",
    :tag => "v#{s.version}"
  }
  s.prepare_command = <<-CMD
    url="https://github.com/measurement-kit/mkall-ios/releases/download/v#{s.version}/mkall.framework.zip"
    sha256="a1990f795d0e596ce879e542a05fb1b0a9337e53f36326de7c1f7da5e86390fa"
    ./script/cocoapods/prepare $url $sha256
  CMD
  s.platform = :ios, "9.0"
  s.vendored_framework = "mkall.framework"
end
