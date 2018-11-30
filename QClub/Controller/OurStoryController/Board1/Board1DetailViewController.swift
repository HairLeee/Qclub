//
//  Board1DetailViewController.swift
//  QClub
//
//  Created by Dreamup on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher
class Board1DetailViewController: BaseViewController {
    
    var pagerView: FSPagerView!
    var mOurStorySeq = 0
    var userSeq = 0
    var mBoard = Board()
    @IBOutlet weak var pageViewContainer: UIView!
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    @IBOutlet var lbDesctiption: UILabel!
    
    @IBOutlet var lbTitle: UILabel!
    
    @IBOutlet var lbDes: UIButton!
    
    @IBOutlet var lbNickName: UILabel!
    
    @IBOutlet var lbDate: UILabel!
    
    @IBOutlet var imvAva: UIImageView!
    
    var urlList = [String]()
    
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        
        pagerView = FSPagerView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * 9 / 16))
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.transformer = FSPagerViewTransformer(type: .depth)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pageViewContainer.addSubview(pagerView)
        
        pageControl.numberOfPages = 0
        
    }
    
    func getData(){
        
        self.showLoading()
        MenuService.getDetailBoard(pOurStorySeq: mOurStorySeq, completion: { (response) in
            self.stopLoading()
            self.mBoard = response.data as! Board
            self.updateLayoutAfterGettingData()
        }) { (error) in
            self.stopLoading()
        }
    }
    
    func updateLayoutAfterGettingData(){
        
        urlList = mBoard.ourstoryPicture.map{$0.storyPicture}
        lbTitle.text = mBoard.title
        lbDesctiption.text = mBoard.descriptionOurStory
        lbNickName.text = mBoard.nickname
        lbDate.text = mBoard.createDate
        imvAva?.kf.setImage(with: URL(string: mBoard.profilePicture))
        pagerView.reloadData()
        pageControl.numberOfPages = urlList.count
        
    }
    
    
    override func configNavigationBar() {
        
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            
        }
        navigationView.config(title: "다솔 속마음", image: "board1_detail_header_icon")
        
    }
    
    
    
    @IBOutlet weak var btnDetailProfileAction: UIButton!
    
    @IBAction func btnDetailProfile(_ sender: Any) {
        self.showLoading()
        RelationService.getHeartCount(completion: {[ weak self] (response) in
            
            guard let _self = self else { return }
            
            _self.stopLoading()
            
            if let heartNumber = response.data as? Int {
                let profleDetailAleart = BoardDetailDialog.instanceFromNib(typeOfDialog: "BOARD_DETAIL" ,numberOfHeart: heartNumber)
                profleDetailAleart.show()
                profleDetailAleart.action = {
                    profleDetailAleart.hide()
                    
                    _self.doAcceptToRemoveHeart()
                    
                    
                }
            }
        }) { (error) in
            self.stopLoading()
        }
        
    }
    
    func doAcceptToRemoveHeart(){
        self.showLoading()
        MenuService.postDetailBoardProfile(completion: { (response) in
            self.stopLoading()
            if response.code == 0 {
                Utils.gotoUserVC(viewController: self, userSeq: self.userSeq)
            } else {
                Utils.gotoStore(viewController: self)
            }
            
            
        }) { (error) in
            
        }
    }
    
    
    @IBAction func btnRemove(_ sender: Any) {
        
        let removeDialog = AlertQClub.instanceFromNib(content: "해당 글을 삭제하시겠습니까?", image: "ic_recyclebin_popup.png")
        
        removeDialog.show()
        
        removeDialog.action2 = {
            self.showLoading()
            MenuService.removeBoard(ourStorySeq: self.mOurStorySeq, completion: { (response) in
                
                
                self.navigationController?.popViewController(animated: true)
                self.stopLoading()
                
            }, fail: { (error) in
                
            })
        }
    }
}

extension Board1DetailViewController : FSPagerViewDataSource,FSPagerViewDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return urlList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.contentMode = .scaleAspectFill
        
        cell.imageView?.kf.setImage(with: URL(string: urlList[index]))
        
        return cell
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        
    }
    
}
