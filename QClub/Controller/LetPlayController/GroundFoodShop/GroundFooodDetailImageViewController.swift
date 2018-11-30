//
//  GroundFooodDetailImageViewController.swift
//  QClub
//
//  Created by Dreamup on 12/19/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundFooodDetailImageViewController: UIViewController {

    
    
    @IBOutlet var imvDetailOutlet: UIImageView!
    var imageUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        imvDetailOutlet.kf.setImage(with: URL(string : imageUrl))
    }



}
