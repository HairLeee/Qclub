//
//  GroundSearchFoodCell.swift
//  QClub
//
//  Created by TuanNM on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQDropDownTextField

class GroundSearchFoodCell: UICollectionViewCell {

    var callBackSearch:((_ province:Int,_ district:Int)->Void)?
    @IBOutlet weak var province: BoxView!
    @IBOutlet weak var district: BoxView!
    @IBOutlet weak var lineBottomHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBTN: CompleteButton!
    
    var provinces:[MasterDataObject] = []
    var districts:[MasterDataObject] = []
    
    @IBAction func searchAction(_ sender: Any) {
        
        guard let provinceStr = province.textField.selectedItem else{return}
        guard let districtLStr = district.textField.selectedItem else{return}
        
        let masterProvince = provinces.filter { (obj) -> Bool in
            return obj.detailName == provinceStr
        }.last
        
        let masteDistrict = districts.filter { (obj) -> Bool in
            return obj.detailName == districtLStr
        }.last
        
        if let provinceDtailSeq = masterProvince?.detailSeq,let districDtailSeq = masteDistrict?.detailSeq{
            callBackSearch?(provinceDtailSeq,districDtailSeq)
        }
    }
    
    func setLocationAddreess(provinces:[MasterDataObject],districts:[MasterDataObject], proviceSelectedRow: Int, districtSelectedRow: Int){
        self.provinces = provinces
        self.districts = districts
        self.province.setItems(items: provinces.map{$0.detailName ?? ""})
        self.province.textField.selectedRow = proviceSelectedRow
        self.district.textField.selectedRow = districtSelectedRow
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lineBottomHeightConstraint.constant = 0.5
        province.textField.delegate = self
        district.textField.delegate = self
    }
}

extension GroundSearchFoodCell:IQDropDownTextFieldDelegate{
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
        
        if textField == self.province.textField {
            guard let province = item else{return}
            let districtFilter = districts.filter { (obj) -> Bool in
                return obj.refDetailName == province
            }
            self.district.setItems(items: districtFilter.map{$0.detailName ?? ""})
        }
        
        if let _ = self.province.textField.selectedItem, let _ = self.district.textField.selectedItem {
            self.searchBTN.changeState(isActive: true)
        } else {
            self.searchBTN.changeState(isActive: false)
        }
    }
}
