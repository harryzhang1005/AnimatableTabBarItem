//
//  GuideViewController.swift
//  AnimationTabBarItemsDemo
//
//  Created by Harvey Zhang on 16/3/5.
//  Copyright © 2016 HappyGuy. All rights reserved.
//

import UIKit

// Page Control and Collection view
class GuideViewController: BaseViewController {
	
    fileprivate var imageNames = ["guide_40_1", "guide_40_2", "guide_40_3", "guide_40_4"]
    fileprivate let cellIdentifier = "GuideCell"
    //fileprivate var isHiddenNextButton = true	// Del by HZ
	
	fileprivate var collectionView: UICollectionView?
    fileprivate var pageController = UIPageControl(frame: CGRect(x: 0, y: ScreenHeight - 50, width: ScreenWidth, height: 20))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
        UIApplication.shared.setStatusBarHidden(false, with: .none)
        createCollectionView()
        createPageControll()
    }
	
    // MARK: - CollectionView and PageControl
	
    func createCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = ScreenBounds.size		// Full screen size
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: ScreenBounds, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
		
		/* 
		A Boolean value that determines whether paging is enabled for the scroll view.
		If the value of this property is true, the scroll view stops on multiples of the scroll view’s bounds when the user scrolls. The default value is false.
		*/
        collectionView?.isPagingEnabled = true
		
		/*
		A Boolean value that controls whether the scroll view bounces past the edge of content and back again.
		If the value of this property is true, the scroll view bounces when it encounters a boundary of the content. Bouncing visually indicates that scrolling has reached an edge of the content. If the value is false, scrolling stops immediately at the content boundary without bouncing. The default value is true.
		*/
        collectionView?.bounces = false
		
        collectionView?.register(GuideCollectionViewCell.self , forCellWithReuseIdentifier: cellIdentifier)
        view.addSubview(collectionView!)
    }
    
    fileprivate func createPageControll() {
        pageController.numberOfPages = imageNames.count
        pageController.currentPage = 0
        view.addSubview(pageController)
    }

}

// MARK: - CollectionView DataSource and Delegate

extension GuideViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! GuideCollectionViewCell
        cell.newImage = UIImage(named: imageNames[(indexPath as NSIndexPath).row])
		
        if (indexPath as NSIndexPath).row != imageNames.count - 1 { // Only the last page show `Next Page` button
            cell.setNextBtnHidden(true)
        }
		else { // Add by HZ
			cell.setNextBtnHidden(false)
		}
		
        return cell
    }
	
	/// HZ: Dynamic control show or hide the `Next Page` button
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /* Del by HZ
        if scrollView.contentOffset.x == ScreenWidth * CGFloat(imageNames.count - 1) {
            let cell = collectionView?.cellForItem(at: IndexPath(row: imageNames.count - 1, section: 0)) as! GuideCollectionViewCell
            cell.setNextBtnHidden(false)
            isHiddenNextButton = false
        }
		*/
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /* Del by HZ
        if scrollView.contentOffset.x != ScreenWidth * CGFloat(imageNames.count - 1) &&
			!isHiddenNextButton && scrollView.contentOffset.x > ScreenWidth * CGFloat(imageNames.count - 2)
		{
            let cell = collectionView?.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
											for: IndexPath(row: imageNames.count - 1, section: 0)) as! GuideCollectionViewCell
            cell.setNextBtnHidden(true)
            isHiddenNextButton = true
        }
		*/
		
        pageController.currentPage = Int(scrollView.contentOffset.x / ScreenWidth + 0.5)
    }
	
}
