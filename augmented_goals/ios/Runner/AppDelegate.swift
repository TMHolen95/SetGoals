import UIKit
import Flutter
import Firebase
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    
    if FirebaseApp.app() == nil {
        FirebaseApp.configure()
    }
    
    // cancel old notifications that were scheduled to be periodically shown upon a reinstallation of the app
    if UserDefaults.standard.object(forKey: "Notification") == nil {
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications() // To remove all delivered notifications
        center.removeAllPendingNotificationRequests() // To remove all pending notifications which are not delivered yet but scheduled. 

        UserDefaults.standard.set(true, forKey: "Notification")
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
