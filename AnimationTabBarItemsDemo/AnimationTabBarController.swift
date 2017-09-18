//
//  AnimationTabBarController.swift
//  AnimationTabBarItemsDemo
//
//  Created by Harvey Zhang on 16/3/5.
//  Copyright © 2016 HappyGuy. All rights reserved.

import UIKit

// Animate bar button items (tabBar or toolbar)

protocol RAMItemAnimationProtocol {
    func playAnimation(_ icon: UIImageView, textLabel:UILabel)
    func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor)
    func selectedState(_ icon: UIImageView, textLabel: UILabel)
}

class RAMItemAnimation: NSObject, RAMItemAnimationProtocol {
    
    var duration: CGFloat = 0.6
    var textSelectedColor: UIColor = UIColor.gray
    var iconSelectedColor: UIColor?
	
	// MARK: - RAMItemAnimationProtocol methods

    func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
    }
    
    func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor) {
    }
    
    func selectedState(_ icon: UIImageView, textLabel: UILabel) {
    }
	
}

class RAMBounceAnimation: RAMItemAnimation {
	
	// MARK: - Override RAMItemAnimationProtocol methods
	
    override func playAnimation(_ icon: UIImageView, textLabel: UILabel)
	{
        playBounceAnimation(icon)
        textLabel.textColor = textSelectedColor
    }
    
    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor)
	{
        textLabel.textColor = defaultTextColor
        
        if let iconImage = icon.image {
            icon.image = iconImage.withRenderingMode(.alwaysOriginal)
            icon.tintColor = defaultTextColor
        }
    }
    
    override func selectedState(_ icon: UIImageView, textLabel: UILabel)
	{
        textLabel.textColor = textSelectedColor
        
        if let iconImage = icon.image {
            icon.image = iconImage.withRenderingMode(.alwaysOriginal)
            icon.tintColor = textSelectedColor
        }
    }
    
    // HZ: Here just one of an animation, like Bounce
    func playBounceAnimation(_ icon: UIImageView)
	{
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
		
		// During the animation, Core Animation generates intermediate values by interpolating between the values you provide.
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
		//bounceAnimation.values = [1.0, 2.0, 3.0, 2.0, 1.0]	// just for test HZ
		
		bounceAnimation.duration = TimeInterval(duration)
		
		// Specifies how intermediate keyframe values are calculated by the receiver.
        bounceAnimation.calculationMode = kCAAnimationCubic
        
        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
        
        if let iconImage = icon.image {
            icon.image = iconImage.withRenderingMode(.alwaysOriginal)
            icon.tintColor = iconSelectedColor
        }
    }
	
}

// Customized tabBar item, which can be animated
class RAMAnimatedTabBarItem: UITabBarItem {
    
    var animation: RAMItemAnimation?	// Animate the tab bar item
    var textColor = UIColor.gray
    
    func playAnimation(_ icon: UIImageView, textLabel: UILabel)
	{
        guard let animation = animation else {
            print("add animation in UITabBarItem")
            return
        }
		
        animation.playAnimation(icon, textLabel: textLabel)
    }
    
    func deselectAnimation(_ icon: UIImageView, textLabel: UILabel) {
        animation?.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: textColor)
    }
    
    func selectedState(_ icon:UIImageView, textLabel:UILabel) {
        animation?.selectedState(icon , textLabel: textLabel)
    }
	
}

// Add animation to the normal tabBar
class AnimationTabBarController: UITabBarController {
    
    var iconsView: [ (icon: UIImageView, textLabel: UILabel) ] = []
    var iconsImageName: [String] = ["v2_home", "v2_order", "shopCart", "v2_my"]
    var iconsSelectedImageName: [String] = ["v2_home_r", "v2_order_r", "shopCart_r", "v2_my_r"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		setSelectIndex(from: selectedIndex, to: item.tag)
	}
	
	// MARK: - Helpers
	
	// Create TabBarItem container view, each item contains titleLabel and UIImageView
    func createViewContainers() -> [String: UIView]
	{
        var containersDict = [String: UIView]()
		
		// animatable tab bar items
        guard let customItems = tabBar.items as? [RAMAnimatedTabBarItem]
		else { return containersDict }
		
        for index in 0..<customItems.count {
            containersDict["container\(index)"] = createViewContainer(index)
        }
		
        return containersDict
    }
	
    func createViewContainer(_ index: Int) -> UIView
	{
        let viewWidth: CGFloat = ScreenWidth / CGFloat(tabBar.items!.count)
        let viewHeight: CGFloat = tabBar.height
        let viewContainer = UIView(frame: CGRect(x: viewWidth * CGFloat(index), y: 0, width: viewWidth, height: viewHeight))
        
        viewContainer.backgroundColor = UIColor.clear
        viewContainer.isUserInteractionEnabled = true
        
        tabBar.addSubview(viewContainer)
        viewContainer.tag = index
		
        let tap = UITapGestureRecognizer(target: self, action: Selector(("tabBarClick:")))
        viewContainer.addGestureRecognizer(tap)
		
        return viewContainer
    }
	
	// Here is key point
    func createCustomIcons(_ containers: [String: UIView])
	{
		// Here tarBar items are RAMAnimatedTabBarItem s
        if let items = tabBar.items
		{
            for (index, item) in items.enumerated()
			{
                assert(item.image != nil, "add image icon in UITabBarItem")
				
                guard let container = containers["container\(index)"] else {
                    print("No container given")
                    continue
                }
                container.tag = index
				let itemsCount = CGFloat(items.count)	// Added by HZ
                
				let imageW:CGFloat = 21; let imageH:CGFloat = 21
				let imageX:CGFloat = (ScreenWidth/itemsCount - imageW) * 0.5; let imageY:CGFloat = 8
				
                let icon = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageW, height: imageH))
                icon.image = item.image
                icon.tintColor = UIColor.clear
                
                let textLabel = UILabel()
                textLabel.frame = CGRect(x: 0, y: 32, width: ScreenWidth/itemsCount, height: 49 - 32)
                textLabel.text = item.title
                textLabel.backgroundColor = UIColor.clear
                textLabel.font = UIFont.systemFont(ofSize: 10)
                textLabel.textAlignment = NSTextAlignment.center
                textLabel.textColor = UIColor.gray
                textLabel.translatesAutoresizingMaskIntoConstraints = false
				textLabel.bounds.size.width = tabBar.frame.size.width/itemsCount	// Added by HZ
				
                container.addSubview(icon)
                container.addSubview(textLabel)
				
                let iconsAndLabels = (icon: icon, textLabel: textLabel)
                iconsView.append(iconsAndLabels)
                
                item.image = nil
                item.title = ""
                
                if index == 0 {
                    selectedIndex = 0
                    selectItem(0)
                }
            }//for-items
        }
    }
	
    // animate the selected item
    func selectItem(_ index: Int) {
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        let selectIcon = iconsView[index].icon
        selectIcon.image = UIImage(named: iconsSelectedImageName[index])!
        items[index].selectedState(selectIcon, textLabel: iconsView[index].textLabel)
    }
    
	// switch bar button items
    func setSelectIndex(from: Int, to: Int)
	{
        selectedIndex = to
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
		
		// Deselect from bar button item
        let fromIV = iconsView[from].icon
        fromIV.image = UIImage(named: iconsImageName[from])
        items[from].deselectAnimation(fromIV, textLabel: iconsView[from].textLabel)
		
		// Select to bar button item
        let toIV = iconsView[to].icon
        toIV.image = UIImage(named: iconsSelectedImageName[to])
        items[to].playAnimation(toIV, textLabel: iconsView[to].textLabel)
    }

}//EndClass
