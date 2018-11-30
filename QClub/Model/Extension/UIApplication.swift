//
//  UIApplication.swift
//  QClub
//
//  Created by Dream on 9/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit


extension UIApplication {
    
    func showHomeViewController(window:UIWindow?){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
//        let navigationHome = storyboard.instantiateViewController(withIdentifier: "NavigationHomeViewController") as! UINavigationController
//        navigationHome.interactivePopGestureRecognizer?.delegate = nil
//        navigationHome.navigationBar.isHidden = true
//
//        let menuNavi = storyboard.instantiateViewController(withIdentifier: "MenuNavi") as! UINavigationController
//        menuNavi.interactivePopGestureRecognizer?.delegate = nil
//        menuNavi.navigationBar.isHidden = true
        
        
        
        let homeNavi = storyboard.instantiateViewController(withIdentifier: "NavigationHomeViewController") as! UINavigationController
        let homeViewController = homeNavi.viewControllers.first as! HomeViewController
        
        let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        
        let mainViewController = MainViewController(mainViewController: homeNavi, leftMenuViewController: menuViewController)
        //let mainViewController = MainViewController(mainViewController: homeViewController, leftMenuViewController: menuViewController)
        
        let mainNavi = UINavigationController.init(rootViewController: mainViewController)
        mainNavi.setNavigationBarHidden(true, animated: false)
        
        mainViewController.automaticallyAdjustsScrollViewInsets = true
        mainViewController.delegate = homeViewController
        
        menuViewController.homeViewController = homeViewController
        
        window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        window?.rootViewController = mainNavi
        window?.makeKeyAndVisible()
        
    }
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        if let slide = viewController as? SlideMenuController {
            return topViewController(slide.mainViewController)
        }
        return viewController
    }
}
