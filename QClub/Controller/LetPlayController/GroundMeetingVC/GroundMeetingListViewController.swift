//
//  GroundMeetingListViewController.swift
//  QClub
//
//  Created by TuanNM on 10/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

/*
 GroundMetting - Page 68 in StoryBoard
 */

class GroundMeetingListViewController: UIViewController {

    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var tbView: UITableView!
    
    var viewModel = GroundMeetingListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.config(title: "흥미진진 3:3미팅", image: "ic_ground_metting_white.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        tbView.rowHeight = UITableViewAutomaticDimension
        tbView.estimatedRowHeight = 150
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension GroundMeetingListViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRooms() + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return tbView.dequeueReusableCell(withIdentifier: "headerCell")!
        case  viewModel.numberOfRooms() + 1:
            return tbView.dequeueReusableCell(withIdentifier: "logoCell")!
        default:
            let cell = tbView.dequeueReusableCell(withIdentifier: "GroundListItemCell") as! GroundListItemCell
            cell.setupData(room: viewModel.rooms[indexPath.row - 1], index: indexPath.row)
            cell.enterAction = {
                [weak self] index in
                guard let _self = self else {return}
                
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "GroundMeetingDetailViewController") as! GroundMeetingDetailViewController
                vc.viewModel.meetingSeq = _self.viewModel.rooms[index - 1].meetingSeq ?? 0
                _self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }
    }
    
}
