//
//  CandyViewController.swift
//  QClub
//
//  Created by SMR on 11/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

/*
 Candy, Page 55 in StoryBoard
 */

class CandyViewController: UIViewController {

    @IBOutlet weak var lbDetail: UILabel!
    @IBOutlet weak var scrollviewCandy: UIScrollView!
    
    var freeCandyRegister : (() -> ())?
    var freeCandySearch : (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUIfreeCandy()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUIfreeCandy() {
        lbDetail.attributedText = Utils.getAtributedStringWithLinespace(text: "우리는 모두 외롭습니다.\n복잡한 지하철 속에서, 퇴근길 버스 안에서도 우리는 외로워지곤 합니다.\n지친 나에게...\n누군가의 따뜻한 말 한마디, 동감 그리고 경청이 큰 힘이 됩니다.\n'내 안의 캔디'를 통해서\n48시간 동안 나만의 캔디와 대화를 나눌 수 있습니다.\n나의 소소한 일상을 함께 나누는 나만의 캔디..\n바로, '내 안의 캔디'입니다.", lineSpace: 5, alignment: .left)
        self.scrollviewCandy.backgroundColor = UIColor.white
    }
    
    @IBAction func searchTUI(_ sender: Any) {
        freeCandySearch?()
    }
    
    @IBAction func registerTUI(_ sender: Any) {
        freeCandyRegister?()
    }
    

}
