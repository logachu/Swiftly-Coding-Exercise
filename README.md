# Swiftly-Coding-Exercise

This project is an implementation of the [Swiftly coding exercise](https://github.com/Swiftly-Systems/code-exercise-ios/blob/master/README.md).
It consists of an iOS app and two playgrounds.

Because I chose to use this as an opportunity to learn the [Combine framework](https://developer.apple.com/documentation/combine), this project
requires Xcode 11 and iOS 13. The [Combine extension on URLSession](https://developer.apple.com/documentation/foundation/urlsession/datataskpublisher)
is used to fetch data asynchronously with retry from the network and further
Combine operators decode the JSON and pass the result on to the view
controller for rendering.

|Target                     | Description                                                                  |
|---------------------------|------------------------------------------------------------------------------|
|PreviewSampleDataPlayground| Shows the JSON data returned from the endpoint graphically in a single column|
|ManagerSpecialsPlayground  | Shows the main view controller in the live view                              |
|Masonry                    | The iOS app                                                                  |
|ManagerSpecials            | The framework that holds the code shared between both the iOS app and ManagerSpecialsPlayground|

## Getting started

Prerequsites:
* Xcode 11
* Device or simulator running iOS 13 or higher

Building and Running the targets:

1. This project uses [CoCoaPods](http://cocoapods.org). You'll need to
   follow theinstructions to install Cocoapods before building the iOS
   app orrunning ManagerSpecialsPlayground.

2. Once installed, from the command line, cd into the top level
   directory and run `pod install`. This will (re)create
   Masonry.xcworkspace.

3. Open Masonry.xcworkspace in Xcode 11.

4. You can build and run the Masonry target to see the app itself.

5. To run the ManagerSpecialsPlayground, you'll first need to build
   the ManagerSpecial framework target. This will be built already if
   you previously built the iOS app. Then you can choose Editor->Run
   Playground from the menu or click the play button at the bottom
   left.
   