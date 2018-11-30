//
//  UIViewController.swift
//  QClub
//
//  Created by SMR on 10/5/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

private var loadingViewAssociationKey: UInt8 = 0

extension UIViewController {
    
    private struct AssociatedKeys {
        static var loadingView:UIView?
    }
    
    var loadingView: UIView! {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.loadingView) as? UIView
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.loadingView, newValue as UIView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    func showLoading() {
        if self.loadingView == nil {
            self.loadingView = UIView(frame: (self.view.bounds))
        }
        
        self.view.addSubview(self.loadingView)
        let hud = MBProgressHUD.showAdded(to: self.loadingView, animated: true)
        hud.bezelView.backgroundColor = UIColor.black
        hud.bezelView.alpha = 0.8
        hud.contentColor = UIColor.white
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.loadingView?.removeFromSuperview()
            
            if let loadingView = self.loadingView {
                MBProgressHUD.hide(for: loadingView, animated: true)
            }
        }
    }
    
    func showLoadingInScreenCenter(){
        if let window = UIApplication.shared.delegate?.window{
            if self.loadingView == nil {
                self.loadingView = UIView(frame: (window?.bounds) ?? CGRect.zero)
            }
            
            window?.addSubview(self.loadingView)
            let hud = MBProgressHUD.showAdded(to: self.loadingView, animated: true)
            hud.bezelView.backgroundColor = UIColor.black
            hud.bezelView.alpha = 0.8
            hud.contentColor = UIColor.white
        }
    }
    
    func pushToStoreViewController() {
        weak var weakSelf = self
        Utils.gotoStore(viewController: weakSelf!)
    }
}
