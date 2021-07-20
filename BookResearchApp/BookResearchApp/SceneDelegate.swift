//
//  SceneDelegate.swift
//  BookResearchApp
//
//  Created by 齋藤勇太 on 2021/05/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        let deviceTypeStoryboard = self.deviceTypeStoryboard()
        
        if let window = window
        {
            window.rootViewController = deviceTypeStoryboard.instantiateInitialViewController() as UIViewController?
        }
        
        self.window?.makeKeyAndVisible()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func deviceTypeStoryboard() -> UIStoryboard
    {
        var storyboard = UIStoryboard()
        let height = UIScreen.main.bounds.size.height
        
        if height == 736 //iPhone7Plus,8Plus
        {
            storyboard = UIStoryboard(name: "Main", bundle: nil)
        }
        else if height == 667 //iPhone7,8,SE2
        {
            storyboard = UIStoryboard(name: "iPhoneSE2", bundle: nil)
        }
        else if height == 812 //iPhoneX,XS,11Pro,12mini
        {
            storyboard = UIStoryboard(name: "iPhoneX", bundle: nil)
        }
        else if height == 844 //iPhone12,12Pro
        {
            storyboard = UIStoryboard(name: "iPhone12", bundle: nil)
        }
        else if height == 896 //iPhoneXS Max,XR,11,11Pro Max
        {
            storyboard = UIStoryboard(name: "iPhone11", bundle: nil)
        }
        else if height == 926 //iPhone12Pro Max
        {
            storyboard = UIStoryboard(name: "iPhone12ProMax", bundle: nil)
        }
        else
        {
            storyboard = UIStoryboard(name: "Main", bundle: nil)
        }
        
        return storyboard
        
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

