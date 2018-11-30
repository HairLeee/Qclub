//
//  SearchListViewController.swift
//  QClub
//
//  Created by SMR on 11/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQDropDownTextField

/*
 candy_search, candy_list , Page 56,58 in StoryBoard
 */

class SearchListViewController: UIViewController {

    @IBOutlet weak var vList: UIView!
    @IBOutlet weak var vSearch: UIView!
    @IBOutlet weak var tableviewList: UITableView!
    @IBOutlet weak var tableviewSearch: UITableView!
    @IBOutlet weak var ageDropdownTextField: IQDropDownTextField!
    @IBOutlet weak var locationDropdownTextField: IQDropDownTextField!
    @IBOutlet weak var searchButton: CompleteButton!
    
    @IBOutlet weak var toogleSearchBTN: SlideButton!
    @IBOutlet weak var toogleListBTN: SlideButton!
    
    var dataCandySearch = [CandyMemberModel]()
    var dataCandyList = [CandyMemberModel]()
    var locationList = [MasterDataObject]()
    
    var goToListTalk : ((_ member : CandyMemberModel) -> ())?
    var goToStore : (() -> ())?
    var goToUserVC : ((_ userSeq: Int) -> ())?
    var goToRegisterVC : (() -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchListUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSearchListUI() {
        setupSearchListTableview()
        setupSearchListDropdown()
        getLocationInfoList()
    }
    
    func setupSearchListTableview() {
        tableviewSearch.delegate = self
        tableviewSearch.dataSource = self
        tableviewSearch.separatorStyle = .none
        tableviewSearch.allowsSelection = false
        tableviewSearch.register(UINib.init(nibName: "CandyTableViewCell", bundle: nil), forCellReuseIdentifier: "CandyTableViewCell")
        tableviewSearch.register(UINib.init(nibName: "CandySearchNoDataCell", bundle: nil), forCellReuseIdentifier: "CandySearchNoDataCell")
        tableviewSearch.contentInset = UIEdgeInsets.init(top: 15, left: 0, bottom: 0, right: 0)
        
        tableviewList.delegate = self
        tableviewList.dataSource = self
        tableviewList.separatorStyle = .none
        tableviewList.allowsSelection = false
        tableviewList.register(UINib.init(nibName: "CandyTableViewCell", bundle: nil), forCellReuseIdentifier: "CandyTableViewCell")
        tableviewList.contentInset = UIEdgeInsets.init(top: 15, left: 0, bottom: 0, right: 0)
    }
    
    func setupSearchListDropdown() {
        ageDropdownTextField.itemList = ["10대","20대","30대","40대","50대 이상"]
        ageDropdownTextField.delegate = self
        
        locationDropdownTextField.delegate = self
    }
    
    @IBAction func goToRegister(_ sender: Any) {
        goToRegisterVC?()
    }
    
    @IBAction func searchAction(_ sender: Any) {
        toogleSearchBTN.setSelect(isSelected: true)
        toogleListBTN.setSelect(isSelected: false)
        vSearch.isHidden = false
        vList.isHidden = true
    }
    
    @IBAction func listAction(_ sender: Any) {
        toogleSearchBTN.setSelect(isSelected: false)
        toogleListBTN.setSelect(isSelected: true)
        vSearch.isHidden = true
        vList.isHidden = false
        getCandyList()
    }
    
    func getLocationInfoList() {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Location, completion: { (response) in
            if let data = response.data as? [MasterDataObject] {
                self.locationList = data
                self.locationDropdownTextField.itemList = data.map{$0.detailName ?? ""}
            }
        }) { (error) in
            
        }
    }
    
    func getCandyList() {
        self.showLoading()
        CandyService.candylist(completion: { (response) in
            self.dataCandyList.removeAll()
            if let data = response.data as? [CandyMemberModel] {
                self.dataCandyList = data
                self.tableviewList.reloadData()
            }
            self.stopLoading()
        }) { (error) in
            self.stopLoading()
        }
    }
    
    @IBAction func candySearchAction(_ sender: Any) {
        Utils.checkHeartIsEnough(viewController: self, numberOfHeartIsNeed: 2, completion: { (isEnough, heartCount) in
            if isEnough {
                let popup = CandySearchPayPopup.instanceFromNib(numberOfHeart: heartCount)
                popup.action = {
                    [weak self] in
                    guard let _self = self else {return}
                    _self.showLoading()
                    CandyService.candySearch(locationIndex: _self.locationList[_self.locationDropdownTextField.selectedRow].detailSeq ?? 0, ageRange: _self.ageDropdownTextField.selectedRow + 1, completion: { (response) in
                        _self.dataCandySearch.removeAll()
                        if let data = response.data as? [CandyMemberModel] {
                            _self.dataCandySearch = data
                            _self.tableviewSearch.reloadData()
                        }
                        _self.stopLoading()
                    }) { (error) in
                        _self.stopLoading()
                    }
                }
                popup.show()
            }
        }) { (error) in
            
        }
        

    }
    
}

// MARK: Tableview binding
extension SearchListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tableviewSearch:
            return dataCandySearch.count > 0 ? dataCandySearch.count : 1
        case tableviewList:
            return dataCandyList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CandyTableViewCell") as! CandyTableViewCell
        if tableView == tableviewSearch {
            if dataCandySearch.count > 0 {
                let member = dataCandySearch[indexPath.row]
                cell.setData(member: member)
                cell.selectCell = {
                    Utils.checkHeartIsEnough(viewController: self, numberOfHeartIsNeed: 40, completion: { (isEnough, count) in
                        if isEnough {
                            let popup = CandySearchPopup.instanceFromNib(numberOfHeart: count)
                            popup.action = {
                                [weak self] in
                                guard let _self = self else {return}
                                _self.showLoading()
                                CandyService.candyRequest(candyUserSeq: member.userSeq, completion: { (response) in
                                    _self.stopLoading()
                                    _self.view.makeToast(response.message ?? "", duration: 2.0, position: .center)
                                }, fail: { (error) in
                                    _self.stopLoading()
                                    _self.view.makeToast(error.localizedDescription, duration: 2.0, position: .center)
                                })
                            }
                            popup.show()
                        }
                    }, fail: { (error) in
                        
                    })
                }
            } else {
                return tableView.dequeueReusableCell(withIdentifier: "CandySearchNoDataCell")!
            }

        } else if tableView == tableviewList {
            cell.setData(member: dataCandyList[indexPath.row])
            cell.letterAction = {
                [weak self] userInfo in
                guard let _self = self else {return}
                Utils.messageAction(user: userInfo, viewController: _self)
            }
            cell.selectCell = {
                [weak self] in
                guard let _self = self else {return}
                let member = _self.dataCandyList[indexPath.row]
                if let _ = member.candyViewPaid {
                    //Candy list popup
                    _self.showLoading()
                    RelationService.getHeartCount(completion: { (response) in
                        let count = response.data as! Int
                        let popup = CandyListPopup.instanceFromNib(numberOfHeart: count)
                        popup.action = {
                            CandyService.candyViewProfile(candyListSeq: member.userSeq, completion: { (response) in
                                if response.code == 0 {
                                    _self.goToUserVC?(member.userSeq)
                                } else {
                                    _self.goToStore?()
                                }
                            }, fail: { (error) in
                                
                            })
                        }
                        
                    }, fail: { (error) in
                        
                    })
                } else {
                    _self.goToListTalk?(_self.dataCandyList[indexPath.row])
                }

            }
        }
        return cell
    }
    
    
}

extension SearchListViewController: IQDropDownTextFieldDelegate {
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
        if textField == ageDropdownTextField || textField == locationDropdownTextField {
            if let _ = ageDropdownTextField.selectedItem, let _ = locationDropdownTextField.selectedItem {
                searchButton.changeState(isActive: true)
            } else {
                searchButton.changeState(isActive: false)
            }
        }
    }
}

extension SearchListViewController : UserLetterViewControllerDelegate {
    func sendImageSuccess() {
        getCandyList()
    }
}

