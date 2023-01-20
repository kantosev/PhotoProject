//
//  AppDelegate.swift
//  PetProject
//
//  Created by Антон Кирилюк on 03.11.2022.
//

import UIKit
import ParseSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ParseSwift.initialize(applicationId: "3qHLuFG43vEm3RVhlVrE62qK8RVDiRtDWCzlbTmy",
                              clientKey: "GAMe7XdBym157Zz2dC2WUOUDnp0VqoG81eEvu5v7",
                              serverURL: URL(string: "https://parseapi.back4app.com")!)
        NetworkMonitor.shared.startMonitoring()
        
        // Пробные локальные уведомления
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Доступ разрешен")
            } else {
                print("Доступ закрыт")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Пробное уведомление"
        content.body = "Тело уведомления"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
      // Уведомление каждый вторник в 11 утра
//        var dateComponents = DateComponents()
//        dateComponents.calendar = Calendar.current
//
//        dateComponents.weekday = 2  // Tuesday
//        dateComponents.hour = 23    // 11:00 hours
//
//        // Create the trigger as a repeating event.
//        let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //
        let date = Date(timeIntervalSinceNow: 3600)
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
        let trigger3 = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        let request = UNNotificationRequest(identifier: "heh", content: content, trigger: trigger)
        center.add(request)
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

