//
//  UserCharmViewController.swift
//  QClub
//
//  Created by SMR on 10/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import Charts

/*
 User_charm, Page 38 in StoryBoard
 */

class UserCharmViewController: BaseViewController {

    @IBOutlet weak var btnShowInfo: UIButton!
    @IBOutlet weak var vChart3: UIView!
    @IBOutlet weak var vChart1: UIView!
    @IBOutlet weak var barChart2: BarChartView!
    @IBOutlet weak var pieChart3: PieChartView!
    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var lb1Chart2Value: UILabel!
    @IBOutlet weak var lb2Chart2: UILabel!
    @IBOutlet weak var lb2Chart2Value: UILabel!
    @IBOutlet weak var lb3Chart2Value: UILabel!
    @IBOutlet weak var lb4Chart2: UILabel!
    @IBOutlet weak var lb4Chart2Value: UILabel!
    @IBOutlet weak var lbRankSmall: UILabel!
    @IBOutlet weak var lbRankLarge: UILabel!
    @IBOutlet weak var imgRank: UIImageView!
    @IBOutlet weak var lbChart1Caption: UILabel!
    @IBOutlet weak var lbChart2AvgScore: UILabel!
    @IBOutlet weak var lbChart2AvgMale: UILabel!
    @IBOutlet weak var lbChart2AvgMaleAge: UILabel!
    @IBOutlet weak var lbChart2AvgFeMale: UILabel!
    @IBOutlet weak var lbChart2AvgFemaleAge: UILabel!
    @IBOutlet weak var lbChart2Age1: UILabel!
    @IBOutlet weak var lbChart2Age2: UILabel!
    @IBOutlet weak var img_bgFireWork: UIImageView!
    @IBOutlet weak var lbChart3Content: UILabel!
    
    var bubbleView : BubbleView!
    
    
    var userSeq: Int?
    var nickName : String?
    
    var attractive : AttractiveObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "회원가입", image: "ic_navigation_join")
    }
    
    func getData() {
        self.showLoading()
        if let userSeq = self.userSeq {
            ProfileService.getProfileAttractive(userSeq: userSeq, completion: { (response) in
                if let data = response.data as? AttractiveObject {
                    self.attractive = data
                    self.stopLoading()
                    self.reloadData()
                }
            }, fail: { (error) in
                self.stopLoading()
            })
        } else {
            ProfileService.getMyAttractive(completion: { (response) in
                if let data = response.data as? AttractiveObject {
                    self.attractive = data
                    self.stopLoading()
                    self.reloadData()
                }
            }, fail: { (error) in
                self.stopLoading()
            })
        }
    }
    
    func reloadData() {
        if let data = self.attractive {
            if let rank = data.rank {
                if let ratio = rank.charmRank {
                    if ratio <= 5.0 {
                        imgRank.image = UIImage.init(named: "ic_chart1_perfect")
                        lbRankLarge.text = "5%"
                        lbRankSmall.text = "상위5%"
                        lbChart1Caption.text = "멋찌셔요~ 님은 분명 매력덩어리~"
                        img_bgFireWork.isHidden = false
                    } else if ratio <= 10.0 {
                        imgRank.image = UIImage.init(named: "ic_chart1_excilent")
                        lbRankLarge.text = "10%"
                        lbRankSmall.text = "상위10%"
                        lbChart1Caption.text = "곧 상위 5%에 진입하실 수 있어요~\n홧팅! 빠샤! 으랏차차!!"
                    } else if ratio <= 20.0 {
                        imgRank.image = UIImage.init(named: "ic_chart1_good")
                        lbRankLarge.text = "20%"
                        lbRankSmall.text = "상위20%"
                        lbChart1Caption.text = "목표! 상위 10%! Go Go!"
                    } else if ratio <= 50.0 {
                        imgRank.image = UIImage.init(named: "ic_chart1_nodbad")
                        lbRankLarge.text = "20~50%"
                        lbRankSmall.text = "상위20~50%"
                        lbChart1Caption.text = "목표! 상위 20%!\n매력적인 프사가 필요한 시점!"
                    } else {
                        imgRank.image = UIImage.init(named: "ic_chart1_cheerup")
                        lbRankLarge.text = "50% 이하"
                        lbRankSmall.text = "50% 이하"
                        lbChart1Caption.text = "포기하지 마세요!\n프로필을 조금만 가꾸어도 매력도가 상승합니다."
                    }
                }
            }
            
            if let lik = data.lik {
                var yValsMan = [BarChartDataEntry]()
                yValsMan.append(BarChartDataEntry.init(x: 1, y: Double(lik.s1 ?? 0)))
                yValsMan.append(BarChartDataEntry.init(x: 2, y: Double(lik.s2 ?? 0)))
                yValsMan.append(BarChartDataEntry.init(x: 3, y: Double(lik.s3 ?? 0)))
                yValsMan.append(BarChartDataEntry.init(x: 4, y: Double(lik.s4 ?? 0)))
                yValsMan.append(BarChartDataEntry.init(x: 5, y: Double(lik.s5 ?? 0)))
                yValsMan.append(BarChartDataEntry.init(x: 6, y: Double(lik.s6 ?? 0)))
                yValsMan.append(BarChartDataEntry.init(x: 7, y: Double(lik.s7 ?? 0)))
                yValsMan.append(BarChartDataEntry.init(x: 8, y: Double(lik.s8 ?? 0)))
                yValsMan.append(BarChartDataEntry.init(x: 9, y: Double(lik.s9 ?? 0)))
                yValsMan.append(BarChartDataEntry.init(x: 10, y: Double(lik.s10 ?? 0)))
                
                setupChart2(data : yValsMan)
                if let myAvg = lik.myAvg {
                    lbChart2AvgScore.text = "\(myAvg)점"
                }
                if let maleAvg = lik.maleAvg {
                    lbChart2AvgMale.text = "\(maleAvg)점"
                }
                if let maleAvgAge = lik.maleAgeAvg {
                    lbChart2AvgMaleAge.text = "\(maleAvgAge)점"
                }
                if let femaleAvg = lik.femaleAvg {
                    lbChart2AvgFeMale.text = "\(femaleAvg)점"
                }
                if let femaleAvgAge = lik.femaleAgeAvg {
                    lbChart2AvgFemaleAge.text = "\(femaleAvgAge)점"
                }
                if let age1 = lik.ageRange {
                    lbChart2Age1.text = "\(age1)대 남성 "
                    lbChart2Age2.text = "\(age1)대 여성 "
                }

            }
            
            if let impressions = data.impressions {
                var dataEntries = [PieChartDataEntry]()
                let impressionSorted = impressions.sorted{$0.percentage! > $1.percentage!}
                var text = (nickName ?? "") + "님은"
                var hightLightTextCount = 0
                for i in 0..<impressionSorted.count {
                    dataEntries.append(PieChartDataEntry.init(value: Double(impressionSorted[i].percentage ?? 0) , label: impressionSorted[i].name ?? ""))
                    if i < 3 {
                        text = text + (impressionSorted[i].name ?? "") + (i < 2 ? "," : "")
                    }
                }
                hightLightTextCount = text.count
                text = text + "의 분 일것 같아요"
                let myMutableString = NSMutableAttributedString(string: text, attributes: [NSFontAttributeName:UIFont(name: "NanumSquareOTFR", size: 14.0)!])
                myMutableString.addAttribute(NSForegroundColorAttributeName, value: textHightLight ?? .red, range: NSRange(location:(((nickName?.count) ?? 0) + 2),length:(hightLightTextCount - (((nickName?.count) ?? 0) + 2))))
                lbChart3Content.attributedText = myMutableString
                
                
                setupChart3(dataEntries: dataEntries)
                
            }
        }
    }
    
    @IBAction func showMoreInfo(_ sender: Any) {
        if self.bubbleView !=  nil && self.bubbleView?.superview != nil {
            self.bubbleView?.removeFromSuperview()
            self.bubbleView = nil
            return
        }
        
        self.bubbleView = BubbleView.loadFromXib()
        self.bubbleView?.autoDissmiss = true
        self.bubbleView?.timeAutoDissmiss = 5
        let originY =  btnShowInfo.frame.origin.y + 15
        let tipX = btnShowInfo.frame.origin.x + 10
        
        self.bubbleView!.setTipX(tipX: tipX)
        self.bubbleView!.frame = CGRect(x: 5, y: originY, width: SCREEN_WIDTH - 10, height: 200)
        self.bubbleView!.bubbleContentLb.text = "“매력도순위”는 오늘의 인연 매칭을, 호감도, 인연매칭율,프로필작성량, 프로필 평가점수, 큐클럽, 회원등급 등을평가하여 따라 3주 단위로 산출됩니다."
        self.vChart1.addSubview(self.bubbleView!)
    }
    
    func setupChart2(data :[BarChartDataEntry]) {
        
        barChart2.drawBarShadowEnabled = false;
        barChart2.drawValueAboveBarEnabled = true;
        
        barChart2.maxVisibleCount = 60;
        barChart2.chartDescription?.enabled = false
        barChart2.legend.enabled = false
        
        let xAxis = barChart2.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = UIFont.systemFont(ofSize: 10.0)
        xAxis.drawGridLinesEnabled = false;
        xAxis.granularity = 1.0
        xAxis.labelCount = 7
        
//        let legend = barChart2.legend;
//        legend.horizontalAlignment = .left;
//        legend.verticalAlignment = .bottom;
//        legend.orientation = .horizontal;
//        legend.drawInside = false;
//        legend.form = .square;
//        legend.formSize = 9.0;
//        legend.font = UIFont.init(name: "HelveticaNeue-Light", size: 11.0)!
//        legend.xEntrySpace = 4.0;

        let set = BarChartDataSet.init(values: data, label: nil)
        set.setColor(UIColor.init(hexString: "#3158a8")!)
        set.drawIconsEnabled = false
        set.drawValuesEnabled = false
        
        let data = BarChartData.init(dataSets: [set])
        data.setValueFont(UIFont.init(name: "HelveticaNeue-Light", size: 10))
        
        data.barWidth = 0.9
        barChart2.data = data

    }
    
    func setupChart3(dataEntries : [PieChartDataEntry]) {
        pieChart3.legend.enabled = false
        pieChart3.chartDescription?.enabled = false;
//        pieChart3.delegate = self
        
        pieChart3.setExtraOffsets(left: 0.0, top: 0, right: 0.0, bottom: 0)
        pieChart3.animate(yAxisDuration: 1.5, easingOption: ChartEasingOption.easeOutBack)
        

        let dataSet = PieChartDataSet.init(values: dataEntries, label: "Chart 3")
        dataSet.sliceSpace = 5.0
        
        var colors = [UIColor]()
        colors.append(UIColor.init(hexString: "#e76b23")!)
        colors.append(UIColor.init(hexString: "#ff912d")!)
        colors.append(UIColor.init(hexString: "#ffc043")!)
        colors.append(UIColor.init(hexString: "#ffe347")!)
        colors.append(UIColor.init(hexString: "#ddc75f")!)
        colors.append(UIColor.init(hexString: "#aaa079")!)
        colors.append(UIColor.init(hexString: "#868373")!)

        dataSet.colors = colors;
        
        dataSet.valueLinePart1OffsetPercentage = 0.8;
        dataSet.valueLinePart1Length = 0.2;
        dataSet.valueLinePart2Length = 0.4;
        dataSet.yValuePosition = .outsideSlice;
        dataSet.drawValuesEnabled = false
        
        let pieChartData = PieChartData.init(dataSets: [dataSet])
        
//        let pFormatter = NumberFormatter.init()
//        pFormatter.numberStyle = .none
//        pFormatter.maximumFractionDigits = 1
//        pFormatter.multiplier = 1.0
//        pFormatter.percentSymbol = " %"
//
//        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
//        pieChartData.setValueFont(UIFont.init(name: "HelveticaNeue-Light", size: 11.0))
        pieChartData.setValueTextColor(UIColor.black)
        pieChart3.data = pieChartData
        pieChart3.highlightValue(nil)
    }

}
