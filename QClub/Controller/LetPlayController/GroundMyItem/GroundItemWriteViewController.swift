//
//  GroundItemWriteViewController.swift
//  QClub
//
//  Created by TuanNM on 10/26/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

struct Item {
    var thumb:UIImage?
    var data:UIImage?
    var description:String?
}

class GroundItemWriteViewController: BaseViewController {

    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var nameTfContainer: TextFieldContainer!
    
    var arrItems:[Item] = [Item(),Item(),Item(),Item(),Item(),Item()]
    var isPostAble = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.config(title: "나의 잇아이템 소개(등록)", image: "ic_myItem.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func post() {
        let alert = UIAlertController.init(title: nil, message: "한번 작성한 글은 수정하실 수 없습니다. 등록하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "확인", style: .default, handler: { (action) in
            self.showLoading()
            ItemService.uploadItem(title: self.nameTfContainer.textField.text! , items: self.arrItems, completion: { (response) in
                self.stopLoading()
                self.navigationController?.popViewController(animated: true)
            }) { (error) in
                self.stopLoading()
            }
        })
        let cancelAction = UIAlertAction.init(title: "취소", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func getLastIndexEmty() -> Int {
        for i in 0...(arrItems.count - 1) {
            if arrItems[i].thumb == nil {
                return i
            }
        }
        return 0
    }
    
}
extension GroundItemWriteViewController:GroundItemWriteCellDelegate{
    func willAddPhotoCell(index: Int) {
        let alertVC = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Open Camera", style: .default, handler: { (success) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
                
            }
        }))
        alertVC.addAction(UIAlertAction(title: "Open Photo Library", style: .default, handler: { (success) in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }))
        
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (success) in
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

extension GroundItemWriteViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 6 {
            let cell = tbView.dequeueReusableCell(withIdentifier: "GroundItemWriteCell") as! GroundItemWriteCell
            cell.delegate = self
            cell.index = indexPath.row
            let item = arrItems[indexPath.row]
            if let image = item.thumb{
                cell.photoImv.image = image
                cell.introduceTv.isHidden = false
            } else {
                cell.introduceTv.isHidden = true
            }
            if let des = item.description {
                cell.introduceTv.text = des
            }
            return cell
        } else {
            let cell = tbView.dequeueReusableCell(withIdentifier: "PostTableviewCell") as! PostTableviewCell
            cell.postBTN.changeState(isActive: isPostAble)
            cell.post = {
                [weak self] in
                guard let _self = self else {return}
                _self.post()
            }
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row < 6 ? 120 : 60
    }
}

extension GroundItemWriteViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var image:UIImage!
        if let _image = info[UIImagePickerControllerEditedImage]  as? UIImage{
            image = _image
        }else{
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        
        let thumbnail = UIImage().resizeImage(image: image, targetSize: CGSize(width: 200, height: 200))
        
        picker.dismiss(animated: true, completion: nil)
        let indexToSet = self.getLastIndexEmty()
        arrItems[indexToSet].thumb = thumbnail
        arrItems[indexToSet].data = image
//        item.thumb = thumbnail
//        item.data = image
        
        self.tbView.reloadRows(at: [IndexPath.init(row: indexToSet, section: 0)], with: .none)
//        let cell = tbView.cellForRow(at: IndexPath(item: indexToSet, section: 0)) as! GroundItemWriteCell
//        cell.photoImv.image = thumbnail
        
        self.isPostAble = true
        self.tbView.reloadRows(at: [IndexPath.init(row: 6, section: 0)], with: .none)
        
    }
}
