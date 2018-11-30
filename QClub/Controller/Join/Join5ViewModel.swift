//
//  Join5ViewModel.swift
//  QClub
//
//  Created by SMR on 11/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class Join5ViewModel: NSObject {

    var images = [(UIImage?, String?)]()
    var isAddCaptureCellAvaible = true
    var isAvaibleComplete = false
    var lastIndexSetImage = 0
    
    var userJoin : UserJoin?
    
    let topCellId = "Join5TopCell"
    let captureCellId = "Join5CaptureCell"
    let addCaptureCellId = "Join5AddCaptureCell"
    let finishCellId = "Join5FinishCell"

    
    override init() {
        super.init()
        images.append((nil, nil))
    }
    
    func checkOkButtonEnable() {
        var i = 0;
        for (image, _) in self.images {
            if let _ = image {
                i += 1
            }
        }
        self.isAvaibleComplete = (i >= 5)
    }
    
    func insertUser(complete : @escaping(_ isSuccess : Bool) -> ()) {
        if let user = self.userJoin {
            makeDataForUserObject()
            AuthService.register(user: user, completion: { (response) in
                complete(true)
            }) { (error) in
                complete(false)
                print(error)
            }
        }
    }
    
    func makeDataForUserObject() {
        var imageParam = [UserImage]()
        for i in 0..<self.images.count {
            if let imageUnWrap = images[i].0 {
                imageParam.append(UserImage.init(descriptionString: images[i].1, orderSeq: i, profilePicture: imageUnWrap))
            }
        }
        userJoin?.profilePictures = imageParam
    }
    
    func numberOfImageRow() -> Int {
        return images.count
    }
    
    func numberOfAddCaptureCellRow() -> Int {
        return self.isAddCaptureCellAvaible ? 1 : 0
    }
    
    func dataImageForIndexpath(indexPath : IndexPath) -> (UIImage?, String?) {
        return images[indexPath.row]
    }
    
    func addNullImage() {
        images.append((nil, nil))
    }
    
    func indexPathForAddNullImage() -> [IndexPath] {
        return [IndexPath.init(row: images.count - 1, section: 1)]
    }
    
    func checkImagesIsMax() -> Bool {
        return images.count >= 10
    }
    
    func imagesIsNearMax() -> Bool {
        return images.count == 9
    }
    
    func updateImage(image: UIImage) {
        if let index = self.lastIndexEmty() {
            self.images[index].0 = image
        }
    }
    
    func lastIndexEmty() -> Int? {
        for i in 0...(images.count - 1) {
            if let _ = images[i].0 {

            } else {
                lastIndexSetImage = i
                return i
            }
        }
        return nil
    }
    
    
}
