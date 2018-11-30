//
//  MainViewController.swift
//  QClub
//
//  Created by Dream on 9/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

// include HomeViewController and MenuViewController
class MainViewController: SlideMenuController {

    override func isTagetViewController() -> Bool {
        if let vc = UIApplication.topViewController() {
            if vc is HomeViewController{
                return true
            }
        }
        return false
    }

    // tracking menu action
    override func track(_ trackAction: TrackAction) {
        switch trackAction {
        case .leftTapOpen:
            print("TrackAction: left tap open.")
        case .leftTapClose:
            print("TrackAction: left tap close.")
        case .leftFlickOpen:
            print("TrackAction: left flick open.")
        case .leftFlickClose:
            print("TrackAction: left flick close.")
        case .rightTapOpen:
            print("TrackAction: right tap open.")
        case .rightTapClose:
            print("TrackAction: right tap close.")
        case .rightFlickOpen:
            print("TrackAction: right flick open.")
        case .rightFlickClose:
            print("TrackAction: right flick close.")
        }
    }
}
