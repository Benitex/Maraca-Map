import UIKit
import Flutter
import GoogleMaps
import FlutterConfigPlugin.h

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Google Maps API Key
    let key: String = FlutterConfigPlugin.env(for: "IOS_MAPS_API_KEY")
    GMSServices.provideAPIKey()
    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
