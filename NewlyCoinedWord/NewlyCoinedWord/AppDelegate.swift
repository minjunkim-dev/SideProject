//
//  AppDelegate.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if Date.isFirstDayOfMonth() && !(UserDefaults.isFetchWordListOnFirstDayOfMonth) {
            print("1일이고 신조어 리스트 리로드 필요")
            UserDefaults.wordList.removeAll()
        } else {

            if !(Date.isFirstDayOfMonth()) {
                print("1일이 아님")
                UserDefaults.isFetchWordListOnFirstDayOfMonth = false
            }
//             else: 1일이지만 이미 신조어 리스트 로드 완료 상태
        }

        sleep(2) // for splash
        
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
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

