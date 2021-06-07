//
//  TabBarController.swift
//  Skill Connect
//
//  Created by Dhruvit on 01/07/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        for item in self.tabBar.items!  {
            
            if item.image != nil {
                item.image = item.image?.withRenderingMode(.alwaysTemplate)
            }
            
            if item.selectedImage != nil {
                item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysTemplate)
            }
        }
        
        self.tabBar.tintColor = Theme.colors.themeColor
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        setShadowTabbar()
        addCornerRadius()
        
        self.tabBar.barTintColor = UIColor(named: "Primary_Color")
        self.tabBar.backgroundColor = .white
        UITabBar.appearance().barTintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.selectedIndex = 0
    }
    
}

extension TabBarController {
    
    // MARK:- FUNCTIONS
    func setShadowTabbar()  {
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 8
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.layer.shadowOpacity = 0.8
        tabBar.layer.masksToBounds = false
    }
    
    func addCornerRadius() {
//        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.barStyle = UIBarStyle.black
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if self.viewControllers!.count > 4 {
//            if self.viewControllers![2] == viewController {
//                return false
//            }
//            if self.viewControllers![4] == viewController {
//                return false
//            }
//        }
        return true
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if self.tabBar.items!.count > 4 {
//            if tabBar.items![2] == item {
//                let aVC = AppStoryBoard.addPost.viewController(viewControllerClass: NavigationClass.self)
//                aVC.modalPresentationStyle = .overFullScreen
//                present(aVC, animated: true)
//            }
//            if tabBar.items![4] == item {
//                sideMenuController?.showRightViewAnimated(self)
//            }
        }
    }
}
