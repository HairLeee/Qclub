//
//  GroundMeetingViewController.swift
//  QClub
//
//  Created by TuanNM on 10/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

/*
 Ground_meeting, Page 67 in StoryBoard
 */
class GroundMeetingViewController: BaseViewController {

    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var tbView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.backAction = {          
            self.navigationController?.popViewController(animated: true)
        }
        navigationBar.config(title: "흥미진진 3:3미팅", image: "ic_ground_metting_white.png")
        
        tbView.rowHeight = UITableViewAutomaticDimension
        tbView.estimatedRowHeight = 500
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func acceptTUI(_ sender: Any) {
        getData()
    }
    

    
    
    func getData() {
        // check user register after 12pm today
        let loginDate = Context.getUserLogin()?.createDate?.toLoginDate()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        let hourIn12 = format.date(from: "\(Calendar.current.component(.year, from: Date()))-\(Calendar.current.component(.month, from: Date()))-\(Calendar.current.component(.day, from: Date())) 12:00")
        
        if loginDate?.compare(hourIn12!) == .orderedDescending {
            self.view.makeToast("준비중 입니다. 다음날 정오에 다시 와주세요", duration: 2.0, position: .center)
            return
        }
        
        self.showLoading()
        MeetingService.getRoom(completion: { (response) in
            if let datas = response.data as? [MeetingRoomObject] {
                if datas.count > 0 {
                    if datas.count > 1 {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GroundMeetingListViewController") as! GroundMeetingListViewController
                        vc.viewModel.rooms = datas
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GroundMeetingDetailViewController") as! GroundMeetingDetailViewController
                        vc.viewModel.meetingSeq = datas[0].meetingSeq ?? 0
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    
                }
            }
            self.stopLoading()
        }) { (error) in
        }
    }
}

extension GroundMeetingViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "GroundMettingCell") as! GroundMettingCell
        cell.setData()
        cell.enterAction = {
            
        }
        return cell
    }
}
