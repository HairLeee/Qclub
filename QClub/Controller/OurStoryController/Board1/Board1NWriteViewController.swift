//
//  Board1NWriteViewController.swift
//  QClub
//
//  Created by Dreamup on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import TOCropViewController
class Board1NWriteViewController: BaseViewController, ChooseOrTakeImage,UINavigationControllerDelegate {
    

    func Certificate() {
        
    }
    
    func NeedToUpLoadMoreImage() {
        
    }
    

    struct cellID {
        static let imageCell = "imageCell"
    }
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    @IBOutlet var tvTitle: UITextView!
    
    @IBOutlet var tvDes: UITextView!
    
    var mBoardN = BoardN()
    
    var mStoryPictures = [UserImage]()
    
    var mStoryDetail = 1
    
    
    @IBOutlet var btnOkOutLet: CompleteButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func configNavigationBar() {
        
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            
        }
        navigationView.config(title: "글작성", image: "board1_detail_header_icon")
        
    }
    
    func setupUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        tvTitle.delegate = self
        tvDes.delegate = self
        enableButton(isEnable: false)
        collectionView.register(UINib.init(nibName: "Board1NWriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID.imageCell)
  
    }
    
    
    var mIndexOfImage = 0
    func ChooseOrTakeImage(pIndexOfImage:Int) {
        //mIndexOfImage = pIndexOfImage
        
        let joinPU = BoardNWriteChooseImagePopup.instanceFromNib()
        joinPU.selectFromAlbum = {
            self.pickImage(isLibrary: true)
        }
        
        joinPU.takeAPhoto = {
            self.pickImage(isLibrary: false)
        }
        joinPU.show()
        
        
    }
    
    
    func RemoveImage(pRemoveImageFromIndex: Int) {
        
        print("Remove From Item \(pRemoveImageFromIndex)")
        let currentCell =   collectionView.cellForItem(at: IndexPath.init(row: pRemoveImageFromIndex, section: 0)) as! Board1NWriteCollectionViewCell
        currentCell.mImage = nil
        currentCell.setupLayout()
        checkValidate()
        currentCell.removeImageFromCollectionViewItem()
        
    }
    
    func checkValidate(){
        
        if tvTitle.text.trimmingCharacters(in: .illegalCharacters).count == 0 {
            
            enableButton(isEnable: false)
            return
        }
        
        if tvDes.text.trimmingCharacters(in: .illegalCharacters).count == 0 {
            
            enableButton(isEnable: false)
            return
        }
        
        enableButton(isEnable: true)
        
    }
    
    func getPictures() -> [UserImage]{
        
        var pictures = [UserImage]()
        
        for i in 0 ..< collectionView.indexPathsForVisibleItems.count {
            
            let currentCell =   collectionView.cellForItem(at: collectionView.indexPathsForVisibleItems[i]) as! Board1NWriteCollectionViewCell
            
            if let pImage = currentCell.mImage {
                let pUserImage = UserImage()
                pUserImage.descriptionString = ""
                pUserImage.orderSeq = i
                pUserImage.profilePicture = pImage
                pUserImage.profilePictureUrl = ""
                pictures.append(pUserImage)
            }
        }
        
        return pictures
    }
    
    func enableButton(isEnable:Bool){
        btnOkOutLet.changeState(isActive: isEnable)

    }
    
    
    @IBAction func btnOK(_ sender: Any) {
 
        mBoardN.storyPictures = getPictures()
        
        // if user not send image, add a logo image
        if mBoardN.storyPictures?.count == 0 {
            let pUserImage = UserImage()
            pUserImage.descriptionString = ""
            pUserImage.orderSeq = mIndexOfImage
            pUserImage.profilePicture = UIImage.init(named: "logo_for_boardN_write")
            pUserImage.profilePictureUrl = ""
            mBoardN.storyPictures?.append(pUserImage)
        }
        
        self.showLoading()
        MenuService.uploadBoardInfo(storyDetail:mStoryDetail,user: mBoardN, completion: { (response) in
            self.stopLoading()
            self.navigationController?.popViewController(animated: true)
            self.view.makeToast("글이 등록되었습니다")
        }) { (error) in
            self.stopLoading()
        }
        
    }

}

extension Board1NWriteViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID.imageCell, for: indexPath) as! Board1NWriteCollectionViewCell
        cell.tag = indexPath.row
        cell.ChooseOrTakeImage = self
        cell.setupLayout()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }

    
}

extension Board1NWriteViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
}

extension Board1NWriteViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/3 , height: self.collectionView.frame.size.width*3/16)
    }
}

extension Board1NWriteViewController : UIImagePickerControllerDelegate {
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

extension Board1NWriteViewController : TOCropViewControllerDelegate {
    func pickImage(isLibrary: Bool) {
        let picker = UIImagePickerController()
        picker.sourceType = isLibrary ?  .photoLibrary : .camera
        picker.allowsEditing = false;
        picker.delegate = self;
        self.present(picker, animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        let imageResize = UIImage().resizeImage(image: image, targetSize: CGSize.init(width: 500, height: 500))
        
        let currentCell = collectionView.cellForItem(at: IndexPath.init(row: mIndexOfImage, section: 0)) as! Board1NWriteCollectionViewCell
       
        currentCell.updateImageAfterChooseOrTakeImage(pImage: imageResize)
        currentCell.setupLayout()
        checkValidate()
        cropViewController.dismiss(animated: true, completion: nil)
        
        mIndexOfImage = mIndexOfImage + 1
        
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true, completion: {
            
        })
    }
}

extension Board1NWriteViewController:UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        switch textView {
        case tvTitle:
            mBoardN.title = tvTitle.text
            checkValidate()
        case tvDes:
            
            mBoardN.des = tvDes.text
            checkValidate()
        default:
            break
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let characterLimit = 201
        let newText = NSString(string: tvDes.text!).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count
        return numberOfChars < characterLimit
    }

}


