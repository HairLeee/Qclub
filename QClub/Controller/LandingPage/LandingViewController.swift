//
//  LandingViewController.swift
//  QClub
//
//  Created by SMR on 9/28/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import SendBirdSDK
import AVKit

/*
 Landing, Page 4 in StoryBoard
 */
class LandingViewController: UIViewController {
    
    enum LandingTo {
        case login
        case main
        case unknown
    }

    let videoPlayerController = AVPlayerViewController()
    var player = AVPlayer()
    var currentVideo = 1
    var landingTo = LandingTo.unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playIntro()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func openMain() {
        if Context.getIndexIntro() == 1 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                Utils.mDelegate().openMainView()
            }
        }
    }
    
    func openLogin() {
        if Context.getIndexIntro() == 1 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                Utils.mDelegate().openLoginView()
            }
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification){
        switch self.landingTo {
        case .login:
            Utils.mDelegate().openLoginView()
        case .main:
            Utils.mDelegate().openMainView()
        default:
            break
        }
    }
    
    func playIntro() {
        let indexIntro = Context.getIndexIntro()
        if indexIntro == 5 {
            Context.setIndexIntro(1)
            checkLoginStatus()
        } else {
            Context.setIndexIntro(indexIntro + 1)
            checkLoginStatus()
            videoPlayerController.delegate = self
            videoPlayerController.view.frame = self.view.frame
            videoPlayerController.showsPlaybackControls = false
            
            let path = Bundle.main.path(forResource: "\(indexIntro)", ofType:"mp4")
            player = AVPlayer(url: URL(fileURLWithPath: path!))
            NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
            videoPlayerController.player = player
            self.view.addSubview(videoPlayerController.view)
            player.play()
        }
    }

    func checkLoginStatus() {
        //Check login here
        if let user = Context.getUserLogin() {
            // user was saved
            if let id = user.id, let password = user.password {
                //user has id and password
                AuthService.login(id: id, password: password, completion: { (response) in
                    if response.code == 0 {
                        if user.isWaitingAccept != nil && user.isWaitingAccept == 1 {
                            // user after waiting accept
                            self.landingTo = .login
                            self.openLogin()
                            Context.deleteUserLogin()
                        } else {
                            // user login normally
                            self.landingTo = .main
                            self.openMain()
                            Utils.connectSendbird()
                        }
                    } else if response.code == 780 {
                        // user is in waiting accept
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            let join6VC = UIStoryboard.init(name: "Join", bundle: nil).instantiateViewController(withIdentifier: "Join6ViewController")
                            self.present(join6VC, animated: true, completion: nil)
                        }
                    } else if response.code == 790 {
                        // user was rejected
                        self.landingTo = .login
                        self.openLogin()
                        Context.deleteUserLogin()
                    } else {
                        self.landingTo = .login
                        self.openLogin()
                    }
                }, fail: { (error) in
                    self.landingTo = .login
                    self.openLogin()
                })
            } else {
                self.landingTo = .login
                self.openLogin()
            }
        } else {
            self.landingTo = .login
            self.openLogin()
        }
    }

}

extension LandingViewController : AVPlayerViewControllerDelegate {
    
}
