Pod::Spec.new do |s|
  s.name = "mkall"
  s.version = "0.5.5"
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
    sha256="57150db4ced938109862ef9e57307ed25a28ea38171ef66ff0d8850f7736001e"
    ./script/cocoapods/prepare $url $sha256
  CMD
  s.platform = :ios, "9.0"
  s.vendored_framework = "mkall.framework"
end
