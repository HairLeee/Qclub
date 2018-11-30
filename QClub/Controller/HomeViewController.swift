//
//  HomeViewController.swift
//  QClub
//
//  Created by Dream on 9/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var relationCardBtn: UIButton!
    @IBOutlet weak var myOwnCandyBtn: UIButton!
    @IBOutlet weak var letPlayBtn: UIButton!
    @IBOutlet weak var qClubBtn: UIButton!
    @IBOutlet weak var ourStoryBtn: UIButton!
    
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var letsPlayContainerView: UIView!
    @IBOutlet weak var qClubContainerView: UIView!
    @IBOutlet weak var ourStoryContainer: UIView!
    @IBOutlet weak var myOwnCandyContainer: UIView!
    @IBOutlet weak var relationCardContainer: UIView!
    
    
    var relationCardViewController:RelationCardController!
    var myOwnCandyController:MyOwnCandyController!
    var letsPlayViewController:LetsPlayViewController!
    var qClubController:QclubMainViewController!
    var ourStoryController:OurStoryController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.relationCardBtn.setTitleColor(UIColor(hexString: ORANGE_COLOR), for: .normal)
        self.myOwnCandyBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.letPlayBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.qClubBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.ourStoryBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        
        relationCardContainer.isHidden = false
        myOwnCandyContainer.isHidden = true
        letsPlayContainerView.isHidden = true
        qClubContainerView.isHidden = true
        ourStoryContainer.isHidden = false
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateNewMessageStatus), name:  Notification.Name("onMessageReceived"), object: nil)
        
        MessageService.getAllLetter(completion: { (response) in
            
        }) { (error) in
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNewMessageStatus()
    }
    
    @objc func updateNewMessageStatus(){
        
        MessageService.getNewMessageStatus(completion: { (newMessage,newNotification) in
            if newMessage{
                self.emailBtn.setImage(UIImage(named: "ic_new_email.png"), for: .normal)
            }else{
                self.emailBtn.setImage(UIImage(named: "ic_email.png"), for: .normal)
            }
            
            if newNotification{
                self.menuBtn.setImage(UIImage(named: "ic_new_menu.png"), for: .normal)
            }else{
                self.menuBtn.setImage(UIImage(named: "ic_menu.png"), for: .normal)
            }
            
        }) { (error) in
            print("getNewMessageStatus error \(error)")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Tabbar Action
    @IBAction func relationCardAction(_ sender: Any) {
        self.relationCardBtn.setTitleColor(UIColor(hexString: ORANGE_COLOR), for: .normal)
        self.myOwnCandyBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.letPlayBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.qClubBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.ourStoryBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        
        relationCardContainer.isHidden = false
        myOwnCandyContainer.isHidden = true
        letsPlayContainerView.isHidden = true
        qClubContainerView.isHidden = true
        ourStoryContainer.isHidden = true
        
        relationCardViewController.todayRelationAction(0)
        
    }
    @IBAction func myOwnCandyAction(_ sender: Any) {
        self.relationCardBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.myOwnCandyBtn.setTitleColor(UIColor(hexString: ORANGE_COLOR), for: .normal)
        self.letPlayBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.qClubBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.ourStoryBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        
        relationCardContainer.isHidden = true
        myOwnCandyContainer.isHidden = false
        letsPlayContainerView.isHidden = true
        qClubContainerView.isHidden = true
        ourStoryContainer.isHidden = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.Notifications.CandySelect), object: self)
    }
    
    @IBAction func letPlayAction(_ sender: Any) {
        self.relationCardBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.myOwnCandyBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.letPlayBtn.setTitleColor(UIColor(hexString: ORANGE_COLOR), for: .normal)
        self.qClubBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.ourStoryBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        
        relationCardContainer.isHidden = true
        myOwnCandyContainer.isHidden = true
        letsPlayContainerView.isHidden = false
        qClubContainerView.isHidden = true
        ourStoryContainer.isHidden = true
    }
    
    @IBAction func qClubAction(_ sender: Any) {
        self.relationCardBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.myOwnCandyBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.letPlayBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.qClubBtn.setTitleColor(UIColor(hexString: ORANGE_COLOR), for: .normal)
        self.ourStoryBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        
        relationCardContainer.isHidden = true
        myOwnCandyContainer.isHidden = true
        letsPlayContainerView.isHidden = true
        qClubContainerView.isHidden = false
        ourStoryContainer.isHidden = true
    }
    @IBAction func ourStoryAction(_ sender: Any) {
        self.relationCardBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.myOwnCandyBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.letPlayBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.qClubBtn.setTitleColor(UIColor(hexString: GRAY_COLOR), for: .normal)
        self.ourStoryBtn.setTitleColor(UIColor(hexString: ORANGE_COLOR), for: .normal)
        
        relationCardContainer.isHidden = true
        myOwnCandyContainer.isHidden = true
        letsPlayContainerView.isHidden = true
        qClubContainerView.isHidden = true
        ourStoryContainer.isHidden = false
    }
    
    // MARK: Header Action
    @IBAction func emailAction(_ sender: Any) {
        let letterVC = self.storyboard?.instantiateViewController(withIdentifier: "LetterViewController")
        self.navigationController?.pushViewController(letterVC!, animated: true)
    }
    
    @IBAction func menuAction(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "RelationCard":
            relationCardViewController = segue.destination as! RelationCardController
            break
        case "MyOwnCandy":
            myOwnCandyController = segue.destination as! MyOwnCandyController
            break
        case "LetsPlay":
            letsPlayViewController = segue.destination as! LetsPlayViewController
            break
        case "QClub":
            qClubController = segue.destination as! QclubMainViewController
            break
        case "OurStory":
            ourStoryController = segue.destination as! OurStoryController
            break
        default:
            break
        }
        
    }
    
    
}

extension HomeViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        updateNewMessageStatus()
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
