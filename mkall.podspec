Pod::Spec.new do |s|
  s.name = "mkall"
  s.version = "0.6.1"
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
    sha256="a24ff1bf9d11a5a6554193b1cc08099b014cf3aa75de2373121acd36a16e3beb"
    ./script/cocoapods/prepare $url $sha256
  CMD
  s.platform = :ios, "9.0"
  s.vendored_framework = "mkall.framework"
end
