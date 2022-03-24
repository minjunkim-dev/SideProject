//
//  SceneDelegate.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        UserDefaults.resetUserDefaults() // for test
        
        let vc = NewlyCoinedWordViewController()
        switch NetworkManager.checkMonitor() {
        case .satisfied:
            print("네트워크 연결 성공!")

            /* 신조어 리스트가 아직 구성되지 않은 경우 */
            if UserDefaults.wordList.isEmpty {
                DispatchQueue.main.async {

                    vc.mainView.hud.textLabel.text = "리스트를 구성중입니다.\n잠시만 기다려주세요."
                    vc.mainView.hud.show(in: vc.mainView, animated: true)
                    vc.viewModel.searchWords(query: "신조어") {
                        vc.mainView.hud.dismiss(animated: true)
                    }
                }
            } else {
                vc.viewModel.wordList.value = UserDefaults.wordList

                vc.viewModel.wordList.value.count > vc.viewModel.maxHashTagsNumber ?
                vc.viewModel.makeHashTags(number: vc.viewModel.maxHashTagsNumber) :
                vc.viewModel.makeHashTags(number: vc.viewModel.wordList.value.count)
            }
        case .unsatisfied, .requiresConnection:
            print("네트워크 연결 실패!")
        @unknown default:
            print("네트워크 연결 실패!")
        }

        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

