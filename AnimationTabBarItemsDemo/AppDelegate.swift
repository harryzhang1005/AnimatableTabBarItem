//
//  AppDelegate.swift
//  AnimationTabBarItemsDemo
//
//  Created by Harvey Zhang on 16/3/5.
//  Copyright © 2016 HappyGuy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
		
        UITabBar.appearance().backgroundColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
        
        // Observe guide view `Start To Use`
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.loadHomeViewController),
                                               name: NSNotification.Name(rawValue: kGuideViewControllerDidFinish),
                                               object: nil)
		
        createKeyWindow()
        return true
    }
	
	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		
		NotificationCenter.default.removeObserver(self,
		                                          name: NSNotification.Name.init(rawValue: kGuideViewControllerDidFinish),
		                                          object: nil)
	}
	
	// MARK: - Helpers
	
    fileprivate func createKeyWindow() {
        
        window = UIWindow(frame: ScreenBounds)
        window?.makeKeyAndVisible()
		
        let isFirstOpen = UserDefaults.standard.object(forKey: "First")
        if isFirstOpen == nil {
            window?.rootViewController = GuideViewController()
            UserDefaults.standard.set("First", forKey: "First")
        }
		else {
            loadHomeViewController()
        }
    }
	
	func loadHomeViewController() {
        window?.rootViewController = MainTabBarController()
    }
	
}
