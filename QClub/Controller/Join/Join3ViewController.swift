//
//  Join3ViewController.swift
//  QClub
//
//  Created by SMR on 10/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
/*
 Join3, Page 10 in StoryBoard
 */
class Join3ViewController: BaseViewController {

    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var okBTN: UIButton!
    @IBOutlet weak var lbTop: UILabel!
    
    var viewModel = Join3ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.showLoading()
        viewModel.getStylesInfoList {
            self.stopLoading()
            self.collectionView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "회원가입", image: "ic_navigation_join")
    }

    func setupUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        
        //setup color for LBtop
        
        let myMutableString = NSMutableAttributedString(string: lbTop.text!, attributes: [NSFontAttributeName:UIFont(name: "NanumSquareOTFR", size: 14.0)!])
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: textHightLight ?? .black, range: NSRange(location:16,length:4))
        // set label Attribute
        lbTop.attributedText = myMutableString
    }
    
    func changeOkbutton() {
        okBTN.setTitleColor(viewModel.selectedCells.count >= 5 ? buttonActiveColor : buttonInActiveColor, for: .normal)
        okBTN.borderColor = viewModel.selectedCells.count >= 5 ? buttonActiveColor : buttonInActiveColor
        okBTN.isUserInteractionEnabled = viewModel.selectedCells.count >= 5
    }

    @IBAction func okTUI(_ sender: Any) {
        self.navigationController?.pushViewController(viewModel.join4VC(), animated: true)
    }
}

extension Join3ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "join3SelectCell", for: indexPath) as! Join3CollectionViewCell
        cell.lbTitle.text = viewModel.titleForCell(indexPath: indexPath)
        cell.configBackgroundForSelected(isSelected: viewModel.indexPathIsSelected(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.selectedCells.count >= 5 {
            collectionView.deselectItem(at: indexPath, animated: false)
            return
        }
        let cell = collectionView.cellForItem(at: indexPath) as! Join3CollectionViewCell
        cell.configBackgroundForSelected(isSelected: true)
        viewModel.selectedCells.insert(indexPath.row)
        changeOkbutton()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! Join3CollectionViewCell
        cell.configBackgroundForSelected(isSelected: false)
        viewModel.selectedCells.remove(indexPath.row)
        changeOkbutton()
    }
    
}

extension Join3ViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.nuberOfItem()
    }
}

extension Join3ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/4 , height: self.collectionView.frame.size.width/8)
    }
}
