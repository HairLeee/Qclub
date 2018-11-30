//
//  QclubMainViewController.swift
//  QClub
//
//  Created by Dreamup on 11/8/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import PagingMenuController


private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    
    public let viewController1 = AboutQclubViewController.init(nibName: "AboutQclubViewController", bundle: nil)
  
   
    private let viewController2 = (UIStoryboard.init(name: "QClub", bundle: nil).instantiateViewController(withIdentifier: "QClubController")) as! QClubController
    
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    fileprivate var pagingControllers: [UIViewController] {
        return [viewController1, viewController2]
    }
    
    fileprivate struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2()]
        }
        var backgroundColor: UIColor {
            return UIColor.init(hexString: "#EBEBEB")!
        }
        var selectedBackgroundColor: UIColor {
            return UIColor.init(hexString: "#FFAA4F")!
        }
        var focusMode: MenuFocusMode {
            return .none
        }
        
    }
    
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "Why Q클럽?"))
        }
    }
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "Q클럽 승급 신청"))
        }
    }
}




class QclubMainViewController: UIViewController {
     var pagingMenuController:PagingMenuController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPage()
    }
    
    func createPage() {
        
        let options = PagingMenuOptions()
         pagingMenuController = PagingMenuController(options: options)
        options.viewController1.mChangeTabDelegate = self
        pagingMenuController.view.frame.origin.y += 0
        pagingMenuController.view.frame.size.height -= 0
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .didMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .willMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case let .didMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case .didScrollStart:
                print("Scroll start")
            case .didScrollEnd:
                print("Scroll end")
            }
        }
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
        
    }
}


extension QclubMainViewController:changeTabDelegate {
    
    func changeTab() {
        
        print("Come here")
        
//        pagingMenuController.didMove(toParentViewController:  options.viewController)
    }
    
    
}
