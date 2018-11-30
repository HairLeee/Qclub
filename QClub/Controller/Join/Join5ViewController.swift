//
//  Join5ViewController.swift
//  QClub
//
//  Created by SMR on 10/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

import TOCropViewController

/*
 Join5, Page 12 in StoryBoard
 */
class Join5ViewController: BaseViewController, UINavigationControllerDelegate {

    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = Join5ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "회원가입", image: "ic_navigation_join")
    }
}

extension Join5ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.numberOfImageRow()
        case 2:
            return viewModel.numberOfAddCaptureCellRow()
        case 3:
            return 1
        default:
            return 0
        }
    }
}

extension Join5ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.topCellId)
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.captureCellId) as! Join5CaptureCellTableViewCell
            cell.bindingData(data: viewModel.dataImageForIndexpath(indexPath: indexPath))
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.addCaptureCellId) as! Join5AddCaptureTableViewCell
            cell.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.finishCellId) as! Join5FinishTableViewCell
            cell.bindingData(isActive: viewModel.isAvaibleComplete)
            cell.delegate = self
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
}

extension Join5ViewController: Join5CaptureCellTableViewCellDelegate {
    func getImage(sender: UIButton) {
        
        weak var weakSelf = self
        
        let joinPU = JoinPhotoPopup.instanceFromNib()
        joinPU.selectFromAlbum = {
            
            if let _ = sender.superview?.superview?.superview as? Join5CaptureCellTableViewCell{
                weakSelf?.pickImage(isLibrary: true)
            }

        }
        
        joinPU.takeAPhoto = {
            if let _ = sender.superview?.superview?.superview as? Join5CaptureCellTableViewCell{
                weakSelf?.pickImage(isLibrary: false)
            }
        }
        
        joinPU.deleteImage = {
            
            if let cell = sender.superview?.superview?.superview as? Join5CaptureCellTableViewCell{
                let indexPath = weakSelf?.tableView.indexPath(for: cell)
                
                CATransaction.begin()
                CATransaction.setCompletionBlock({
                    if (weakSelf?.viewModel.imagesIsNearMax())! {
                        weakSelf?.tableView.beginUpdates()
                        weakSelf?.viewModel.isAddCaptureCellAvaible = true
                        weakSelf?.tableView.insertRows(at: [IndexPath.init(row: 0, section: 2)], with: .fade)
                        weakSelf?.tableView.endUpdates()
                    }
                })
                weakSelf?.viewModel.images.remove(at: (indexPath?.row)!)
                weakSelf?.tableView.beginUpdates()
                weakSelf?.tableView.deleteRows(at: [indexPath!], with: UITableViewRowAnimation.left)
                weakSelf?.tableView.endUpdates()
                weakSelf?.viewModel.checkOkButtonEnable()
                weakSelf?.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 3)], with: .fade)
                CATransaction.commit()
            }
        }
        
        joinPU.show()
    }
    
    func updateText(text: String, sender: UIButton) {
        weak var weakSelf = self
        if let cell = sender.superview?.superview?.superview as? Join5CaptureCellTableViewCell{
            let indexPath = weakSelf?.tableView.indexPath(for: cell)
            weakSelf?.viewModel.images[(indexPath?.row)!].1 = text
        }
    }
}

extension Join5ViewController: Join5AddCaptureTableViewCellDelegate {
    func addCaptureCell() {
        tableView.beginUpdates()
        viewModel.addNullImage()
        tableView.insertRows(at: viewModel.indexPathForAddNullImage(), with: .fade)
        tableView.endUpdates()
        
        if viewModel.checkImagesIsMax() {
            tableView.beginUpdates()
            viewModel.isAddCaptureCellAvaible = false
            tableView.deleteRows(at: [IndexPath.init(row: 0, section: 2)], with: .fade)
            tableView.endUpdates()
        }
    }
}

extension Join5ViewController: Join5FinishTableViewCellDelegate {
    func completeInput() {
        
        self.showLoading()
        viewModel.insertUser { (isSuccess) in
            self.stopLoading()
            if isSuccess {
                let userLogin = UserLogin()
                userLogin.id = self.viewModel.userJoin?.id
                userLogin.password = self.viewModel.userJoin?.password
                userLogin.isWaitingAccept = 1
                Context.saveUserLogin(userLogin: userLogin)
                
                let popup = Join5SuccessPopup.instanceFromNib()
                popup.show()
                popup.okAction = {
                    let join6VC = self.storyboard?.instantiateViewController(withIdentifier: "Join6ViewController")
                    self.navigationController?.pushViewController(join6VC!, animated: true)
                }
            }else{
                self.view.makeToast("서버 오류", duration: 3, position: .center)
            }
        }

    }
}

extension Join5ViewController : UIImagePickerControllerDelegate {
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

extension Join5ViewController : TOCropViewControllerDelegate {
    func pickImage(isLibrary: Bool) {
        let picker = UIImagePickerController()
        picker.sourceType = isLibrary ?  .photoLibrary : .camera
        picker.allowsEditing = false;
        picker.delegate = self;
        self.present(picker, animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropToImage image: UIImage, rect cropRect: CGRect, angle: Int) {
        let thumbnail = UIImage().resizeImage(image: image, targetSize: CGSize(width: 500, height: 500))
        viewModel.updateImage(image: thumbnail)
        self.tableView.reloadRows(at: [IndexPath.init(row: viewModel.lastIndexSetImage, section: 1)], with: .fade)
        self.viewModel.checkOkButtonEnable()
        self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 3)], with: .fade)
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true, completion: {
            
        })
    }
}
