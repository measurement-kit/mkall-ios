# All MK libraries for iOS

[![GitHub license](https://img.shields.io/github/license/measurement-kit/mkall-ios.svg)](https://raw.githubusercontent.com/measurement-kit/mkall-ios/master/LICENSE) [![Github Releases](https://img.shields.io/github/release/measurement-kit/mkall-ios.svg)](https://github.com/measurement-kit/mkall-ios/releases)

All MK libraries for iOS. Integrate using Carthage or CocoaPods.

## Installing and/or updating dependencies

To install dependencies, do:

```
brew tap measurement-kit/measurement-kit
brew install ios-measurement-kit generic-assets
```

To upgrade dependencies, do:

```
brew upgrade
```

## Local development

```
open mkall.xcodeproj
```

## Building framework with Carthage and publishing it

1. make sure that [mkall/Info.plist](mkall/Info.plist) is current;

2. build using ```./build.sh```;

3. commit;

4. tag;

5. push;

6. create a GitHub release;

7. publish the archive into the release.

We'll use the version number in [mkall/Info.plist](mkall/Info.plist).

## Integrate using CocoaPods

```ruby
platform :ios, '9.0'
target 'targetName' do
  pod 'mkall-ios', :git => 'https://github.com/measurement-kit/mkall-ios.git'
end
```
