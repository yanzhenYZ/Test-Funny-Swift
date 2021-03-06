//
//  ExtentTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 16/4/6.
//  Copyright © 2016年 YZ. All rights reserved.
//

import UIKit

class ExtentTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tabBar.tintColor = FunnyColor;
    }
    
    func ncvWithVC(_ vc: UIViewController, title: String, imageName: String) ->ExtentNavigationViewController {
        let nvc = ExtentNavigationViewController(rootViewController: vc);
        vc.title = title;
        let selectedImageName = imageName + "_s";
        let unSelectedImageName = imageName + "_u";
        let unSelectedImage = UIImage(named: unSelectedImageName)?.withRenderingMode(.alwaysOriginal);
        let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal);
        nvc.tabBarItem.image = unSelectedImage;
        nvc.tabBarItem.selectedImage = selectedImage;
        return nvc;
    }

}
