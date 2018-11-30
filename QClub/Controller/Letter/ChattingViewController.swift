//
//  ChattingViewController.swift
//  QClub
//
//  Created by SMR on 11/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import SendBirdSDK
import MobileCoreServices
import HTMLKit
import AVKit
import AVFoundation
import IQKeyboardManagerSwift

class ChattingViewController: BaseViewController {
    
    @IBOutlet weak var chattingView: ChattingView!
    @IBOutlet weak var chatViewBottom: NSLayoutConstraint!
    var groupChannel: SBDGroupChannel?
    private var messageQuery: SBDPreviousMessageListQuery!
    private var delegateIdentifier: String!
    private var hasNext: Bool = true
    var refreshInViewDidAppear: Bool = true
    private var isLoading: Bool = false
    var keyboardShown: Bool = false
    
    private var minMessageTimestamp: Int64 = Int64.max
    private var dumpedMessages: [SBDBaseMessage] = []
    var cachedMessage: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func updateChannel(channel: SBDGroupChannel) {
        self.groupChannel = channel
        setupUI()
        viewWillAppear(false)
        viewDidAppear(false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.refreshInViewDidAppear {
            self.minMessageTimestamp = Int64.max
            self.chattingView.initChattingView()
            self.chattingView.delegate = self
        }
        IQKeyboardManager.sharedManager().enable = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.refreshInViewDidAppear {
            if self.dumpedMessages.count > 0 {
                self.chattingView.messages.append(contentsOf: self.dumpedMessages)
                
                self.chattingView.chattingTableView.reloadData()
                self.chattingView.chattingTableView.layoutIfNeeded()
                
                let viewHeight = UIScreen.main.bounds.size.height - 74 - self.chattingView.inputContainerViewHeight.constant - 10
                let contentSize = self.chattingView.chattingTableView.contentSize
                
                if contentSize.height > viewHeight {
                    let newContentOffset = CGPoint(x: 0, y: contentSize.height - viewHeight)
                    self.chattingView.chattingTableView.setContentOffset(newContentOffset, animated: false)
                }
                
                self.cachedMessage = true
                self.loadPreviousMessage(initial: true)
                
                return
            }
            else {
                self.cachedMessage = false
                self.minMessageTimestamp = Int64.max
                self.loadPreviousMessage(initial: true)
            }
        }
        
        self.refreshInViewDidAppear = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let channel = groupChannel {
            UtilsSendBird.dumpMessages(messages: self.chattingView.messages, resendableMessages: self.chattingView.resendableMessages, resendableFileData: self.chattingView.resendableFileData, preSendMessages: self.chattingView.preSendMessages, channelUrl: channel.channelUrl)
        }
        IQKeyboardManager.sharedManager().enable = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkAndSendFirstResponse() {
        let myId : Int = Context.getUserLogin()?.userSeq ?? 0
        if groupChannel?.getInviter()?.userId != "\(myId)" && groupChannel?.name == Constants.ChannelName.Candy {
            
            groupChannel?.getMetaData(withKeys: [Constants.SendBirdMetaData.ResponseDate], completionHandler: { (response, error) in
                if let data = response {
                    if let _ = (data[Constants.SendBirdMetaData.ResponseDate] as? String){
                        return
                    }
                    self.groupChannel?.createMetaData([Constants.SendBirdMetaData.ResponseDate : String(Date().timeIntervalSince1970)], completionHandler: { (response, error) in
                        
                    })
                    self.groupChannel?.getMetaData(withKeys: [Constants.SendBirdMetaData.ListSeq], completionHandler: { (response, error) in
                        if let data = response {
                            if let seq = data[Constants.SendBirdMetaData.ListSeq] {
                                // send candy response
                                CandyService.candyResponse(candyListSeq: Int(seq as! String)!, completion: { (response) in
                                    
                                }, fail: { (error) in
                                    
                                })
                            }
                        }
                    })

                } else {

                }
            })
        }
    }
    
    
    func setupUI() {
        self.delegateIdentifier = self.description
        SBDMain.add(self as SBDChannelDelegate, identifier: self.delegateIdentifier)
        SBDMain.add(self as SBDConnectionDelegate, identifier: self.delegateIdentifier)
        
        self.chattingView.sendButton.addTarget(self, action: #selector(sendMessage), for: UIControlEvents.touchUpInside)
        
        self.hasNext = true
        self.refreshInViewDidAppear = true
        self.isLoading = false
        
        if let channel = groupChannel {
            self.dumpedMessages = UtilsSendBird.loadMessagesInChannel(channelUrl: channel.channelUrl)
        }
        
        self.addKeyboardNotification()
    }

    private func sendMessageWithReplacement(replacement: OutgoingGeneralUrlPreviewTempModel) {
        if let channel = groupChannel {
            let preSendMessage = channel.sendUserMessage(replacement.message, data: "", customType:"", targetLanguages: ["ar", "de", "fr", "nl", "ja", "ko", "pt", "es", "zh-CHS"]) { (userMessage, error) in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(150), execute: {
                    let preSendMessage = self.chattingView.preSendMessages[(userMessage?.requestId)!] as! SBDUserMessage
                    self.chattingView.preSendMessages.removeValue(forKey: (userMessage?.requestId)!)
                    
                    if error != nil {
                        self.chattingView.resendableMessages[(userMessage?.requestId)!] = userMessage
                        self.chattingView.chattingTableView.reloadData()
                        DispatchQueue.main.async {
                            self.chattingView.scrollToBottom(force: true)
                        }
                        
                        return
                    }
                    
                    self.chattingView.messages[self.chattingView.messages.index(of: preSendMessage)!] = userMessage!
                    
                    self.chattingView.chattingTableView.reloadData()
                    DispatchQueue.main.async {
                        self.chattingView.scrollToBottom(force: true)
                    }
                })
            }
            
            self.chattingView.messages[self.chattingView.messages.index(of: replacement)!] = preSendMessage
            self.chattingView.preSendMessages[preSendMessage.requestId!] = preSendMessage
            DispatchQueue.main.async {
                self.chattingView.chattingTableView.reloadData()
                DispatchQueue.main.async {
                    self.chattingView.scrollToBottom(force: true)
                }
            }
        }

    }
    
    func sendUrlPreview(url: URL, message: String, aTempModel: OutgoingGeneralUrlPreviewTempModel) {
        let tempModel = aTempModel
        let previewUrl = url;
        let request = URLRequest(url: url)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                self.sendMessageWithReplacement(replacement: aTempModel)
                session.invalidateAndCancel()
                
                return
            }
            
            let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
            let contentType: String = httpResponse.allHeaderFields["Content-Type"] as! String
            if contentType.contains("text/html") {
                let htmlBody: NSString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
                
                let parser: HTMLParser = HTMLParser(string: htmlBody as String)
                let document = parser.parseDocument()
                let head = document.head
                
                var title: String?
                var desc: String?
                
                var ogUrl: String?
                var ogSiteName: String?
                var ogTitle: String?
                var ogDesc: String?
                var ogImage: String?
                
                var twtSiteName: String?
                var twtTitle: String?
                var twtDesc: String?
                var twtImage: String?
                
                var finalUrl: String?
                var finalTitle: String?
                var finalSiteName: String?
                var finalDesc: String?
                var finalImage: String?
                
                for node in (head?.childNodes)! {
                    if node is HTMLElement {
                        let element: HTMLElement = node as! HTMLElement
                        if element.attributes["property"] != nil {
                            if ogUrl == nil && element.attributes["property"] as! String == "og:url" {
                                ogUrl = element.attributes["property"] as? String
                            }
                            else if ogSiteName == nil && element.attributes["property"] as! String == "og:site_name" {
                                ogSiteName = element.attributes["content"] as? String
                            }
                            else if ogTitle == nil && element.attributes["property"] as! String == "og:title" {
                                ogTitle = element.attributes["content"] as? String
                            }
                            else if ogDesc == nil && element.attributes["property"] as! String == "og:description" {
                                ogDesc = element.attributes["content"] as? String
                            }
                            else if ogImage == nil && element.attributes["property"] as! String == "og:image" {
                                ogImage = element.attributes["content"] as? String
                            }
                        }
                        else if element.attributes["name"] != nil {
                            if twtSiteName == nil && element.attributes["name"] as! String == "twitter:site" {
                                twtSiteName = element.attributes["content"] as? String
                            }
                            else if twtTitle == nil && element.attributes["name"] as! String == "twitter:title" {
                                twtTitle = element.attributes["content"] as? String
                            }
                            else if twtDesc == nil && element.attributes["name"] as! String == "twitter:description" {
                                twtDesc = element.attributes["content"] as? String
                            }
                            else if twtImage == nil && element.attributes["name"] as! String == "twitter:image" {
                                twtImage = element.attributes["content"] as? String
                            }
                            else if desc == nil && element.attributes["name"] as! String == "description" {
                                desc = element.attributes["content"] as? String
                            }
                        }
                        else if element.tagName == "title" {
                            if element.childNodes.count > 0 {
                                if element.childNodes[0] is HTMLText {
                                    title = (element.childNodes[0] as! HTMLText).data
                                }
                            }
                        }
                    }
                }
                
                if ogUrl != nil {
                    finalUrl = ogUrl
                }
                else {
                    finalUrl = previewUrl.absoluteString
                }
                
                if ogSiteName != nil {
                    finalSiteName = ogSiteName
                }
                else if twtSiteName != nil {
                    finalSiteName = twtSiteName
                }
                
                if ogTitle != nil {
                    finalTitle = ogTitle
                }
                else if twtTitle != nil {
                    finalTitle = twtTitle
                }
                else if title != nil {
                    finalTitle = title
                }
                
                if ogDesc != nil {
                    finalDesc = ogDesc
                }
                else if twtDesc != nil {
                    finalDesc = twtDesc
                }
                
                if ogImage != nil {
                    finalImage = ogImage
                }
                else if twtImage != nil {
                    finalImage = twtImage
                }
                
                if !(finalSiteName == nil || finalTitle == nil || finalDesc == nil) {
                    var data:[String:String] = [:]
                    data["site_name"] = finalSiteName
                    data["title"] = finalTitle
                    data["description"] = finalDesc
                    if finalImage != nil {
                        data["image"] = finalImage
                    }
                    
                    if finalUrl != nil {
                        data["url"] = finalUrl
                    }
                    
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.init(rawValue: 0))
                        let dataString = String(data: jsonData, encoding: String.Encoding.utf8)
                        
                        if let channel = self.groupChannel {
                            channel.sendUserMessage(message, data: dataString, customType: "url_preview", completionHandler: { (userMessage, error) in
                                if error != nil {
                                    self.sendMessageWithReplacement(replacement: aTempModel)
                                    
                                    return
                                }
                                
                                self.chattingView.messages[self.chattingView.messages.index(of: tempModel)!] = userMessage!
                                DispatchQueue.main.async {
                                    self.chattingView.chattingTableView.reloadData()
                                    DispatchQueue.main.async {
                                        self.chattingView.scrollToBottom(force: true)
                                    }
                                }
                            })
                        }
  
                    }
                    catch {
                        
                    }
                }
                else {
                    self.sendMessageWithReplacement(replacement: aTempModel)
                }
            }
            
            session.invalidateAndCancel()
        }
        
        task.resume()
    }
    
    
    @objc private func sendMessage() {
        if self.chattingView.messageTextView.text.count > 0 {
            self.groupChannel?.endTyping()
            let message = self.chattingView.messageTextView.text
            self.chattingView.messageTextView.text = ""
            
            do {
                let detector: NSDataDetector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
                let matches = detector.matches(in: message!, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, (message?.count)!))
                var url: URL? = nil
                for item in matches {
                    let match = item as NSTextCheckingResult
                    url = match.url
                    break
                }
                
                if url != nil {
                    let tempModel = OutgoingGeneralUrlPreviewTempModel()
                    tempModel.createdAt = Int64(NSDate().timeIntervalSince1970 * 1000)
                    tempModel.message = message
                    
                    self.chattingView.messages.append(tempModel)
                    DispatchQueue.main.async {
                        self.chattingView.chattingTableView.reloadData()
                        DispatchQueue.main.async {
                            self.chattingView.scrollToBottom(force: true)
                        }
                    }
                    
                    // Send preview
                    self.sendUrlPreview(url: url!, message: message!, aTempModel: tempModel)
                    
                    return
                }
            }
            catch {
                
            }
            
            self.chattingView.sendButton.isEnabled = false
            
            if let channel = groupChannel {
                let preSendMessage = channel.sendUserMessage(message, data: "", customType: "", targetLanguages: ["ar", "de", "fr", "nl", "ja", "ko", "pt", "es", "zh-CHS"], completionHandler: { (userMessage, error) in
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(150), execute: {
                        let preSendMessage = self.chattingView.preSendMessages[(userMessage?.requestId)!] as! SBDUserMessage
                        self.chattingView.preSendMessages.removeValue(forKey: (userMessage?.requestId)!)
                        
                        if error != nil {
                            self.chattingView.resendableMessages[(userMessage?.requestId)!] = userMessage
                            self.chattingView.chattingTableView.reloadData()
                            DispatchQueue.main.async {
                                self.chattingView.scrollToBottom(force: true)
                            }
                            
                            return
                        }
                        
                        let index = IndexPath(row: self.chattingView.messages.index(of: preSendMessage)!, section: 0)
                        self.chattingView.chattingTableView.beginUpdates()
                        self.chattingView.messages[self.chattingView.messages.index(of: preSendMessage)!] = userMessage!
                        
                        UIView.setAnimationsEnabled(false)
                        self.chattingView.chattingTableView.reloadRows(at: [index], with: UITableViewRowAnimation.none)
                        UIView.setAnimationsEnabled(true)
                        self.chattingView.chattingTableView.endUpdates()
                        
                        DispatchQueue.main.async {
                            self.chattingView.scrollToBottom(force: true)
                        }
                    })
                })
                
                self.chattingView.preSendMessages[preSendMessage.requestId!] = preSendMessage
                DispatchQueue.main.async {
                    if self.chattingView.preSendMessages[preSendMessage.requestId!] == nil {
                        return
                    }
                    
                    self.chattingView.chattingTableView.beginUpdates()
                    self.chattingView.messages.append(preSendMessage)
                    
                    UIView.setAnimationsEnabled(false)
                    self.chattingView.chattingTableView.insertRows(at: [IndexPath(row: self.chattingView.messages.index(of: preSendMessage)!, section: 0)], with: UITableViewRowAnimation.none)
                    UIView.setAnimationsEnabled(true)
                    print("\(self.chattingView.messages.count)")
                    self.chattingView.chattingTableView.endUpdates()
                    
                    DispatchQueue.main.async {
                        self.chattingView.scrollToBottom(force: true)
                        self.chattingView.sendButton.isEnabled = true
                    }
                    
                    self.checkAndSendFirstResponse()
                }
            }
  
        }
    }
    
    func loadPreviousMessage(initial: Bool) {
        var timestamp: Int64 = 0
        if initial {
            self.hasNext = true
            timestamp = Int64.max
        }
        else {
            timestamp = self.minMessageTimestamp
        }
        
        if self.hasNext == false {
            return
        }
        
        if self.isLoading {
            return
        }
        
        self.isLoading = true
        
        self.groupChannel?.getPreviousMessages(byTimestamp: timestamp, limit: 30, reverse: !initial, messageType: SBDMessageTypeFilter.all, customType: "") { (messages, error) in
            if error != nil {
                self.isLoading = false
                
                return
            }
            
            self.cachedMessage = false
            
            if messages?.count == 0 {
                self.hasNext = false
            }
            
            if initial {
                self.chattingView.messages.removeAll()
                
                for item in messages! {
                    let message: SBDBaseMessage = item as SBDBaseMessage
                    self.chattingView.messages.append(message)
                    if self.minMessageTimestamp > message.createdAt {
                        self.minMessageTimestamp = message.createdAt
                    }
                }
                
                let resendableMessagesKeys = self.chattingView.resendableMessages.keys
                for item in resendableMessagesKeys {
                    let key = item as String
                    self.chattingView.messages.append(self.chattingView.resendableMessages[key]!)
                }
                
                let preSendMessagesKeys = self.chattingView.preSendMessages.keys
                for item in preSendMessagesKeys {
                    let key = item as String
                    self.chattingView.messages.append(self.chattingView.preSendMessages[key]!)
                }
                
                self.groupChannel?.markAsRead()
                
                self.chattingView.initialLoading = true
                
                if (messages?.count)! > 0 {
                    DispatchQueue.main.async {
                        self.chattingView.chattingTableView.reloadData()
                        self.chattingView.chattingTableView.layoutIfNeeded()
                        
                        var viewHeight: CGFloat
                        if self.keyboardShown {
                            viewHeight = self.chattingView.chattingTableView.frame.size.height - 10
                        }
                        else {
                            viewHeight = UIScreen.main.bounds.size.height - 74 - self.chattingView.inputContainerViewHeight.constant - 10
                        }
                        
                        let contentSize = self.chattingView.chattingTableView.contentSize
                        
                        if contentSize.height > viewHeight {
                            let newContentOffset = CGPoint(x: 0, y: contentSize.height - viewHeight)
                            self.chattingView.chattingTableView.setContentOffset(newContentOffset, animated: false)
                        }
                    }
                }
                
                self.chattingView.initialLoading = false
                self.isLoading = false
            }
            else {
                if (messages?.count)! > 0 {
                    for item in messages! {
                        let message: SBDBaseMessage = item as SBDBaseMessage
                        self.chattingView.messages.insert(message, at: 0)
                        
                        if self.minMessageTimestamp > message.createdAt {
                            self.minMessageTimestamp = message.createdAt
                        }
                    }
                    
                    DispatchQueue.main.async {
                        let contentSizeBefore = self.chattingView.chattingTableView.contentSize
                        
                        self.chattingView.chattingTableView.reloadData()
                        self.chattingView.chattingTableView.layoutIfNeeded()
                        
                        let contentSizeAfter = self.chattingView.chattingTableView.contentSize
                        
                        let newContentOffset = CGPoint(x: 0, y: contentSizeAfter.height - contentSizeBefore.height)
                        self.chattingView.chattingTableView.setContentOffset(newContentOffset, animated: false)
                    }
                }
                
                self.isLoading = false
            }
        }
    }
    
    @objc func close() {
        SBDMain.removeChannelDelegate(forIdentifier: self.description)
        SBDMain.removeConnectionDelegate(forIdentifier: self.description)
        self.dismiss(animated: false) {
            
        }
    }
    
    
    
}
extension ChattingViewController : SBDChannelDelegate {
    func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
        if sender == self.groupChannel {
            self.groupChannel?.markAsRead()
            
            DispatchQueue.main.async {
                UIView.setAnimationsEnabled(false)
                self.chattingView.messages.append(message)
                self.chattingView.chattingTableView.reloadData()
                UIView.setAnimationsEnabled(true)
                DispatchQueue.main.async {
                    self.chattingView.scrollToBottom(force: false)
                }
            }
        }
    }
    
    func channelDidUpdateReadReceipt(_ sender: SBDGroupChannel) {
        if sender == self.groupChannel {
            DispatchQueue.main.async {
                self.chattingView.chattingTableView.reloadData()
            }
        }
    }
    
    func channelDidUpdateTypingStatus(_ sender: SBDGroupChannel) {
        if sender == self.groupChannel {
            if sender.getTypingMembers()?.count == 0 {
                self.chattingView.endTypingIndicator()
            }
            else {
                if sender.getTypingMembers()?.count == 1 {
                    self.chattingView.startTypingIndicator(text: String(format: Bundle.sbLocalizedStringForKey(key: "TypingMessageSingular"), (sender.getTypingMembers()?[0].nickname)!))
                }
                else {
                    self.chattingView.startTypingIndicator(text: Bundle.sbLocalizedStringForKey(key: "TypingMessagePlural"))
                }
            }
        }
    }
    
    func channel(_ sender: SBDGroupChannel, userDidJoin user: SBDUser) {
    }
    
    func channel(_ sender: SBDGroupChannel, userDidLeave user: SBDUser) {
    }
    
    func channel(_ sender: SBDOpenChannel, userDidEnter user: SBDUser) {
        
    }
    
    func channel(_ sender: SBDOpenChannel, userDidExit user: SBDUser) {
        
    }
    
    func channel(_ sender: SBDOpenChannel, userWasMuted user: SBDUser) {
        
    }
    
    func channel(_ sender: SBDOpenChannel, userWasUnmuted user: SBDUser) {
        
    }
    
    func channel(_ sender: SBDOpenChannel, userWasBanned user: SBDUser) {
        
    }
    
    func channel(_ sender: SBDOpenChannel, userWasUnbanned user: SBDUser) {
        
    }
    
    func channelWasFrozen(_ sender: SBDOpenChannel) {
        
    }
    
    func channelWasUnfrozen(_ sender: SBDOpenChannel) {
        
    }
    
    func channelWasChanged(_ sender: SBDBaseChannel) {
        if sender == self.groupChannel {
        }
    }
    
    func channelWasDeleted(_ channelUrl: String, channelType: SBDChannelType) {
        let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ChannelDeletedTitle"), message: Bundle.sbLocalizedStringForKey(key: "ChannelDeletedMessage"), preferredStyle: UIAlertControllerStyle.alert)
        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel) { (action) in
            self.close()
        }
        vc.addAction(closeAction)
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func channel(_ sender: SBDBaseChannel, messageWasDeleted messageId: Int64) {
        if sender == self.groupChannel {
            for message in self.chattingView.messages {
                if message.messageId == messageId {
                    self.chattingView.messages.remove(at: self.chattingView.messages.index(of: message)!)
                    DispatchQueue.main.async {
                        self.chattingView.chattingTableView.reloadData()
                    }
                    break
                }
            }
        }
    }
}
extension ChattingViewController : SBDConnectionDelegate {
    func didStartReconnection() {
    }
    
    func didSucceedReconnection() {
        self.loadPreviousMessage(initial: true)
        
        self.groupChannel?.refresh { (error) in
        }
    }
    
    func didFailReconnection() {
    }
    
}

extension ChattingViewController : ChattingViewDelegate {
    func loadMoreMessage(view: UIView) {
        if self.cachedMessage {
            return
        }
        
        self.loadPreviousMessage(initial: false)
    }
    
    func startTyping(view: UIView) {
        self.groupChannel?.startTyping()
    }
    
    func endTyping(view: UIView) {
        self.groupChannel?.endTyping()
    }
    
    func hideKeyboardWhenFastScrolling(view: UIView) {
        if self.keyboardShown == false {
            return
        }
        
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
            self.chattingView.scrollToBottom(force: false)
        }
        self.view.endEditing(true)
    }
}

extension ChattingViewController : MessageDelegate {
    func clickProfileImage(viewCell: UITableViewCell, user: SBDUser) {
        let vc = UIAlertController(title: user.nickname, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let seeBlockUserAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "BlockUserButton"), style: UIAlertActionStyle.default) { (action) in
            SBDMain.blockUser(user, completionHandler: { (blockedUser, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
                        vc.addAction(closeAction)
                        DispatchQueue.main.async {
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                    
                    return
                }
                
                DispatchQueue.main.async {
                    let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "UserBlockedTitle"), message: String(format: Bundle.sbLocalizedStringForKey(key: "UserBlockedMessage"), user.nickname!), preferredStyle: UIAlertControllerStyle.alert)
                    let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
                    vc.addAction(closeAction)
                    DispatchQueue.main.async {
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            })
        }
        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
        vc.addAction(seeBlockUserAction)
        vc.addAction(closeAction)
        
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func clickMessage(view: UIView, message: SBDBaseMessage) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
        var deleteMessageAction: UIAlertAction?
        var openFileAction: UIAlertAction?
        var openURLsAction: [UIAlertAction] = []
        
        if message is SBDUserMessage {
            let userMessage = message as! SBDUserMessage
            if userMessage.customType != nil && userMessage.customType == "url_preview" {
                let data: Data = (userMessage.data?.data(using: String.Encoding.utf8)!)!
                do {
                    let previewData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0))
                    let url = URL(string: ((previewData as! Dictionary<String, Any>)["url"] as! String))
                    UIApplication.shared.openURL(url!)
                }
                catch {
                    
                }
                
            }
            else {
                let sender = (message as! SBDUserMessage).sender
                if sender?.userId == SBDMain.getCurrentUser()?.userId {
                    deleteMessageAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "DeleteMessageButton"), style: UIAlertActionStyle.destructive, handler: { (action) in
                        self.groupChannel?.delete(message, completionHandler: { (error) in
                            if error != nil {
                                let alert = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                                let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
                                alert.addAction(closeAction)
                                DispatchQueue.main.async {
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                        })
                    })
                }
                
                do {
                    let detector: NSDataDetector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
                    let matches = detector.matches(in: (message as! SBDUserMessage).message!, options: [], range: NSMakeRange(0, ((message as! SBDUserMessage).message?.count)!))
                    for match in matches as [NSTextCheckingResult] {
                        let url: URL = match.url!
                        let openURLAction = UIAlertAction(title: url.relativeString, style: UIAlertActionStyle.default, handler: { (action) in
                            self.refreshInViewDidAppear = false
                            UIApplication.shared.openURL(url)
                        })
                        openURLsAction.append(openURLAction)
                    }
                }
                catch {
                    
                }
            }
            
        }
        else if message is SBDFileMessage {
            let fileMessage: SBDFileMessage = message as! SBDFileMessage
            let sender = fileMessage.sender
            let type = fileMessage.type
            let url = fileMessage.url
            
            if sender?.userId == SBDMain.getCurrentUser()?.userId {
                deleteMessageAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "DeleteMessageButton"), style: UIAlertActionStyle.destructive, handler: { (action) in
                    self.groupChannel?.delete(fileMessage, completionHandler: { (error) in
                        if error != nil {
                            let alert = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                            let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
                            alert.addAction(closeAction)
                            DispatchQueue.main.async {
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    })
                })
            }
            
            if type.hasPrefix("video") {
                let videoUrl = NSURL(string: url)
                let player = AVPlayer(url: videoUrl! as URL)
                let vc = AVPlayerViewController()
                vc.player = player
                self.refreshInViewDidAppear = false
                self.present(vc, animated: true, completion: {
                    player.play()
                })
                
                return
            }
            else if type.hasPrefix("audio") {
                let audioUrl = NSURL(string: url)
                let player = AVPlayer(url: audioUrl! as URL)
                let vc = AVPlayerViewController()
                vc.player = player
                self.refreshInViewDidAppear = false
                self.present(vc, animated: true, completion: {
                    player.play()
                })
                
                return
            }
            else if type.hasPrefix("image") {
                //                self.showImageViewerLoading()
                //                let photo = ChatImage()
                //                let cachedData = FLAnimatedImageView.cachedImageForURL(url: URL(string: url)!)
                //                if cachedData != nil {
                //                    photo.imageData = cachedData
                //
                //                    self.photosViewController = NYTPhotosViewController(photos: [photo])
                //                    DispatchQueue.main.async {
                //                        self.photosViewController.rightBarButtonItems = nil
                //                        self.photosViewController.rightBarButtonItem = nil
                //
                //                        let negativeLeftSpacerForImageViewerLoading = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
                //                        negativeLeftSpacerForImageViewerLoading.width = -2
                //
                //                        let leftCloseItemForImageViewerLoading = UIBarButtonItem(image: UIImage(named: "btn_close"), style: UIBarButtonItemStyle.done, target: self, action: #selector(self.closeImageViewer))
                //
                //                        self.imageViewerLoadingViewNavItem.leftBarButtonItems = [negativeLeftSpacerForImageViewerLoading, leftCloseItemForImageViewerLoading]
                //
                //
                //                        self.present(self.photosViewController, animated: true, completion: {
                //                            self.hideImageViewerLoading()
                //                        })
                //                    }
                //                }
                //                else {
                //                    let session = URLSession.shared
                //                    let request = URLRequest(url: URL(string: url)!)
                //                    session.dataTask(with: request, completionHandler: { (data, response, error) in
                //                        if error != nil {
                //                            self.hideImageViewerLoading()
                //
                //                            return;
                //                        }
                //
                //                        let resp = response as! HTTPURLResponse
                //                        if resp.statusCode >= 200 && resp.statusCode < 300 {
                //                            AppDelegate.imageCache().setObject(data as AnyObject, forKey: url as AnyObject)
                //                            let photo = ChatImage()
                //                            photo.imageData = data
                //
                //                            self.photosViewController = NYTPhotosViewController(photos: [photo])
                //                            DispatchQueue.main.async {
                //                                self.photosViewController.rightBarButtonItems = nil
                //                                self.photosViewController.rightBarButtonItem = nil
                //
                //                                let negativeLeftSpacerForImageViewerLoading = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
                //                                negativeLeftSpacerForImageViewerLoading.width = -2
                //
                //                                let leftCloseItemForImageViewerLoading = UIBarButtonItem(image: UIImage(named: "btn_close"), style: UIBarButtonItemStyle.done, target: self, action: #selector(self.closeImageViewer))
                //
                //                                self.imageViewerLoadingViewNavItem.leftBarButtonItems = [negativeLeftSpacerForImageViewerLoading, leftCloseItemForImageViewerLoading]
                //
                //                                self.present(self.photosViewController, animated: true, completion: {
                //                                    self.hideImageViewerLoading()
                //                                })
                //                            }
                //                        }
                //                        else {
                //                            self.hideImageViewerLoading()
                //                        }
                //                    }).resume()
                //
                //                    return
                //                }
            }
            else {
                // TODO: Download file. Is this possible on iOS?
            }
        }
        else if message is SBDAdminMessage {
            return
        }
        
        alert.addAction(closeAction)
        //        if openFileAction != nil {
        //            alert.addAction(openFileAction!)
        //        }
        
        if openURLsAction.count > 0 {
            for action in openURLsAction {
                alert.addAction(action)
            }
        }
        
        if deleteMessageAction != nil {
            alert.addAction(deleteMessageAction!)
        }
        
        if openURLsAction.count > 0 || deleteMessageAction != nil {
            DispatchQueue.main.async {
                self.refreshInViewDidAppear = false
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func clickResend(view: UIView, message: SBDBaseMessage) {
        let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ResendFailedMessageTitle"), message: Bundle.sbLocalizedStringForKey(key: "ResendFailedMessageDescription"), preferredStyle: UIAlertControllerStyle.alert)
        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
        let resendAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "ResendFailedMessageButton"), style: UIAlertActionStyle.default) { (action) in
            if message is SBDUserMessage {
                let resendableUserMessage = message as! SBDUserMessage
                var targetLanguages:[String] = []
                if resendableUserMessage.translations != nil {
                    targetLanguages = Array(resendableUserMessage.translations!.keys) as! [String]
                }
                
                do {
                    let detector: NSDataDetector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
                    let matches = detector.matches(in: resendableUserMessage.message!, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, (resendableUserMessage.message!.count)))
                    var url: URL? = nil
                    for item in matches {
                        let match = item as NSTextCheckingResult
                        url = match.url
                        break
                    }
                    
                    if url != nil {
                        let tempModel = OutgoingGeneralUrlPreviewTempModel()
                        tempModel.createdAt = Int64(NSDate().timeIntervalSince1970 * 1000)
                        tempModel.message = resendableUserMessage.message!
                        
                        self.chattingView.messages[self.chattingView.messages.index(of: resendableUserMessage)!] = tempModel
                        self.chattingView.resendableMessages.removeValue(forKey: resendableUserMessage.requestId!)
                        
                        DispatchQueue.main.async {
                            self.chattingView.chattingTableView.reloadData()
                            DispatchQueue.main.async {
                                self.chattingView.scrollToBottom(force: true)
                            }
                        }
                        
                        // Send preview
                        self.sendUrlPreview(url: url!, message: resendableUserMessage.message!, aTempModel: tempModel)
                    }
                }
                catch {
                    
                }
                
                if let channel = self.groupChannel {
                    let preSendMessage = channel.sendUserMessage(resendableUserMessage.message, data: resendableUserMessage.data, customType: resendableUserMessage.customType, targetLanguages: targetLanguages, completionHandler: { (userMessage, error) in
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(150), execute: {
                            DispatchQueue.main.async {
                                let preSendMessage = self.chattingView.preSendMessages[(userMessage?.requestId)!]
                                self.chattingView.preSendMessages.removeValue(forKey: (userMessage?.requestId)!)
                                
                                if error != nil {
                                    self.chattingView.resendableMessages[(userMessage?.requestId)!] = userMessage
                                    self.chattingView.chattingTableView.reloadData()
                                    DispatchQueue.main.async {
                                        self.chattingView.scrollToBottom(force: true)
                                    }
                                    
                                    let alert = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                                    let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
                                    alert.addAction(closeAction)
                                    DispatchQueue.main.async {
                                        self.present(alert, animated: true, completion: nil)
                                    }
                                    
                                    return
                                }
                                
                                if preSendMessage != nil {
                                    self.chattingView.messages.remove(at: self.chattingView.messages.index(of: (preSendMessage! as SBDBaseMessage))!)
                                    self.chattingView.messages.append(userMessage!)
                                }
                                
                                self.chattingView.chattingTableView.reloadData()
                                DispatchQueue.main.async {
                                    self.chattingView.scrollToBottom(force: true)
                                }
                            }
                        })
                    })
                    self.chattingView.messages[self.chattingView.messages.index(of: resendableUserMessage)!] = preSendMessage
                    self.chattingView.preSendMessages[preSendMessage.requestId!] = preSendMessage
                    self.chattingView.resendableMessages.removeValue(forKey: resendableUserMessage.requestId!)
                    self.chattingView.chattingTableView.reloadData()
                    DispatchQueue.main.async {
                        self.chattingView.scrollToBottom(force: true)
                    }
                }
  
            }
            else if message is SBDFileMessage {
                let resendableFileMessage = message as! SBDFileMessage
                
                var thumbnailSizes: [SBDThumbnailSize] = []
                for thumbnail in resendableFileMessage.thumbnails! as [SBDThumbnail] {
                    thumbnailSizes.append(SBDThumbnailSize.make(withMaxCGSize: thumbnail.maxSize)!)
                }
                if let channel = self.groupChannel {
                    let preSendMessage = channel.sendFileMessage(withBinaryData: self.chattingView.preSendFileData[resendableFileMessage.requestId!]?["data"] as! Data, filename: resendableFileMessage.name, type: resendableFileMessage.type, size: resendableFileMessage.size, thumbnailSizes: thumbnailSizes, data: resendableFileMessage.data, customType: resendableFileMessage.customType, progressHandler: nil, completionHandler: { (fileMessage, error) in
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(150), execute: {
                            let preSendMessage = self.chattingView.preSendMessages[(fileMessage?.requestId)!]
                            self.chattingView.preSendMessages.removeValue(forKey: (fileMessage?.requestId)!)
                            
                            if error != nil {
                                self.chattingView.resendableMessages[(fileMessage?.requestId)!] = fileMessage
                                self.chattingView.resendableFileData[(fileMessage?.requestId)!] = self.chattingView.resendableFileData[resendableFileMessage.requestId!]
                                self.chattingView.resendableFileData.removeValue(forKey: resendableFileMessage.requestId!)
                                self.chattingView.chattingTableView.reloadData()
                                DispatchQueue.main.async {
                                    self.chattingView.scrollToBottom(force: true)
                                }
                                
                                let alert = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "ErrorTitle"), message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                                let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
                                alert.addAction(closeAction)
                                DispatchQueue.main.async {
                                    self.present(alert, animated: true, completion: nil)
                                }
                                
                                return
                            }
                            
                            if preSendMessage != nil {
                                self.chattingView.messages.remove(at: self.chattingView.messages.index(of: (preSendMessage! as SBDBaseMessage))!)
                                self.chattingView.messages.append(fileMessage!)
                            }
                            
                            self.chattingView.chattingTableView.reloadData()
                            DispatchQueue.main.async {
                                self.chattingView.scrollToBottom(force: true)
                            }
                        })
                    })
                    
                    self.chattingView.messages[self.chattingView.messages.index(of: resendableFileMessage)!] = preSendMessage
                    self.chattingView.preSendMessages[preSendMessage.requestId!] = preSendMessage
                    self.chattingView.preSendFileData[preSendMessage.requestId!] = self.chattingView.resendableFileData[resendableFileMessage.requestId!]
                    self.chattingView.resendableMessages.removeValue(forKey: resendableFileMessage.requestId!)
                    self.chattingView.resendableFileData.removeValue(forKey: resendableFileMessage.requestId!)
                    self.chattingView.chattingTableView.reloadData()
                    DispatchQueue.main.async {
                        self.chattingView.scrollToBottom(force: true)
                    }
                }

            }
        }
        
        vc.addAction(closeAction)
        vc.addAction(resendAction)
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func clickDelete(view: UIView, message: SBDBaseMessage) {
        let vc = UIAlertController(title: Bundle.sbLocalizedStringForKey(key: "DeleteFailedMessageTitle"), message: Bundle.sbLocalizedStringForKey(key: "DeleteFailedMessageDescription"), preferredStyle: UIAlertControllerStyle.alert)
        let closeAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "CloseButton"), style: UIAlertActionStyle.cancel, handler: nil)
        let deleteAction = UIAlertAction(title: Bundle.sbLocalizedStringForKey(key: "DeleteFailedMessageButton"), style: UIAlertActionStyle.destructive) { (action) in
            var requestId: String?
            if message is SBDUserMessage {
                requestId = (message as! SBDUserMessage).requestId
            }
            else if message is SBDFileMessage {
                requestId = (message as! SBDFileMessage).requestId
            }
            self.chattingView.resendableFileData.removeValue(forKey: requestId!)
            self.chattingView.resendableMessages.removeValue(forKey: requestId!)
            self.chattingView.messages.remove(at: self.chattingView.messages.index(of: message)!)
            DispatchQueue.main.async {
                self.chattingView.chattingTableView.reloadData()
            }
        }
        
        vc.addAction(closeAction)
        vc.addAction(deleteAction)
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
}

//MARK: keyboard
extension ChattingViewController {
    func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        adjustForKeyboard(notification: notification, isShow: true)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        adjustForKeyboard(notification: notification, isShow: false)
    }

    func adjustForKeyboard(notification: NSNotification, isShow: Bool) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.chatViewBottom.constant = 0
            } else {
                self.chatViewBottom.constant = (endFrame?.size.height)!
            }
            UIView.animate(withDuration: duration, delay: TimeInterval(0.3), options: animationCurve, animations: {
                self.loadViewIfNeeded()
            }, completion: { (error) in
                self.chattingView.scrollToBottom(force: true)
            })

        }
    }
}

