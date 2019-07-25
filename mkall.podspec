Pod::Spec.new do |s|
  s.name = "mkall"
  s.version = "0.5.3"
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
    sha256="f315138552daa4aeb7ad4c7eb1f185f03394100a85ab1f96d477576ccaa8d4e8"
    ./script/cocoapods/prepare $url $sha256
  CMD
  s.platform = :ios, "9.0"
  s.vendored_framework = "mkall.framework"
end
