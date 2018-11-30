//
//  LocationSearchingViewController.swift
//  QClub
//
//  Created by TuanNM on 11/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class LocationSearchingViewController: UIViewController ,UITextViewDelegate{

    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var lineHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchbtn: UIButton!
    
    @IBOutlet weak var searchTv: UITextView!
    var arrResult:[String] = []
    var didSelectAddress: ((_ address:String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTv.isUserInteractionEnabled = true
        searchTv.isEditable = true
        tbView.register(UINib(nibName: "LocationSearchingCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        navigationBar.config(title: "주소검색", image: "ic_search.png", rightBtnImage: "ic_close.png")
        navigationBar.hideBackButton()
        searchTv.delegate = self
        lineHeightConstraint.constant = 0.5
        searchbtn.isUserInteractionEnabled = false
        tbView.rowHeight = UITableViewAutomaticDimension
        tbView.estimatedRowHeight = 45
        tbView.isHidden = true
        
        navigationBar.rightAction = {
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTv.becomeFirstResponder()
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        CommonService.getRoadAddress(keyword: searchTv.text, completion: { (response) in
            guard let results = response as? [String] else{return}
            self.arrResult = results
            self.tbView.isHidden = self.arrResult.count > 0 ? false : true
            self.tbView.reloadData()
        }) { (error) in
            print("getRoadAddress error \(error)")
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.text.count > 0 {
            searchbtn.layer.borderColor = UIColor.orange.cgColor
            searchbtn.isUserInteractionEnabled = true
        }else{
            searchbtn.layer.borderColor = UIColor.lightGray.cgColor
            searchbtn.isUserInteractionEnabled = false
        }
    }
    
}


extension LocationSearchingViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "cell") as! LocationSearchingCell
        let address = arrResult[indexPath.row]
        cell.setTitle(title: "\(indexPath.row)", content: address)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let address = arrResult[indexPath.row]
        didSelectAddress?(address)
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
    }
    
}
