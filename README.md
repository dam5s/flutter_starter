# Flutter Starter

## Intro

This is a starter project for Flutter based mobile applications.
Some of the code is useful for desktop apps too.
This is an example of a simple mobile app with API integration and how to set it up with some
dependency injection and predictable testing of API integrations.

* See [`AppDependencies`](weather_app/lib/app_dependencies/app_dependencies.dart) for some simple dependency injection using
  a [Provider](https://pub.dev/packages/provider).
* See [`TestDepdendencies`](weather_app/test/test_dependencies.dart) for injection of test dependencies.
* See [`result.dart`](weather_app/lib/prelude/result.dart) for functional handling of errors.
* See [`json_decoder.dart`](weather_app/lib/networking/json_decoder.dart) for simple json decoding (careful it can throw exception).
* See [`http.dart`](weather_app/lib/networking/http.dart) for exception free API integrations including safe json
  parsing.
* See [`location_search_api.dart`](weather_app/lib/location_search/location_search_api.dart) for a usage example of all the
  above.
* See [`location_search_page_test.dart`](weather_app/test/location_search/location_search_page_test.dart) for an example test
  with API integration.
* See [`main.dart`](weather_app/lib/main.dart) for the main app scaffolding.
* See [`app_pages`](weather_app/lib/app_pages/) for the UI.

## Dev Environment setup

* Install [Flutter](https://flutter.dev/)
* Install [Android Studio](https://developer.android.com/studio) with Flutter and Dart plugins
* Install [XCode](https://developer.apple.com/xcode/) for iOS dev

## Running checks

This checks formatting, runs tests and checks for dependency cycles

```
make check
```

## Running the app

### On Android Emulator

* In Android Studio, setup an emulator in the `Device Manager`.
* Run it using the play button in `Device Manager`
* It switches to the `Running Devices` view.
* Select the emulator from the device list next to the run configuration.
* Run `main.dart`

### On iOS Simulator (MacOS+XCode required)

* Start the `iOS Simulator` app
* Install and Run the iPhone Simulator of your choice.
* In Android Studio, select the simulator from the device list next to the run configuration.
* Run `main.dart`

### On Android or iOS Device

* Configure device for developer mode (see Android/iOS documentation for that)
* Connect to your computer
* Select in Android Studio's device list
* Run `main.dart`

### Formatting

We use a line length of `100` characters, which is good enough to show two files side by side on a modern 27 inch
screen.
Line length can be set in Android Studio `Preferences > Editor > Code Style > Dart`.

If your prefer a different line length, feel free to update the `Tasks.mk` to your team's liking
and have developers configure their IDE as well.

### Cyclic dependencies

Make sure your imports are relative only for files in the same folder, otherwise use `package:` imports.
