//
//  Hub1_0App.swift
//  Hub1.0
//
//  Created by Luke Arsenault on 12/13/20.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

@main
struct Hub1_0App: App {
@UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
}
