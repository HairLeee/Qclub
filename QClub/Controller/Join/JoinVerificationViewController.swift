//
//  JoinVerificationViewController.swift
//  QClub
//
//  Created by TuanNM on 11/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import WebKit

protocol JoinVerificationControllerDelegate :class {
   func didVeritySuccess()
}

/*
 Page 8 in StoryBoard
 */


class JoinVerificationViewController: UIViewController {

    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var webContainerView: UIView!
    
    weak var delegate:JoinVerificationControllerDelegate?
    
    var mainWebView: WKWebView!
    var originWeb: WKWebView!
    
    var urlStr:String = "http://icue.iptime.org:9991/identity/request.jsp"
    var successURl = "http://icue.iptime.org:9991/identity/success.jsp"
    var failURL = "http://icue.iptime.org:9991/identity/fail.jsp"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationBar.config(title: "본인확인", image: "ic_navigation_join")
        
        let myURL = URL(string: "http://icue.iptime.org:9991/identity/request.jsp")
        let myRequest = URLRequest(url: myURL!)
        originWeb.load(myRequest)
        webContainerView.addSubview(originWeb)
        
        self.showLoading()
        
    }
    
    override func loadView() {
        super.loadView()
        
        let pref = WKPreferences()
        pref.javaScriptEnabled = true
        pref.javaScriptCanOpenWindowsAutomatically = true
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences = pref
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 60)
        
        originWeb = WKWebView(frame: frame, configuration: webConfiguration)
        originWeb.navigationDelegate = self
        originWeb.uiDelegate = self
        
        mainWebView = WKWebView(frame: frame, configuration: webConfiguration)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension JoinVerificationViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url?.description {
            if url == successURl{
                self.delegate?.didVeritySuccess()
            }else if url == failURL{
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.stopLoading()
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if let urlStr = webView.url?.description{
            if urlStr.contains("m=auth_mobile_main"){
                self.stopLoading()
                let url = URL(string: urlStr)!
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
                print("reload page \(urlStr)")
                
                mainWebView.navigationDelegate = self
                mainWebView.uiDelegate = self
                mainWebView.load(request)
                webContainerView.addSubview(mainWebView)
                
                originWeb.uiDelegate = nil
                originWeb.navigationDelegate = nil
                originWeb.removeFromSuperview()
                originWeb = nil
            }
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        completionHandler(defaultText)
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential,URLCredential(trust:challenge.protectionSpace.serverTrust!))
    }
}

extension JoinVerificationViewController:WKUIDelegate{
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        NSLog("=> Create a new webView \(String(describing: navigationAction.request.url))")
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.backgroundColor = UIColor.red
        self.originWeb = webView
        return webView
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    
}
