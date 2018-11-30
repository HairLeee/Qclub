//
//  LetsPlayViewController.swift
//  QClub
//
//  Created by Dream on 9/14/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

/*
 Ground, Page 65 in StoryBoard
 */

class LetsPlayViewController: BaseViewController {
    
    @IBOutlet weak var tbView: UITableView!
    let arrTitle:[String] = ["흥미진진 3 : 3 미팅",
                             "Q클럽과의 인연",
                             "나를 소개합니다",
                             "테마 인연 찾기",
                             "원하는지역인연",
                             "이상형 챔피언배틀",
                             "요긴 꼭 가봐야해 (나의맛집)",
                             "요건 꼭 가져야해! My잇아이템"]
    
    let arrImage:[String] = ["ic_ground_meeting.png",
                             "ic_member.png",
                             "ic_ground_introduce.png",
                             "ic_ground_theme.png",
                             "ic_ground_local.png",
                             "ic_ground_champion.png",
                             "ic_ground_foodshop.png",
                             "ic_ground_myitem.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension LetsPlayViewController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "cell")!
        let imv = cell.viewWithTag(111) as! UIImageView
        let contentLb = cell.viewWithTag(222) as! UILabel
        imv.image = UIImage(named: arrImage[indexPath.row])
        
        contentLb.text = arrTitle[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbView.deselectRow(at: indexPath, animated: true)
        
        let sb = UIStoryboard(name: "LetsPlay", bundle: nil)
        
        switch indexPath.row {
        case 0:
            let groundMeeting = sb.instantiateViewController(withIdentifier: "GroundMeetingViewController") as! GroundMeetingViewController
            self.navigationController?.pushViewController(groundMeeting, animated: true)
            break
        case 1:
            let groundSearching = sb.instantiateViewController(withIdentifier: "GroundSearchingViewController") as! GroundSearchingViewController
            groundSearching.searchType = .GROUND_Q
            self.navigationController?.pushViewController(groundSearching, animated: true)
            break
        case 2:
            let groundSearching = sb.instantiateViewController(withIdentifier: "GroundIntroduceViewController") as! GroundIntroduceViewController
            self.navigationController?.pushViewController(groundSearching, animated: true)
            break
        case 3:
            let groundSearching = sb.instantiateViewController(withIdentifier: "GroundThemeViewController") as! GroundThemeViewController
            self.navigationController?.pushViewController(groundSearching, animated: true)
            break
        case 4:
            let groundSearching = sb.instantiateViewController(withIdentifier: "GroundSearchingViewController") as! GroundSearchingViewController
            groundSearching.searchType = .GROUND_LOCAL
            self.navigationController?.pushViewController(groundSearching, animated: true)
            break
        case 5:
            let groundChampion = sb.instantiateViewController(withIdentifier: "GroundChampionViewController") as! GroundChampionViewController
            self.navigationController?.pushViewController(groundChampion, animated: true)
            break
        case 6:
            let groundFood = sb.instantiateViewController(withIdentifier: "GroundFoodShopViewController") as! GroundFoodShopViewController
            self.navigationController?.pushViewController(groundFood, animated: true)
            break
        case 7:
            let groundItem = sb.instantiateViewController(withIdentifier: "GroundMyItemViewController") as! GroundMyItemViewController
            self.navigationController?.pushViewController(groundItem, animated: true)
            break
        default:
            break
        }
        
        
    }
    
}

