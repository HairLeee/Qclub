//
//  QClubController.swift
//  QClub
//
//  Created by Dream on 9/14/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import TOCropViewController

class QClubController: UIViewController, ChooseOrTakeImage, OnClickListener, UINavigationControllerDelegate {
    func RemoveImage(pRemoveImageFromIndex: Int) {
        
        
    }
    
    
    
    var arrCell:[UITableViewCell] = []
    
    var arrAvatar = [(String,String,Bool,UIImage)]()
    
    
    struct cellID {
        static let topCell = "topCell"
        static let midCell = "midCell"
        static let bottomCell = "bottomCell"
        
        
    }
    
    @IBOutlet var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
        // Do any additional setup after loading the view.
    }
    var mImage = UIImage(named: "qclub_choose_image_icon.png")!
    func setupUI(){
        
        tbView.delegate = self
        tbView.dataSource = self
        
        arrAvatar = [("재직(재학) 확인서류","xyz",false, mImage),("신분 확인서류","현재 신분상태가 ‘다솔’인 경우 첨부하지 않으셔도 무방합니다.",false, mImage),("소득 or 자산 확인서류","xyz",false, mImage)]
        
        
        
        tbView.register(UINib.init(nibName: "SubmitTopTableViewCell", bundle: nil), forCellReuseIdentifier: cellID.topCell)
        tbView.register(UINib.init(nibName: "SubmitMidTableViewCell", bundle: nil), forCellReuseIdentifier: cellID.midCell)
        tbView.register(UINib.init(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: cellID.bottomCell)
        
        
    }
    
    var mIndexOfImage = 0
    func ChooseOrTakeImage(pIndexOfImage:Int) {
        mIndexOfImage = pIndexOfImage
        
        let joinPU = JoinPhotoPopup.instanceFromNib()
        joinPU.selectFromAlbum = {
            self.pickImage(isLibrary: true)
        }
        
        joinPU.takeAPhoto = {
            self.pickImage(isLibrary: false)
        }
        joinPU.show()
        
        
    }
    
    func Certificate() {
        
        let dialog =   AlertQClub.instanceFromNib(content: "제출하시겠습니까?", image: "avatar.png")
        dialog.show()
        
    }
    
    func NeedToUpLoadMoreImage() {
        
        tbView.beginUpdates()
        self.arrAvatar.append(("abc","xyz",false, mImage))
        tbView.insertRows(at: [IndexPath.init(row: self.arrAvatar.count - 1, section: 1)], with: .fade)
        tbView.endUpdates()
        
    }
    
    
    var mQClubInfo = QclubInfo()
    func getData(){
        
        MenuService.getQClubInfo(completion: { (response) in
            
            if let qclubInfo = response.data as? QclubInfo {
                print("Current Level = \(qclubInfo.currentLv)")
                self.mQClubInfo = qclubInfo
                self.tbView.reloadData()
                
                
            }
            
            
        }) { (error) in
            
            
            
        }
        
        
        
    }
    
    func clickOkAction() {
        
        for i in 0 ..< arrAvatar.count {
            if arrAvatar[i].2 == true {
                print("Images = \(arrAvatar[i].0)")
            }
        }
    }
    
    
}

extension QClubController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return arrAvatar.count
        case 2:
            return 1
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID.bottomCell, for: indexPath) as! HeaderTableViewCell
            cell.lbLevel.text = "\(mQClubInfo.currentLv)"
            if mQClubInfo.currentLv == "QS" {
                cell.lbLevel.text = "회원님은 이미 Q클럽 최고 등급인 QS등급입니다"
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID.topCell, for: indexPath) as! SubmitTopTableViewCell
            cell.tag = indexPath.row
            cell.bidingData(memberInfomation: arrAvatar[indexPath.row])
            cell.chooseOrTakeImage = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID.midCell, for: indexPath) as! SubmitMidTableViewCell
            cell.chooseOrTakeImage = self
            cell.onItemClick = self
            cell.updateLayoutAferGettingDataFinished(pStatus: mQClubInfo.status)
            return cell
            
            
        default:
            break
        }
        
        
        return arrCell[indexPath.row]
    }
    
    
    
    
}

extension QClubController : UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image  = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //            let cropVC = TOCropViewController.init(croppingStyle: .default, image: image )
            //            cropVC.delegate = self
            //            cropVC.aspectRatioPreset = .preset16x9
            //            cropVC.aspectRatioLockEnabled = true
            //            cropVC.resetAspectRatioEnabled = false
            //            cropVC.aspectRatioPickerButtonHidden = true
            //            picker.dismiss(animated: false) {
            //                self.present(cropVC, animated: false, completion: nil)
            //            }
            
            let currentCell =   tbView.cellForRow(at: IndexPath.init(row: mIndexOfImage, section: 1)) as! SubmitTopTableViewCell
            arrAvatar[mIndexOfImage].3 = image
            arrAvatar[mIndexOfImage].2 = true
            currentCell.updateImageAfterChooseOrTakeImage(pImage: image)
            picker.dismiss(animated: false) {
                
            }
            
        }
    }
}

extension QClubController : TOCropViewControllerDelegate {
    func pickImage(isLibrary: Bool) {
        let picker = UIImagePickerController()
        picker.sourceType = isLibrary ?  .photoLibrary : .camera
        picker.allowsEditing = false;
        picker.delegate = self;
        self.present(picker, animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        
        let currentCell =   tbView.cellForRow(at: IndexPath.init(row: mIndexOfImage, section: 1)) as! SubmitTopTableViewCell
        
        arrAvatar[mIndexOfImage].3 = image
        arrAvatar[mIndexOfImage].2 = true
        currentCell.updateImageAfterChooseOrTakeImage(pImage: image)
        
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true, completion: {
            
        })
    }
}

