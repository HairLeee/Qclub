//
//  MyInfoMainViewController.swift
//  QClub
//
//  Created by Dreamup on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//
//Page 155 in the Storyboard
import UIKit
import TOCropViewController
class MyInfoMainViewController: BaseViewController, GoToAnotherScreenFromCell, UINavigationControllerDelegate, ChooseOrTakeImage {
  
    
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    @IBOutlet weak var tbView: UITableView!
    var isBackFromUploadImage = false
    
    struct cellID {
        static let topCell = "topCell"
        static let midCell = "midCell"
        static let bottomCell = "bottomCell"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    var cellArr:[UITableViewCell] = []
    
    func setupUI(){
        tbView.delegate = self
        tbView.dataSource = self
        
        
        tbView.register(UINib.init(nibName: "MyInfoMainTopViewCell", bundle: nil), forCellReuseIdentifier: cellID.topCell)
        tbView.register(UINib.init(nibName: "MyInfoMainMidTableViewCell", bundle: nil), forCellReuseIdentifier: cellID.midCell)
        
        
        let topCell = tbView.dequeueReusableCell(withIdentifier: cellID.topCell) as! MyInfoMainTopViewCell
        topCell.chooseOrTakeImageDelegate = self
        let midCell = tbView.dequeueReusableCell(withIdentifier: cellID.midCell) as! MyInfoMainMidTableViewCell
        
        
        cellArr = [topCell,midCell]
        
        tbView.estimatedRowHeight = 100
        tbView.rowHeight = UITableViewAutomaticDimension
        tbView.allowsSelection = false
        
        
    }
    
    var mMember:Member?
    func getData(){
        self.showLoading()
        MenuService.getMyInfo(completion: { (response) in
            if let data = response.data as? Member {
                self.mMember = data
                self.tbView.reloadData()
            }
            self.stopLoading()
        }) { (error) in
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !isBackFromUploadImage {
            getData()
        } else {
            isBackFromUploadImage = false
        }
    }
    
    var mIndexOfImage = 0
    func ChooseOrTakeImage(pIndexOfImage: Int) {
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
    
    
    func RemoveImage(pRemoveImageFromIndex: Int) {
        
    }
    
    func Certificate() {
        
    }
    
    func NeedToUpLoadMoreImage() {
        
    }
    
    
    
    @IBAction func btnCommentAction(_ sender: Any) {
        
        let commentViewVC = MyInfoCommentViewController.init(nibName: "MyInfoCommentViewController", bundle: nil)
        self.navigationController?.pushViewController(commentViewVC, animated: true)
    }
    
    func goToAnotherScreenFromCell(nameOfScreen: String) {
        
        switch nameOfScreen {
        case "MyInfoModifyOneViewController":
            navigationController?.pushViewController(MyInfoModifyOneViewController.init(nibName:"MyInfoModifyOneViewController", bundle:nil), animated: true)
            
        case "MyinfoModifyTwoViewController":
            
            let myInfoTwo = MyinfoModifyTwoViewController.init(nibName: "MyinfoModifyTwoViewController", bundle: nil)
            myInfoTwo.mMember = self.mMember
            
            navigationController?.pushViewController(myInfoTwo, animated: true)
   
        case "MyinfoModifyThreeViewController":
            navigationController?.pushViewController(MyinfoModifyThreeViewController.init(nibName:"MyinfoModifyThreeViewController", bundle:nil), animated: true)
            
        default:
            break
        }
        
    }

    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            //            self.dismiss(animated: true, completion: nil)
        }
        navigationView.config(title: "내 정보 수정", image: "myinfo2_header_icon")
    }
    
    
    
}

extension MyInfoMainViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            
            let cell = cellArr[indexPath.row] as! MyInfoMainTopViewCell
      
            if let pMember = mMember {
                cell.bidingData(member:pMember)
            }
            
            
        case 1:
            
            let cell = cellArr[indexPath.row] as! MyInfoMainMidTableViewCell
            cell.start = self
            if let pMember = mMember {
                  cell.bidingData(member:pMember)
            }
          
            
        default:
            break
        }
        
        
        
        return cellArr[indexPath.row]
    }
    
}


extension MyInfoMainViewController : UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image  = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let cropVC = TOCropViewController.init(croppingStyle: .default, image: image )
            cropVC.delegate = self
            cropVC.aspectRatioPreset = .preset16x9
            cropVC.aspectRatioLockEnabled = true
            cropVC.resetAspectRatioEnabled = false
            cropVC.aspectRatioPickerButtonHidden = true
            picker.dismiss(animated: false) {
                self.present(cropVC, animated: false, completion: nil)
            }
        }
    }
}

extension MyInfoMainViewController : TOCropViewControllerDelegate {
    func pickImage(isLibrary: Bool) {
        isBackFromUploadImage = true
        let picker = UIImagePickerController()
        picker.sourceType = isLibrary ?  .photoLibrary : .camera
        picker.allowsEditing = false;
        picker.delegate = self;
        self.present(picker, animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        let user = UserImage()
        user.profilePicture = image
        self.showLoading()
        MenuService.uploadProfile(image: user, completion: { (response) in
            let currentCell = self.tbView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! MyInfoMainTopViewCell
            currentCell.updateImageAfterChooseOrTakeImage(pImage: image, indexOfCollectionItem: self.mIndexOfImage)
            self.stopLoading()
        }) { (error) in
            self.stopLoading()
        }
        

        
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true, completion: {
            
        })
    }
}



