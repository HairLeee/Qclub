//
//  GroundChampionStartViewController.swift
//  QClub
//
//  Created by TuanNM on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundChampionStartViewController: BaseViewController {

    @IBOutlet weak var navigationBar: NavigationBarQClub!
    
    @IBOutlet weak var roundName: UILabel!
    @IBOutlet weak var player1: PlayerChampion!
    @IBOutlet weak var player2: PlayerChampion!
    @IBOutlet weak var timeLb: UILabel!
    
    @IBOutlet weak var step1: CircleView!
    @IBOutlet weak var step2: CircleView!
    @IBOutlet weak var step3: CircleView!
    @IBOutlet weak var step4: CircleView!
    
    @IBOutlet weak var victoryView: UIView!
    @IBOutlet weak var playerFinalName: UILabel!
    @IBOutlet weak var playerFinal: PlayerChampion!
    
    var theWinner:BattleUser?
    var the2ndUser:BattleUser?
    
    var battle:Battle!
    
    var timer:Timer?
    var countTime = 20
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.config(title: "이상형 챔피언배틀", image: "ic_cup.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        player1.isHidden = true
        player2.isHidden = true
        
        updateRoundState(round: battle.currentRound, battle: battle.currentBattle)
        
        GChampionService.getBattleNext(battleSeq: battle.battleSeq, winUserSeq: 0, loseUserSeq: 0, completion: {
            [weak self](response) in
            guard let _self = self else{return}
            guard let mBattle = response.data as? Battle else{
                _self.navigationController?.popViewController(animated:false)
                return
            }
            _self.battle = mBattle
            _self.nextRound()
            
        }) { (error) in
            print("getBattleNext error \(error)")
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func updateRoundState(round:Int,battle:Int)  {
        roundName.text = "\(round) 강 \(battle)차전"
        switch round {
        case 16:
            step1.setData(round: 16, isCurrent: true)
            step2.setData(round: 8, isCurrent: false)
            step3.setData(round: 4, isCurrent: false)
            step4.setData(round: 1, isCurrent: false)
            break
        case 8:
            step1.setData(round: 16, isCurrent: false)
            step2.setData(round: 8, isCurrent: true)
            step3.setData(round: 4, isCurrent: false)
            step4.setData(round: 1, isCurrent: false)
            break
        case 4:
            step1.setData(round: 16, isCurrent: false)
            step2.setData(round: 8, isCurrent: false)
            step3.setData(round: 4, isCurrent: true)
            step4.setData(round: 1, isCurrent: false)
            break
        case 2:
            step1.setData(round: 16, isCurrent: false)
            step2.setData(round: 8, isCurrent: false)
            step3.setData(round: 4, isCurrent: false)
            step4.setData(round: 1, isCurrent: true)
            break
        case 1:
            step1.setData(round: 16, isCurrent: false)
            step2.setData(round: 8, isCurrent: false)
            step3.setData(round: 4, isCurrent: false)
            step4.setData(round: 1, isCurrent: true)
            break
        default:
            break
        }
    }
    
    func nextRound(){
        
        guard let user1 = battle.user1 else{return}
        guard let user2 = battle.user2 else{return}
        
        player1.isHidden = false
        player2.isHidden = false
        
        updateRoundState(round: battle.currentRound, battle: battle.currentBattle)
        player1.setData(user: user1)
        player1.layer.borderColor = UIColor.lightGray.cgColor
        player1.handleTapOnView = {
            [weak self] in
            guard let _self = self else{return}
            _self.finishRound(loserPlayer: _self.player2, loserId: user2.userSeq)
        }
        
        player2.setData(user: user2)
        player2.layer.borderColor = UIColor.lightGray.cgColor
        player2.handleTapOnView = {
            [weak self] in
            guard let _self = self else{return}
            _self.finishRound(loserPlayer: _self.player1, loserId: user1.userSeq)
        }
        championStart()
    }
    
    func championStart(){
        countTime = 20
        timeLb.text = "20"
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(self.updateTime),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func finishRound(loserPlayer:PlayerChampion,loserId:Int){
        
        loserPlayer.setLoser()
        
        theWinner = battle.user1!.userSeq == loserId ? battle.user2! : battle.user1!
        the2ndUser = battle.user1!.userSeq == loserId ? battle.user1! : battle.user2!
        
        GChampionService.getBattleNext(battleSeq: battle.battleSeq, winUserSeq: theWinner!.userSeq, loseUserSeq: loserId, completion: {
            [weak self](response) in
            guard let _self = self else{return}
            guard let mBattle = response.data as? Battle else{
                _self.championFinish(winer: _self.theWinner!)
                _self.updateRoundState(round: 1, battle: 0)
                return
            }
            _self.battle = mBattle
            print("round : \(mBattle.currentRound) - battle :\(mBattle.currentBattle)")
            _self.nextRound()
            
        }) { (error) in
            print("getBattleNext error \(error)")
        }
        
        timer?.invalidate()
        timer = nil
    }
    
    func championFinish(winer:BattleUser){
        victoryView.isHidden = false
        playerFinal.setData(user: winer)
        playerFinal.setWinner()
        playerFinalName.text = winer.nickName
        playerFinal.handleTapOnView = {
            [weak self] in
            guard let _self = self else{return}
            _self.showProfileUser(rank: 1)
        }
    }
    
    func showProfileUser(rank:Int) {
        var user : BattleUser?
        if rank == 1 {
            user = theWinner
        } else {
            user = the2ndUser
        }
        if (user?.hasPaid)! {
            Utils.gotoUserVC(viewController: self, userSeq: user?.userSeq ?? 0)
        } else {
            Utils.checkHeartIsEnough(viewController: self, numberOfHeartIsNeed: 5, completion: {
                [weak self](result, numberHeart) in
                guard let _self = self else{return}
                _self.showPaymentPopUp(rank: rank,myHeart:numberHeart )
                
            }) { (error) in
                print("checkHeartIsEnough error \(error)")
            }
        }
        

    }
    
    @objc func updateTime(){
        if countTime == 1{
            timer?.invalidate()
            timer = nil
            guard let user1 = battle.user1 else{return}
            guard let user2 = battle.user2 else{return}
            
            let random = Int(arc4random_uniform(3)) % 2
            theWinner = random == 0 ? user1 : user2
            the2ndUser = random == 0 ? user2 : user1
            
            if theWinner?.userSeq == user1.userSeq {
                player1.setWinner()
                player2.setLoser()
            } else {
                player1.setLoser()
                player2.setWinner()
            }
            
            GChampionService.getBattleNext(battleSeq: battle.battleSeq, winUserSeq: theWinner!.userSeq, loseUserSeq: the2ndUser!.userSeq, completion: {
                [weak self](response) in
                guard let _self = self else{return}
                guard let mBattle = response.data as? Battle else{
                     _self.championFinish(winer: _self.theWinner!)
                    _self.updateRoundState(round: 1, battle: 0)
                    return
                }
                _self.battle = mBattle
                _self.nextRound()
                
            }) { (error) in
                print("getBattleNext error \(error)")
            }
        }
        countTime -= 1
        timeLb.text = "\(countTime)"
    }
    
    
    
    @IBAction func show2ndPlayerProfileAction(_ sender: Any) {
         self.showProfileUser(rank: 2)
    }
    
    @IBAction func restartChampionAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

// popup
extension GroundChampionStartViewController{
    func showPaymentPopUp(rank:Int,myHeart:Int){
        
        let heartView = HeartView(nibName: "HeartView", bundle: nil)

        switch rank {
        case 1:
            heartView.popupTitle = "이상형 챔피언 선택!"
            heartView.popupMessage = "회원님의 이상형챔프십니다~\n과연 어떤 분일까요?"
            heartView.buttonContent = "이상형 챔프 확인하기"
            heartView.price = "5"
            break
        case 2:
            heartView.popupTitle = "이상형챔피언 2등 인연 선택!"
            heartView.popupMessage = "쉽지 않은 최종 선택이셨을 겁니다~ \n 2등 이상형 회원도 어떤 분인지 확인가능하셔요~"
            heartView.buttonContent = "준우승 챔프 확인하기"
            heartView.price = "2"
            break
        default:
            break
        }

        heartView.myHeart = "\(myHeart)"
        
        self.addChildViewController(heartView)
        self.view.addSubview(heartView.view)

        heartView.callBackSelect = {
            [weak self] in
            guard let _self = self else{return}
            
            GChampionService.getBattlePayInfo(battleSeq: _self.battle.battleSeq, rank: rank, completion: {
                [weak self](response) in
                guard let _self = self else{return}
                let sb = UIStoryboard(name: "RelationCard", bundle: nil)
                let profileVC = sb.instantiateViewController(withIdentifier: "ProfileViewController") as!  ProfileViewController
                profileVC.userSeq = rank == 1 ? _self.theWinner?.userSeq : _self.the2ndUser?.userSeq
                _self.navigationController?.pushViewController(profileVC, animated: true)
                if rank == 1 {
                    _self.theWinner?.hasPaid = true
                } else {
                    _self.the2ndUser?.hasPaid = true
                }
   
            }, fail: { (error) in
                print("getBattlePayInfo error \(error)")
            })
            
        }
    }
}
