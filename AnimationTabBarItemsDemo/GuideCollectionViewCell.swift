//
//  GuideCollectionViewCell.swift
//  AnimationTabBarItemsDemo
//
//  Created by Harvey Zhang on 16/3/5.
//  Copyright © 2016 HappyGuy. All rights reserved.
//

import UIKit

class GuideCollectionViewCell: UICollectionViewCell {
	
    fileprivate let newImageView = UIImageView(frame: ScreenBounds)
    fileprivate let nextBtn = UIButton(frame: CGRect(x: (ScreenWidth - 100)*0.5, y: ScreenHeight - 110, width: 100, height: 33))
    
    var newImage:UIImage? {
        didSet{
            newImageView.image = newImage
        }
    }
	
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        newImageView.contentMode = UIViewContentMode.scaleAspectFill
        contentView.addSubview(newImageView)
        
        nextBtn.setBackgroundImage(UIImage(named: "icon_next"), for: UIControlState())
        nextBtn.addTarget(self, action: #selector(GuideCollectionViewCell.nextBtnClick), for: .touchUpInside)
        nextBtn.isHidden = true
        contentView.addSubview(nextBtn)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNextBtnHidden(_ hidden:Bool) {
        nextBtn.isHidden = hidden
    }
    
    func nextBtnClick() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: kGuideViewControllerDidFinish), object: nil)
    }
    
}
