# All MK libraries for iOS

[![GitHub license](https://img.shields.io/github/license/measurement-kit/mkall-ios.svg)](https://raw.githubusercontent.com/measurement-kit/mkall-ios/master/LICENSE) [![Github Releases](https://img.shields.io/github/release/measurement-kit/mkall-ios.svg)](https://github.com/measurement-kit/mkall-ios/releases)

All MK libraries for iOS. Integrate using Carthage or CocoaPods.

## Local development

```
open mkall.xcodeproj
```

## Building framework with Carthage and publishing it

Building:

```
carthage build --no-skip-current --verbose
```

Archiving:

```
./script/make-tarball
```

Then, bump the version number in `mkall.podspec`.

Then, create a GitHub release, and publish there the archive.

## Integrate using CocoaPods

```ruby
platform :ios, '9.0'
target 'targetName' do
  pod 'mkall-ios', :git => 'https://github.com/measurement-kit/mkall-ios.git'
end
```
