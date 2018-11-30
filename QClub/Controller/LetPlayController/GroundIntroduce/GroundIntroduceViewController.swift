//
//  GroundIntroduceViewController.swift
//  QClub
//
//  Created by TuanNM on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundIntroduceViewController: BaseViewController {

    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var avatarImv: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var myIntroduceBtn: UIButton!
    
    let detailSegue = "DetailSegue"
    let writeSegue = "WriteSegue"
    var offset = 0
    
    var arrayUser:[GIMember] = []
    var owner:GIMember?
    
    var didIntroduceMyself = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.config(title: "나를 소개합니다.", image: "ic_introduce.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        let buttonTitle = didIntroduceMyself ? "본인소개확인":"본인소개하기"
        myIntroduceBtn.setTitle(buttonTitle, for: .normal)

        avatarImv.layer.cornerRadius = avatarImv.frame.width/2
        avatarImv.clipsToBounds = true
        avatarImv.layer.borderWidth = 1
        avatarImv.layer.borderColor = UIColor.lightGray.cgColor

    }
    
    override func viewWillAppear(_ animated: Bool) {
        GIntroduceService.getIntroduceMine(completion: { (response) in
            guard let me = response.data as? GIMember else{return}
            self.setOwner(owner: me)
        }) { (error) in
            MenuService.getMyInfo(completion: { (response) in
                guard let member = response.data as? Member else{return}
                let me = GIMember()
                me.mappingMember(member: member)
                self.setOwner(owner: me)
            }, fail: { (error) in
                print("getMyInfo error \(error)")
            })
            print("getIntroduceMine error \(error)")
        }
        offset = 0
        loadUserList()
    }
    
    
    func setOwner(owner:GIMember)  {
        self.owner = owner
        nameLb.text = owner.nickname
        avatarImv.kf.setImage(with: URL(string: owner.representPicture))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func loadUserList() {
        GIntroduceService.getIntroduceList(offset: offset,completion: {
            [weak self](response) in
            guard let _self = self else{return}
            if let users = response.data as? [GIMember]{
                if _self.offset == 0{
                    _self.arrayUser.removeAll()
                }
                _self.arrayUser.append(contentsOf: users)
                _self.tbView.reloadData()
            }
        }) { (error) in
            print("getIntroduceList error \(error)")
        }
    }
    
    @IBAction func introduceMeAction(_ sender: Any) {
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case is GroundIntroducWritingViewController:
            (segue.destination as! GroundIntroducWritingViewController).member = owner
            break
        case is GroundIntroduceDetailViewController:
            guard let cell = sender as? UITableViewCell else{return}
            guard let indexPath = tbView.indexPath(for: cell) else{return}
            (segue.destination as! GroundIntroduceDetailViewController).member = arrayUser[indexPath.row]
            break
        default:
            break
        }
    }
    
}

extension GroundIntroduceViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUser.count > 0 ? arrayUser.count + 1 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == arrayUser.count{
            return 60
        }
        
        switch UIDevice().screenType {
        case .iPhone4,.iPhones_5_5s_5c_SE:
            return 120
        case .iPhones_6_6s_7_8:
            return 130
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            return 140
        default:
            return 130
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == arrayUser.count{
            let cell = tbView.dequeueReusableCell(withIdentifier: "loadmoreCell")!
            let loadMoreBtn = cell.viewWithTag(111) as! UIButton
            offset = offset + 1
            loadMoreBtn.addTarget(self, action: #selector(self.loadUserList), for: .touchUpInside)
            return cell
        }
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "GroundIntroduceCell") as! GroundIntroduceCell
        let user = arrayUser[indexPath.row]
        cell.setData(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbView.deselectRow(at: indexPath, animated: true)
    }
    
}
