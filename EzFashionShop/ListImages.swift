//
//  ListImagesViewController.swift
//  EzFashionShop
//
//  Created by iOS Student on 1/9/17.
//  Copyright © 2017 tek4fun. All rights reserved.
//

import UIKit

class ListImages: UIViewController {


    @IBAction func onTouch(_ sender: AnyObject) {
        switch sender.tag {
        case 101:
            pushView(index: 0)
        case 102:
            pushView(index: 1)
        case 103:
            pushView(index: 2)
        default:
            break
        }
    }
    func pushView(index: Int)
    {
        let listView = self.storyboard?.instantiateViewController(withIdentifier: "ViewScroll") as? ViewScroll
        listView?.currentPage = index
        self.navigationController?.pushViewController(listView!, animated: true)
        
    }
    
}
