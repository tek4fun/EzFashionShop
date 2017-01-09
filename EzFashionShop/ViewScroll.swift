//
//  ViewScroll.swift
//  EzFashionShop
//
//  Created by iOS Student on 1/9/17.
//  Copyright © 2017 tek4fun. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var frontScrollView: [UIScrollView] = []
    var pageImages: [String] = []
    var pageViews: [UIImageView?] = []
    var currentImgView = 0
    var first = false
    var currentPage = 0
    
    override func viewDidLoad() {
        //UIScrollViewDelegate
        super.viewDidLoad()
        pageImages = ["shop1-0","shop1-1","shop1-2"]
        pageController.currentPage = currentPage
        pageController.numberOfPages = pageImages.count
    }
    
    override func viewDidLayoutSubviews() {
        if !first {
            first = true
            let pagesScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count), height: 0)
            scrollView.contentOffset = CGPoint(x: CGFloat(currentPage) * scrollView.frame.size.width, y: 0)
            for i in 0 ..< pageImages.count
            {
                let imgView = UIImageView(image: UIImage(named:pageImages[i]+".jpg"))
                imgView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
                imgView.contentMode = .scaleAspectFit
                imgView.isUserInteractionEnabled = true
                imgView.isMultipleTouchEnabled = true
                
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapImg(_:)))
                tap.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(tap)
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTabImg(_:)))
                doubleTap.numberOfTapsRequired = 2
                imgView.addGestureRecognizer(doubleTap)
                tap.require(toFail: doubleTap)
                pageViews.append(imgView)
                
                let photo = UIScrollView(frame: CGRect( x: CGFloat(i) * scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
                photo.minimumZoomScale = 1
                photo.maximumZoomScale = 2
                photo.delegate = self
                photo.addSubview(imgView)
                frontScrollView.append(photo)
                self.scrollView.addSubview(photo)
            }
        }
    }
    
    func tapImg(_ gesture: UITapGestureRecognizer)
    {
        let position = gesture.location(in: pageViews[pageController.currentPage])
        zoomRectForScale(scrollView.zoomScale * 1.5, center: position)
    }
    func doubleTabImg(_ gesture: UITapGestureRecognizer)
    {
        let position = gesture.location(in: pageViews[pageController.currentPage])
        zoomRectForScale(scrollView.zoomScale * 0.5, center: position)
    }
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint)
    {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        frontScrollView[pageController.currentPage].zoom(to: zoomRect, animated: true)
    }
    
    @IBAction func onChange(_ sender: AnyObject) {
        scrollView.contentOffset = CGPoint(x: CGFloat(pageController.currentPage) * scrollView.frame.size.width, y: 0)
        frontScrollView[pageController.currentPage].zoomScale = 1
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return pageViews[pageController.currentPage]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((self.scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        if (pageController.currentPage != page)
        {
            //frontScrollView[pageController.currentPage].zoomScale = 1
            pageController.currentPage = page
        }
    }
}
