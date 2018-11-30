//
//  GroundNewFoodCell.swift
//  QClub
//
//  Created by TuanNM on 10/24/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import IQDropDownTextField

protocol GroundNewFoodCellDelegate:class {
    func willSearchLocation()
    func willAttachImage(index:Int)
    func willRegister(restaurant:GRestaurant)
}

class GroundNewFoodCell: UITableViewCell {
    
    var provinces:[MasterDataObject] = []
    var districts:[MasterDataObject] = []
    
    weak var delegate:GroundNewFoodCellDelegate?
    @IBOutlet weak var provinceBox: BoxView!
    @IBOutlet weak var districtBox: BoxView!
    
    @IBOutlet weak var address1: TextFieldContainer!
    @IBOutlet weak var address2: TextFieldContainer!
    @IBOutlet weak var mainFood: TextFieldContainer!
    @IBOutlet weak var restaurantName: TextFieldContainer!
    @IBOutlet weak var price: TextFieldContainer!
    @IBOutlet weak var contactAddress: TextFieldContainer!
    @IBOutlet weak var introduce: IQTextView!
    
    @IBOutlet weak var image1: AttachImageView!
    @IBOutlet weak var image2: AttachImageView!
    @IBOutlet weak var image3: AttachImageView!
    @IBOutlet weak var image4: AttachImageView!
    @IBOutlet weak var image5: AttachImageView!
    
    var restaurant = GRestaurant()
    
    var imageData1:UIImage?
    var imageData2:UIImage?
    var imageData3:UIImage?
    var imageData4:UIImage?
    var imageData5:UIImage?
    
    @IBOutlet weak var registerBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       /*
        districts = [district1,district2,district3,district4,district5,district6,district7,district7,district9,district10,district11,district12,district3,district14,district15]
        
        provinceBox.textField.delegate = self
        provinceBox.setItems(items: province)
        */
        setLocationAddreess()
        provinceBox.textField.delegate = self
        
        address1.textField.delegate = self
        address1.textField.isUserInteractionEnabled = false
        address2.textField.delegate = self
        mainFood.textField.delegate = self
        restaurantName.textField.delegate = self
        price.textField.delegate = self
        contactAddress.textField.delegate = self
        introduce.delegate = self
        
        image1.callBackAttachImage = {self.delegate?.willAttachImage(index: 1)}
        image2.callBackAttachImage = {self.delegate?.willAttachImage(index: 2)}
        image3.callBackAttachImage = {self.delegate?.willAttachImage(index: 3)}
        image4.callBackAttachImage = {self.delegate?.willAttachImage(index: 4)}
        image5.callBackAttachImage = {self.delegate?.willAttachImage(index: 5)}
        
        image1.callBackDeleteImage = {self.imageData1 = nil}
        image2.callBackDeleteImage = {self.imageData2 = nil}
        image3.callBackDeleteImage = {self.imageData3 = nil}
        image4.callBackDeleteImage = {self.imageData4 = nil}
        image5.callBackDeleteImage = {self.imageData5 = nil}
        
        checkEnableRegister()
    }
    
    func lastIndexImageEmpty() -> Int {
        if imageData1 == nil {
            return 1
        }
        if imageData2 == nil {
            return 2
        }
        if imageData3 == nil {
            return 3
        }
        if imageData4 == nil {
            return 4
        }
        if imageData5 == nil {
            return 5
        }
        return 1
    }

    func setLocationAddreess() {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Location1, completion: { (response) in
            guard let results = response.data as? [MasterDataObject] else{return}
            self.provinces = results
            self.provinceBox.setItems(items: results.map{$0.detailName ?? ""})
        }) { (error) in
            print("getMasterData Location1 error \(error) ")
        }
        
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Location2, completion: { (response) in
            guard let results = response.data as? [MasterDataObject] else{return}
            self.districts = results
        }) { (error) in
            print("getMasterData Location2 error \(error) ")
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func registerAction(_ sender: Any) {
       
        guard let provinceStr = provinceBox.textField.selectedItem else{return}
        guard let districtLStr = districtBox.textField.selectedItem else{return}
        
        let masterProvince = provinces.filter { (obj) -> Bool in
            return obj.detailName == provinceStr
        }.last
        
        let masteDistrict = districts.filter { (obj) -> Bool in
            return obj.detailName == districtLStr
            }.last
       
        guard let tastyLocation = masterProvince?.detailSeq else{return}

        
        restaurant.tastyLocation = "\(tastyLocation)"
        restaurant.address = address1.textField.text!
        restaurant.mainDish = mainFood.textField.text!
        restaurant.price = price.textField.text!
        restaurant.contact = contactAddress.textField.text!
        restaurant.description = introduce.text
        restaurant.restaurant = restaurantName.textField.text!
        
        if imageData1 != nil {
            restaurant.tastyData.append(imageData1!)
        }
        if imageData2 != nil {
            restaurant.tastyData.append(imageData2!)
        }
        if imageData3 != nil {
            restaurant.tastyData.append(imageData3!)
        }
        if imageData4 != nil {
            restaurant.tastyData.append(imageData4!)
        }
        if imageData5 != nil {
            restaurant.tastyData.append(imageData5!)
        }
        
        self.delegate?.willRegister(restaurant: restaurant)
    }
    @IBAction func searchLocationAction(_ sender: Any) {
        self.delegate?.willSearchLocation()
    }
    
    
    
    func checkEnableRegister(){
        if  provinceBox.textField.hasText && districtBox.textField.hasText &&
            address1.textField.hasText && address2.textField.hasText &&
            mainFood.textField.hasText && restaurantName.textField.hasText &&
            price.textField.hasText && contactAddress.textField.hasText &&
            introduce.text.count > 0 &&
            (imageData1 != nil || imageData2 != nil || imageData3 != nil || imageData4 != nil || imageData5 != nil){
            
            registerBtn.isUserInteractionEnabled = true
            registerBtn.layer.borderColor = UIColor.init(hexString: ORANGE_COLOR)?.cgColor
            registerBtn.setTitleColor(UIColor.init(hexString: ORANGE_COLOR), for: .normal)
            return
        }
        
        registerBtn.isUserInteractionEnabled = false
        registerBtn.layer.borderColor = UIColor.init(hexString: LIGHT_GRAY_COLOR)?.cgColor
        registerBtn.setTitleColor(UIColor.init(hexString: LIGHT_GRAY_COLOR), for: .normal)
    }
}

extension GroundNewFoodCell:UITextFieldDelegate,IQDropDownTextFieldDelegate,UITextViewDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkEnableRegister()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        checkEnableRegister()
    }
    
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
        guard let province = item else{return}

        let districtFilter = districts.filter { (obj) -> Bool in
            return obj.refDetailName == province
        }
        
        self.districtBox.setItems(items: districtFilter.map{$0.detailName ?? ""})
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count // for Swift use count(newText)
        return numberOfChars < 101
    }
    
    
}

/*
 let province = ["서울 강남","서울 강북","인천","부산","대구","대전","충청도","강원","제주","경기북부","경기남부","경상도","울산","광주","전라도"]
 let district1 = ["가로수길",
 "강남역",
 "관악/신림",
 "구로",
 "노량진",
 "목동/강서",
 "반포/서래마을",
 "방배/사당",
 "서초/교대",
 "신논현/영동시장",
 "신사/잠원",
 "압구정/청담",
 "양재/도곡",
 "선릉/삼성/대치",
 "역삼",
 "영등포/여의도",
 "잠실/신천",
 "천호/강동"]
 
 let district2 = ["광진/건대입구",
 "광화문/시청",
 "노원/도봉/미아",
 "대학로",
 "동대문",
 "마포",
 "명동",
 "부암동/평창동",
 "삼청동",
 "상암",
 "서촌/경복궁",
 "성동/성수",
 "성북",
 "숙대/서울역",
 "신촌/이대",
 "안암/고대",
 "연남동/연희동",
 "연신내/불광",
 "이촌동/용산",
 "이태원/한남동",
 "종로/인사동",
 "충무로/신당동",
 "홍대/상수/합정",
 "회기"]
 
 let district3 = ["구리",
 "남양주",
 "의정부",
 "일산",
 "파주",
 "포천/동두천",
 "기타지역"]
 let district4 = ["광명",
 "광주",
 "김포",
 "동탄/오산",
 "부천",
 "분당/성남/판교",
 "수원",
 "안산",
 "안성",
 "안양/군포/의왕",
 "양평",
 "여주",
 "오이도",
 "용인",
 "죽전/수지",
 "시흥",
 "이천",
 "하남",
 "화성",
 "기타지역"]
 let district5 = ["강화도",
 "남구/남동구",
 "동구/중구",
 "부평구/계양구",
 "연수구/송도"]
 let district6 = ["광안리/경성대",
 "남포/영도/중구",
 "동래/부산대",
 "서면/부산진",
 "해운대/센텀"]
 let district7 = ["가창",
 "달서구/남구",
 "동구/중구",
 "동성로/중구",
 "수성구",
 "칠곡/북구/서구"]
 let district8 = ["거제",
 "경주",
 "구미",
 "남해",
 "안동",
 "울진",
 "진주",
 "창원",
 "통영",
 "포항",
 "기타지역"]
 let district9 = ["울산"]
 let district10 = ["광산구",
 "동구/남구",
 "북구",
 "서구"]
 let district11 = ["구례",
 "군산/부안",
 "담양",
 "목포",
 "무주",
 "보성",
 "순천",
 "여수",
 "익산",
 "전주",
 "기타지역"]
 let district12 = ["동구/대덕구",
 "유성구",
 "중구"]
 let district13 = ["공주",
 "단양",
 "보령",
 "부여",
 "아산",
 "천안",
 "청주",
 "충주",
 "태안",
 "기타지역"]
 let district14 = ["강릉",
 "동해",
 "삼척",
 "속초",
 "양양",
 "원주",
 "춘천",
 "태백/정선",
 "평창",
 "홍천",
 "기타지역"]
 let district15 = ["모슬포/화순",
 "서귀포시내",
 "성산/우도",
 "애월",
 "월정/함덕/김녕",
 "제주시내",
 "중문",
 "표선/성읍",
 "한림/한경"]
 
 var districts:[[String]] = [[]]
 */
