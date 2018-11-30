//
//  UserCommentPopup.swift
//  QClub
//
//  Created by SMR on 10/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class UserCommentPopup: PopupView {

    @IBOutlet weak var lbContentTop: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var okBTN: UIButton!
    var userSeq = 0
    @IBAction func okTUI(_ sender: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            ProfileService.getAdvice(userSeq: self.userSeq, completion: { (response) in
                let mes = (response.code == 0  ? "이미 프로필 조언을 하셨습니다" : "프로필 개선 조언이 전달 되었습니다.\n하트가 1개 적립되었습니다")
                
                ProfileService.postAdvice(userSeq: self.userSeq, adviceIndexs: selectedRows.map{$0.row}, completion: { (response) in
                    self.makeToast(mes, duration: 2, position: .center, title: nil, image: nil, style: nil, completion: { (done) in
                        self.hide()
                    })
                }) { (error) in
                    
                }
                
            }, fail: { (error) in
                
            })
            

        }
    }
    
    let selectedView = UIView()
    
    var data = [MasterDataObject]()
    
    var actionOk: (() -> ())?
    
    class func instanceFromNib(userSeq: Int) -> UserCommentPopup {
        let joinView = UINib(nibName: "UserCommentPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UserCommentPopup
        joinView.userSeq = userSeq
        joinView.popupFrame = CGRect.init(x: 20, y: 20 , width: SCREEN_WIDTH - 40, height: SCREEN_HEIGHT - 100)
        return joinView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "UserCommentPopupCell", bundle: nil), forCellReuseIdentifier: "UserCommentPopupCell")
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        okBTN.isUserInteractionEnabled = false
        selectedView.backgroundColor = backgroundCellSelectedColor
        getData()
    }
    
    
    func getData() {
        UIApplication.shared.keyWindow?.currentViewController()?.showLoading()
        AuthService.getMasterData(masterSeq: Constants.MasterCode.UserAdvice, completion: { (response) in
            if let data = response.data as? [MasterDataObject] {
                self.data = data
                self.tableView.reloadData()
            }
            UIApplication.shared.keyWindow?.currentViewController()?.stopLoading()
        }) { (error) in
            UIApplication.shared.keyWindow?.currentViewController()?.stopLoading()
        }
    }
    
    func changeOkbutton() {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            if selectedRows.count >= 1 {
                okBTN.setTitleColor(buttonActiveColor, for: .normal)
                okBTN.isUserInteractionEnabled = true
            } else {
                okBTN.setTitleColor(buttonInActiveColor, for: .normal)
                okBTN.isUserInteractionEnabled = false
            }
        } else {
            okBTN.setTitleColor(buttonInActiveColor, for: .normal)
            okBTN.isUserInteractionEnabled = false
        }
    }
    
    
}
extension UserCommentPopup : UITableViewDelegate {

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            if selectedRows.count >= 5 {
                UIApplication.shared.keyWindow?.makeToast("최대 5개까지만 선택하실 수 있습니다.”", duration: 2, position: .center)
                return nil
            }
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeOkbutton()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        changeOkbutton()
    }
    
}

extension UserCommentPopup: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCommentPopupCell") as! UserCommentPopupCell
        cell.lbContent.text = data[indexPath.row].detailName
        let view = UIView()
        view.backgroundColor = backgroundCellSelectedColor
        cell.multipleSelectionBackgroundView = view
        return cell
    }

}
