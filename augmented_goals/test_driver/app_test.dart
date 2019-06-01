// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Login To App', () {
    // First, define the Finders. We can use these to locate Widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    Future.delayed(Duration(seconds: 3));

    //final facebookLoginButton = find.byValueKey('facebookLogin');
    final googleLoginButton = find.byValueKey('googleLogin');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests
    setUpAll(() async {
      driver = await FlutterDriver.connect(dartVmServiceUrl: "http://127.0.0.1:8888/");
    });

    // Close the connection to the driver after the tests have completed
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

/*    test('Facebook Login Starts', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(facebookLoginButton), "Login with Facebook");
      // await driver.tap(facebookLoginButton);

    });*/

    test('Google Login Starts', () async {
      print(driver.getText(googleLoginButton));

/*
      expect(await driver.getText(googleLoginButton), "Login with Google");
*/

      // First, tap on the button
      // await driver.tap(googleLoginButton);
    });
  });
}