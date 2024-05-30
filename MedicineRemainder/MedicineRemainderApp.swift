//
//  MedicineRemainderApp.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import SwiftUI
import UserNotifications
import UserNotificationsUI

// AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate , UNUserNotificationCenterDelegate{
    
    // Called when app launch
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    // Called when received notification in app active
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show the notification banner while the app is active
        let alertController = UIAlertController(title: notification.request.content.title, message: notification.request.content.body, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        completionHandler([.banner , .badge , .sound , .alert])
    }
    
    // Called when the user taps on a notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle the notification response
        let content = response.notification.request.content
        
        // Show an alert
        let alertController = UIAlertController(title: content.title, message: content.body, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        // Call the completion handler
        completionHandler()
    }
}

@main
struct MedicineRemainderApp: App {
    // Access to AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init(){
        UINavigationBarAppearance().backgroundColor = .clear
        UINavigationBarAppearance().shadowImage = UIImage()
        UINavigationBarAppearance().backgroundImage = UIImage()
        
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
