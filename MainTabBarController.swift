//
//  MainTabBarController.swift
//  AnimationTabBarItemsDemo
//
//  Created by Harvey Zhang on 16/3/5.
//  Copyright © 2016 HappyGuy. All rights reserved.
//

import UIKit

class MainTabBarController: AnimationTabBarController, UITabBarControllerDelegate {

    fileprivate var firstLoadMainTabBarController = true
    fileprivate var adImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
		// Do any additional setup after loading the view.
        
        delegate = self				// for tabBar controller delegate
		
        createMainTabBarChildVC()	// add child VCs
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if firstLoadMainTabBarController	// only once
		{
			let viewContainers = createViewContainers()
			createCustomIcons(viewContainers)
			
			firstLoadMainTabBarController = false
		}
	}
	
    // MARK: - Private helpers
	
    fileprivate func createMainTabBarChildVC()
	{
        tabBarControllerAddChildVC(HomeViewController(), title: "Home", imageName: "v2_home",
                                   selectedImageName: "v2_home_r", tag: 0)
        tabBarControllerAddChildVC(MarketViewController(), title: "Supermarket", imageName: "v2_order",
                                   selectedImageName: "v2_order_r", tag: 1)
        tabBarControllerAddChildVC(ShopViewController(), title: "Shop", imageName: "shopCart",
                                   selectedImageName: "shopCart", tag: 2)
        tabBarControllerAddChildVC(MineViewController(), title: "Mine", imageName: "v2_my",
                                   selectedImageName: "v2_my_r", tag: 3)
    }
    
    fileprivate func tabBarControllerAddChildVC(_ childView: UIViewController, title: String, imageName: String,
                                                selectedImageName: String, tag: Int)
	{
        let animateableTabBarItem = RAMAnimatedTabBarItem(title: title, image: UIImage(named: imageName),
                                                          selectedImage: UIImage(named: selectedImageName))
        animateableTabBarItem.tag = tag
        animateableTabBarItem.animation = RAMBounceAnimation()
		
		// !!!: The tab bar item that represents the view controller when added to a tab bar controller.
        childView.tabBarItem = animateableTabBarItem
		
		// Org
		let baseNavi = BaseNavigationController(rootViewController:childView)
		addChildViewController(baseNavi)
		
		// New by HZ for testing
//		let normalNavi = UINavigationController(rootViewController: childView)
//      addChildViewController(normalNavi)
    }
	
	// MARK: - UITabBarControllerDelegate method
	
	/*
	Asks the delegate whether the specified view controller should be made active.
	The tab bar controller calls this method in response to the user tapping a tab bar item. You can use this method to dynamically decide whether a given tab should be made the active tab.
	*/
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
	{
        let childArrary = tabBarController.childViewControllers as NSArray
        let index = childArrary.index(of: viewController)
        if index == 2 {
            return false
        }
		
        return true
    }
	
}
