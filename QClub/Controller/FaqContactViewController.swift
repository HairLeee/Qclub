//
//  FaqContactViewController.swift
//  QClub
//
//  Created by Dreamup on 10/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//
//Page 144 and 145 in the Storyboard
import UIKit
import PagingMenuController


private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    

    private let viewController1 = (UIStoryboard.init(name: "Fqa", bundle: nil).instantiateViewController(withIdentifier: "FqaViewController")) as! FqaViewController
    private let viewController2 = (UIStoryboard.init(name: "Fqa", bundle: nil).instantiateViewController(withIdentifier: "ContactViewController")) as! ContactViewController
    
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
            return .text(title: MenuItemText(text: "FAQ"))
        }
    }
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "문의/제안하기"))
        }
    }
}

class FaqContactViewController: BaseViewController {
    var isGoToContactViewController = false
    @IBOutlet weak var navigationView: NavigationBarQClub!
    override func viewDidLoad() {
        super.viewDidLoad()
        createPage()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func createPage() {
        
        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.view.frame.origin.y += 74
        pagingMenuController.view.frame.size.height -= 74
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
        
        if self.isGoToContactViewController {
            pagingMenuController.move(toPage: 1)
        }
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
    }
    
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "FAQ 문의/제안", image: "faq_contact_header_icon")
    }
    
}
