//
//  BaseNavigationController.swift
//  AnimationTabBarItemsDemo
//
//  Created by Harvey Zhang on 16/3/5.
//  Copyright © 2016 HappyGuy. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    var isAnimation = true

    override func viewDidLoad() {
        super.viewDidLoad()
		
		// The gesture recognizer responsible for popping the top view controller off the navigation stack.
        interactivePopGestureRecognizer?.delegate = nil

        // Do any additional setup after loading the view.
    }
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// Pushes a view controller onto the receiver’s stack and updates the display.
	override func pushViewController(_ viewController: UIViewController, animated: Bool)
	{
		viewController.navigationItem.hidesBackButton = true
		
		if childViewControllers.count > 0 {
			// The navigation item that is immediately below the topmost item on navigation bar’s stack.
			UINavigationBar.appearance().backItem?.hidesBackButton = false
			
			viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
			
			// A Boolean value indicating whether the toolbar at the bottom of the screen is hidden when the view controller is pushed on to a navigation controller.
			viewController.hidesBottomBarWhenPushed = true
		}
		
		super.pushViewController(viewController, animated: animated)
	}

    lazy var backBtn: UIButton = {
		
        // setup back button
        let backBtn = UIButton(type: UIButtonType.custom)
        backBtn.setImage(UIImage(named: "v2_goback"), for: UIControlState())
        backBtn.titleLabel?.isHidden = true
        backBtn.addTarget(self, action: #selector(BaseNavigationController.backBtnClick), for: .touchUpInside)
        backBtn.contentHorizontalAlignment = .left
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
		
        let btnW: CGFloat = ScreenWidth > 375.0 ? 50:44
        backBtn.frame = CGRect(x: 0, y: 0, width: btnW, height: 40)
        
        return backBtn
    }()
	
	func backBtnClick() {
		popViewController(animated: isAnimation)
	}
	
}
