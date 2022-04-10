//
//  AppDelegate.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit

import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        DispatchQueue.global().async {
            
            let runLoop = RunLoop.current
            
            let calendar = Calendar.autoupdatingCurrent
            let components = DateComponents(calendar: .autoupdatingCurrent, timeZone: .autoupdatingCurrent, hour: 0, minute: 0, second: 0, nanosecond: 0)
            
            let now = Date()
            let next = calendar.nextDate(after: now, matching: components, matchingPolicy: .nextTime)!
            print("now: \(now)")
            print("next: \(next)")
            
            let timer = Timer(fireAt: next, interval: 60 * 60 * 24, target: self, selector: #selector(self.resetWaterIntake), userInfo: nil, repeats: true)
            runLoop.add(timer, forMode: .common)
            runLoop.run()
        }
        
        //        UserDefaults.resetUserDefaults() // for test
        
        return true
    }
    
    @objc private func resetWaterIntake() {
        
        DispatchQueue.main.async {
            print(#function, Date())
            UserDefaults.todayIntake = UserDefaults.$todayIntake
            UserDefaults.todayLastIntake = UserDefaults.$todayLastIntake
            NotificationCenter.default.post(name: .notiToResetIntake, object: nil, userInfo: nil)
        }
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
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return [.portrait]
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 포그라운드 수신: willPresent
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(#function)
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        if #available(iOS 14.0, *) {
            completionHandler([.list, .banner, .badge, .sound])
        }
        else {
            completionHandler([.alert, .badge, .sound])
        }
    }
    
    // 사용자가 로컬/푸시를 클릭했을 때 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        print("사용자가 noti를 클릭했습니다.")
        
        print(response.notification.request.content.body)
        
        // userInfo: key - 1(광고)/2(채팅방)/3(사용자 설정) 등으로 정의하고 사용할 수 있음
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        
        if userInfo[AnyHashable("key")] as? Int == 1 {
            print("광고 푸시입니다.")
        } else {
            print("다른 푸시입니다.")
        }
        
        completionHandler()
    }
}
