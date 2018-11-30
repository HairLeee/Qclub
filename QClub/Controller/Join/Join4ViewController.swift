//
//  Join4ViewController.swift
//  QClub
//
//  Created by SMR on 10/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQDropDownTextField
import DLRadioButton

/*
 Join4, Page 11 in StoryBoard
 */
class Join4ViewController: BaseViewController {

    @IBOutlet weak var okBTN: CompleteButton!
    @IBOutlet weak var TFreligion: IQDropDownTextField!
    @IBOutlet weak var TFisDrink: IQDropDownTextField!
    @IBOutlet weak var TFisSmoke: IQDropDownTextField!
    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var marrigeStateOption: DLRadioButton!
    @IBOutlet weak var matchingTarget: DLRadioButton!
    @IBOutlet weak var tfSchool: TextfieldQClub!
    @IBOutlet weak var tfCompany: TextfieldQClub!
    @IBOutlet weak var tfJob: TextfieldQClub!
    @IBOutlet weak var tfRelegionInput: UITextField!
    
    
    @IBOutlet var lbDivorcedOrNotTitle: UILabel!
    
    @IBOutlet var lbDivorcedOrNotDes: UILabel!
    
    
    @IBOutlet var viewDivorcedOrNot: UIView!
    
    var viewModel = Join4ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getRelegionInfoList { (data) in
            self.TFreligion.itemList = data
        }
        viewModel.getDrinkInfoList { (data) in
            self.TFisDrink.itemList = data
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "회원가입", image: "ic_navigation_join")
    }
    
    func configDropDownTextField() {
        TFreligion.isOptionalDropDown = true
        TFreligion.delegate = self
        
        TFisDrink.isOptionalDropDown = true
        TFisDrink.delegate = self
        
        TFisSmoke.isOptionalDropDown = true
        TFisSmoke.itemList = ["흡연", "비흡연"]
        TFisSmoke.delegate = self
        
        tfSchool.addTarget(self, action: #selector(validateCompleteInput), for: .editingChanged)
        tfCompany.addTarget(self, action: #selector(validateCompleteInput), for: .editingChanged)
        tfJob.addTarget(self, action: #selector(validateCompleteInput), for: .editingChanged)
        
        
        
    }
    
    
    @IBAction func marrigeStateOption(_ sender: Any) {
        validateCompleteInput()
    }
    
    
    @IBAction func singleStateOption(_ sender: Any) {
         validateCompleteInput()
    }
    
    func setupUI() {
      btnAcceptState.isSelected = true
        viewDivorcedOrNot.isHidden = true
        configDropDownTextField()
    }
    
    
    

    @IBAction func okTUI(_ sender: Any) {
        let join5VC = viewModel.join5VC()
        makeDataForUserObject()
        join5VC.viewModel.userJoin = viewModel.userJoin
        self.navigationController?.pushViewController(join5VC, animated: true)
    }
    
    @objc func validateCompleteInput() {
        if TFreligion.selectedItem == nil {
            self.okBTN.changeState(isActive: false)
            return
        }
        if TFisDrink.selectedItem == nil {
            self.okBTN.changeState(isActive: false)
            return
        }
        if TFisSmoke.selectedItem == nil {
            self.okBTN.changeState(isActive: false)
            return
        }
        
        if tfSchool.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count  == 0 {
            self.okBTN.changeState(isActive: false)
            return
        }
        if tfCompany.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            self.okBTN.changeState(isActive: false)
            return
        }
        if tfJob.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0{
            self.okBTN.changeState(isActive: false)
            return
        }
        if marrigeStateOption.selected() == nil {
            self.okBTN.changeState(isActive: false)
            return
        }
        if matchingTarget.selected() == nil {
            self.okBTN.changeState(isActive: false)
            return
        }
        
        self.okBTN.changeState(isActive: true)
    }
    
    @IBOutlet var btnAcceptState: DLRadioButton!
    //    var isAllowToActionFrom
    @IBAction func btnSingleTouchAction(_ sender: Any) {
        allowDivorcedOrNot(isDevorced: true)
        validateCompleteInput()
    }
    
    @IBAction func btnDivorcedTouchAction(_ sender: Any) {
        allowDivorcedOrNot(isDevorced: false)
        validateCompleteInput()
    }
    
    
    @IBAction func btnAcceptTouchUpAction(_ sender: Any) {
         validateCompleteInput()
    }
    
    @IBAction func btnDonAcceptTouchUpAction(_ sender: Any) {
         validateCompleteInput()
    }
    
    func allowDivorcedOrNot(isDevorced:Bool){
        
        if isDevorced {
            viewDivorcedOrNot.isHidden = false
        } else {
            
              viewDivorcedOrNot.isHidden = true
        }

    }
    
    func makeDataForUserObject() {
        viewModel.userJoin?.company = tfCompany.text
        viewModel.userJoin?.job = tfJob.text
        viewModel.userJoin?.school = tfSchool.text
        viewModel.userJoin?.religion = viewModel.relegionInfoList[TFreligion.selectedRow].detailSeq
        viewModel.userJoin?.religionEtc = ""
        viewModel.userJoin?.maritalStatus = marrigeStateOption.selected()?.tag == 1 ? "S" : "R"
        viewModel.userJoin?.matchingTarget = matchingTarget.selected()?.tag == 1 ? "Y" : "N"
        viewModel.userJoin?.drinking = viewModel.drinkInfoList[TFisDrink.selectedRow].detailSeq
        viewModel.userJoin?.smoking = TFisSmoke.selectedRow + 1
    }
}

extension Join4ViewController: IQDropDownTextFieldDelegate {
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
        validateCompleteInput()
    }
}

