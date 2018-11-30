//
//  StoreAfterPromotionViewController.swift
//  QClub
//
//  Created by Dreamup on 11/6/17.
//  Copyright © 2017 Dream. All rights reserved.
//
//Page 139 in the Storyboard
import UIKit
import StoreKit

class StoreAfterPromotionViewController: BaseViewController {
    
    var productsRequest:SKProductsRequest?
    var validProducts:[SKProduct] = []

    @IBOutlet var tbView: UITableView!
    @IBOutlet var navigationView: NavigationBarQClub!
    struct cellID {
        static let storePromotionCellId = "storePromotionCellId"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
        fetchAvailableProducts()
    }
    
    func setupUI(){
        
        tbView.delegate = self
        tbView.dataSource = self
        tbView.register(UINib.init(nibName: "StorePromotionTableViewCell", bundle: nil), forCellReuseIdentifier: cellID.storePromotionCellId)
    }
    
    var storeList = [Store]()
    func getData(){
        self.showLoading()
        MenuService.getStore(offset: 1, completion: { (response) in
            self.storeList = response.data as! [Store]
            self.tbView.reloadData()
            self.stopLoading()
        }) { (error) in
             self.stopLoading()
        }
    }
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "스토어", image: "store_header_icon")
    }
    
}


extension StoreAfterPromotionViewController:UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID.storePromotionCellId, for: indexPath) as! StorePromotionTableViewCell
        
        cell.bidingData(pStore: storeList[indexPath.row], index : indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        purchaseProductIndex(index: indexPath.row)
    }
    
}


// inapp purchase
extension StoreAfterPromotionViewController : SKProductsRequestDelegate,SKPaymentTransactionObserver{
    func fetchAvailableProducts(){
        self.showLoading()
        let productIds:[String] = ["com.soulFactory.QClub_002",
                                   "com.soulFactory.QClub_004",
                                   "com.soulFactory.QClub_006",
                                   "com.soulFactory.QClub_008",
                                   "com.soulFactory.QClub_010",
                                   "com.soulFactory.QClub_012",
                                   "com.soulFactory.QClub_014",
                                   "com.soulFactory.QClub_016"]
        let productIdentifiers = Set(productIds)
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
        
    }
    func canMakePurchases() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions{
            switch transaction.transactionState {
            case .purchasing:
                self.showLoading()
                print("purchasing")
                break
            case .purchased:
                self.requestAddItem()
                SKPaymentQueue.default().finishTransaction(transaction)
                self.stopLoading()
                print("purchased")
                break
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("restored")
                break
            case .failed:
                self.stopLoading()
                print("Purchase failed")
                break
            default:
                break
            }
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.stopLoading()
        if response.products.count > 0 {
            self.validProducts = response.products
            for validProduct in self.validProducts{
                print("product id : \(validProduct.productIdentifier)")
                print("product price : \(validProduct.price)")
            }
        }
    }
    
    func purchaseProductIndex(index:Int){
        if validProducts.count > index && canMakePurchases(){
            self.showLoading()
            let product = validProducts[index]
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            return
        }
        
        let alertVC = UIAlertController(title: "", message: "Purchases are disabled in your device", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    //call api to add items after purchased
    func requestAddItem(){
        
    }
    
}
