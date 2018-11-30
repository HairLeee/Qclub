//
//  Board1ViewController.swift
//  QClub
//
//  Created by Dreamup on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class Board1ViewController: BaseViewController {
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    
    @IBOutlet weak var tbView: UITableView!
    
    var mStoryDetail = 1
    var boardName = ""
    
    struct cellId {
        static let board1Cell = "board1Cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        setupUI()
        
    }
    
    func setupUI(){
        tbView.delegate = self
        tbView.dataSource = self
        tbView.register(UINib.init(nibName: "Board1TableViewCell", bundle: nil), forCellReuseIdentifier: cellId.board1Cell)
    }
    
    var OurStories = [Board]()
    var mSearhBoard = [Board]()
    func getData(){
        self.showLoading()
        MenuService.getOurStory(storyDetail: mStoryDetail, title: "", offset: 0, completion: { (response) in
            
            
            if let pOurStory = response.data as? [Board] {
                
                self.OurStories = pOurStory
                self.mSearhBoard = pOurStory
                self.tbView.reloadData()
                
            }
            self.stopLoading()
            
            
        }) { (error) in
            self.stopLoading()
        }
        
        
    }
    
    
    
    @IBOutlet var edittingSearch: UITextField!
    @IBAction func edittingChangeAction(_ sender: Any) {
        
        
        print("Change !! \(edittingSearch.text)")
        
        let text = edittingSearch.text
        if text == "" {
            mSearhBoard = OurStories
        } else {
            mSearhBoard = OurStories.filter({$0.title.lowercased().contains(text!) })
        }
        
        self.tbView.reloadData()
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override  func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            
        }
        navigationView.config(title: boardName, image: "board1_detail_header_icon")
    }
    
    
    @IBAction func btnBoardNWriteAction(_ sender: Any) {
        
        let board1NWrite = Board1NWriteViewController.init(nibName: "Board1NWriteViewController", bundle: nil)
        board1NWrite.mStoryDetail = mStoryDetail
        navigationController?.pushViewController(board1NWrite, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("viewDidAppear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    
    deinit {
        print("deinit")
    }
    
    
}

extension Board1ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mSearhBoard.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId.board1Cell, for: indexPath) as! Board1TableViewCell
        cell.bidingData(pBoard: mSearhBoard[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let board1DetailVC = Board1DetailViewController.init(nibName: "Board1DetailViewController", bundle: nil)
        board1DetailVC.mOurStorySeq = mSearhBoard[indexPath.row].ourStorySeq
        board1DetailVC.userSeq = mSearhBoard[indexPath.row].userSeq
        navigationController?.pushViewController(board1DetailVC, animated: true)
        
        
    }
    
    
    
}



