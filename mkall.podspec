Pod::Spec.new do |s|
  s.name = "mkall"
  s.version = "0.6.0"
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
    sha256="7dafdfba52c9122a112548557e4a7236972e64f3998007e095f9cb86045ac8b6"
    ./script/cocoapods/prepare $url $sha256
  CMD
  s.platform = :ios, "9.0"
  s.vendored_framework = "mkall.framework"
end
