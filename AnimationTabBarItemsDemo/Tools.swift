//
//  Tools.swift
//  AnimationTabBarItemsDemo
//
//  Created by Harvey Zhang on 16/3/5.
//  Copyright © 2016 HappyGuy. All rights reserved.
//

import UIKit

// MARK: - Constants

public let LGJGlobalBackgroundColor = UIColor.colorWithCustom(r: 239, g: 239, b: 239)

public let ScreenBounds: CGRect = UIScreen.main.bounds
public let ScreenWidth: CGFloat = ScreenBounds.size.width
public let ScreenHeight: CGFloat = ScreenBounds.size.height

public let kGuideViewControllerDidFinish = "GuideViewControllerDidFinish"

// MARK: - Extensions

extension UIView {
    
    var x:CGFloat {
        return self.bounds.origin.x
    }
    var y:CGFloat {
        return self.bounds.origin.y
    }
    var width:CGFloat {
        return self.bounds.size.width
    }
    var height:CGFloat {
        return self.bounds.size.height
    }
    var size: CGSize {
        return self.bounds.size
    }
    var point:CGPoint {
        return self.frame.origin
    }
    
}

extension UIColor {
	
	class func colorWithCustom(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
		return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
	}
	
}
