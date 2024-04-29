//
//  Practica6IndApp.swift
//  Practica9
//
//  Created by iOS Lab on 05/03/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import FacebookCore

// Se configura la clase App Delegate, que la piden tanto Facebook como Google para poder iniciar sesión con esos servicios.
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Facebook SDK
        FBSDKCoreKit.ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        FirebaseApp.configure()
        return true
    }
}


@main
struct Practica6IndApp: App {
  // Registrar AppDelegate para el setup de Firebase
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      NavigationView {
          ContentView()
      }
    }
  }
}
