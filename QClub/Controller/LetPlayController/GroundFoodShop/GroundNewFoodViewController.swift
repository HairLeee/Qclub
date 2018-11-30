//
//  GroundNewFoodViewController.swift
//  QClub
//
//  Created by TuanNM on 10/24/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import TOCropViewController

class GroundNewFoodViewController: BaseViewController, UINavigationControllerDelegate {

    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var tbView: UITableView!
    var indexSet:Int = 1

    var foodCell:GroundNewFoodCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.config(title: "요긴 꼭 가봐야해! 나의 맛집", image: "ic_food.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        foodCell = tbView.dequeueReusableCell(withIdentifier: "GroundNewFoodCell") as! GroundNewFoodCell
        foodCell.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension GroundNewFoodViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 900
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return foodCell
    }
}

extension GroundNewFoodViewController:GroundNewFoodCellDelegate{

    func willAttachImage(index: Int) {
        let alertVC = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: { (success) in
                self.pickImage(isLibrary: false)
        }))
        alertVC.addAction(UIAlertAction(title: "Open Photo Library", style: .default, handler: { (success) in
            self.pickImage(isLibrary: true)
        }))
        
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (success) in
        }))
        
        indexSet = index
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func willRegister(restaurant: GRestaurant){
        let alertQ = AlertQClub.instanceFromNib(content: "한번 작성한 글은 수정하실 수 없습니다.\n 등록하시겠습니까?", image: "ic_done")
        alertQ.show()
        alertQ.action2 = {
            [weak self] in
            guard let _self = self else{return}
            _self.showLoading()
            GFoodService.createNewRestaurant(restaurant: restaurant, completion: {
                (response) in
                _self.stopLoading()
                _self.navigationController?.popViewController(animated: true)
            }, fail: { (error) in
                _self.stopLoading()
                print("createNewRestaurant error \(error)")
            })
        }
    }
    
    func willSearchLocation(){
        let searchVC = LocationSearchingViewController(nibName: "LocationSearchingViewController", bundle: nil)
        self.addChildViewController(searchVC)
        self.view.addSubview(searchVC.view)
        searchVC.didSelectAddress = {
            address in
            self.foodCell.address1.textField.text = address
        }
    }
    
}

extension GroundNewFoodViewController : UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image  = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let cropVC = TOCropViewController.init(croppingStyle: .default, image: image )
            cropVC.delegate = self
            cropVC.aspectRatioPreset = .presetSquare
            cropVC.aspectRatioLockEnabled = true
            cropVC.resetAspectRatioEnabled = false
            cropVC.aspectRatioPickerButtonHidden = true
            picker.dismiss(animated: false) {
                self.present(cropVC, animated: false, completion: nil)
            }
        }
    }
}

extension GroundNewFoodViewController : TOCropViewControllerDelegate {
    func pickImage(isLibrary: Bool) {
        let picker = UIImagePickerController()
        picker.sourceType = isLibrary ?  .photoLibrary : .camera
        picker.allowsEditing = false;
        picker.delegate = self;
        self.present(picker, animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        let thumbnail = UIImage().resizeImage(image: image, targetSize: CGSize(width: 200, height: 200))
        
        switch foodCell.lastIndexImageEmpty() {
        case 1:
            foodCell.image1.setImage(image: thumbnail)
            foodCell.imageData1 = image
            foodCell.checkEnableRegister()
            break
        case 2:
            foodCell.image2.setImage(image: thumbnail)
            foodCell.imageData2 = image
            foodCell.checkEnableRegister()
            break
        case 3:
            foodCell.image3.setImage(image: thumbnail)
            foodCell.imageData3 = image
            foodCell.checkEnableRegister()
            break
        case 4:
            foodCell.image4.setImage(image: thumbnail)
            foodCell.imageData4 = image
            foodCell.checkEnableRegister()
            break
        case 5:
            foodCell.image5.setImage(image: thumbnail)
            foodCell.imageData5 = image
            foodCell.checkEnableRegister()
            break
        default:
            break
        }
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true, completion: {
            
        })
    }
}
