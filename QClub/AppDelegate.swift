//
//  AppDelegate.swift
//  QClub
//
//  Created by Dream on 9/11/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import Google
import CoreData
import IQKeyboardManagerSwift
import UserNotifications
import SendBirdSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GGLInstanceIDDelegate, GCMReceiverDelegate {

    var window: UIWindow?
    
    var connectedToGCM = false
    var subscribedToTopic = false
    var gcmSenderID: String?
    var registrationToken: String?
    var registrationOptions = [String: AnyObject]()
    
    let registrationKey = "onRegistrationCompleted"
    let messageKey = "onMessageReceived"
    let subscriptionTopic = "/topics/global"
    
    let SendBirdAppID = "38DB7E9B-4A4F-4F10-BFE4-7D4F705C0D58"
    var newLetters:[LetterUserObject] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        IQKeyboardManager.sharedManager().shouldShowToolbarPlaceholder = false
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        openLandingView()
        
//        for name in UIFont.familyNames {
//            print(name)
//            if let nameString = name as? String
//            {
//                print(UIFont.fontNames(forFamilyName: nameString))
//            }
//        }
        
        // [START_EXCLUDE]
        // Configure the Google context: parses the GoogleService-Info.plist, and initializes
        // the services that have entries in the file
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
        gcmSenderID = GGLContext.sharedInstance().configuration.gcmSenderID
        // [END_EXCLUDE]
        // Register for remote notifications
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
        
        
        // [END register_for_remote_notifications]
        // [START start_gcm_service]
        let gcmConfig = GCMConfig.default()
        gcmConfig?.receiverDelegate = self
        GCMService.sharedInstance().start(with: gcmConfig)
        // [END start_gcm_service]
        
        //SendBird
        SBDMain.initWithApplicationId(SendBirdAppID)
        SBDMain.setLogLevel(SBDLogLevel.none)
        SBDOptions.setUseMemberAsMessageSender(true)
        
        return true
    }
    
    func subscribeToTopic() {
        // If the app has a registration token and is connected to GCM, proceed to subscribe to the
        // topic
        if registrationToken != nil && connectedToGCM {
            GCMPubSub.sharedInstance().subscribe(withToken: self.registrationToken, topic: subscriptionTopic,
                                                 options: nil, handler: { error -> Void in
                                                    if let error = error as NSError? {
                                                        // Treat the "already subscribed" error more gently
                                                        if error.code == 3001 {
                                                            print("Already subscribed to \(self.subscriptionTopic)")
                                                        } else {
                                                            print("Subscription failed: \(error.localizedDescription)")
                                                        }
                                                    } else {
                                                        self.subscribedToTopic = true
                                                        NSLog("Subscribed to \(self.subscriptionTopic)")
                                                    }
            })
        }
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    
    
    func openLandingView() {
        let rootView: LandingViewController = LandingViewController(nibName: "LandingViewController", bundle: nil)
        
        if let window = self.window{
            window.rootViewController = rootView
        }
    }
    
    public func openMainView() {
        UIApplication.shared.showHomeViewController(window: window)
    }
    
    public func openLoginView() {
        let rootView = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginNavigationController")
        
        if let window = self.window{
            window.rootViewController = rootView
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    // [START disconnect_gcm_service]
    func applicationDidEnterBackground(_ application: UIApplication) {
        GCMService.sharedInstance().disconnect()
        // [START_EXCLUDE]
        self.connectedToGCM = false
        // [END_EXCLUDE]
    }
    // [END disconnect_gcm_service]

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    // [START connect_gcm_service]
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Connect to the GCM server to receive non-APNS notifications
        GCMService.sharedInstance().connect(handler: { error -> Void in
            if let error = error as NSError? {
                print("Could not connect to GCM: \(error.localizedDescription)")
            } else {
                self.connectedToGCM = true
                print("Connected to GCM")
                // [START_EXCLUDE]
                self.subscribeToTopic()
                // [END_EXCLUDE]
            }
        })
    }
    // [END connect_gcm_service]
    
    // [START receive_apns_token]
    func application( _ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken
        deviceToken: Data ) {
        // [END receive_apns_token]
        // [START get_gcm_reg_token]
        // Create a config and set a delegate that implements the GGLInstaceIDDelegate protocol.
        let instanceIDConfig = GGLInstanceIDConfig.default()
        instanceIDConfig?.delegate = self
        // Start the GGLInstanceID shared instance with that config and request a registration
        // token to enable reception of notifications
        GGLInstanceID.sharedInstance().start(with: instanceIDConfig)
        registrationOptions = [kGGLInstanceIDRegisterAPNSOption:deviceToken as AnyObject,
                               kGGLInstanceIDAPNSServerTypeSandboxOption:true as AnyObject]
        GGLInstanceID.sharedInstance().token(withAuthorizedEntity: gcmSenderID,
                                             scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)
        
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        
        // [END get_gcm_reg_token]
        
        
        SBDMain.registerDevicePushToken(deviceToken, unique: true) { (status, error) in
            if error == nil {
                if status == SBDPushTokenRegistrationStatus.pending {
                    print("Sendbird Notification: Registration is pending.")
                    // If you get this status, invoke `+ registerDevicePushToken:unique:completionHandler:` with `[SBDMain getPendingPushToken]` after connection.
                }
                else {
                    print("Sendbird Notification: Registration succeeded.")
                }
            }
            else {
                print("Sendbird Notification: Registration failed.")
            }
        }
            
    }
    
    // [START receive_apns_token_error]
    func application( _ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError
        error: Error ) {
        print("Registration for remote notification failed with error: \(error.localizedDescription)")
        // [END receive_apns_token_error]
        let userInfo = ["error": error.localizedDescription]
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: registrationKey), object: nil, userInfo: userInfo)
    }
    
    // [START ack_message_reception]
    func application( _ application: UIApplication,
                      didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print("Notification received: \(userInfo)")
        // This works only if the app started the GCM service
        GCMService.sharedInstance().appDidReceiveMessage(userInfo)
        // Handle the received message
        // [START_EXCLUDE]
        NotificationCenter.default.post(name: Notification.Name(rawValue: messageKey), object: nil,
                                        userInfo: userInfo)
        // [END_EXCLUDE]
    }
    
    func application( _ application: UIApplication,
                      didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                      fetchCompletionHandler handler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Notification received: \(userInfo)")
        // This works only if the app started the GCM service
        GCMService.sharedInstance().appDidReceiveMessage(userInfo)
        // Handle the received message
        // Invoke the completion handler passing the appropriate UIBackgroundFetchResult value
        // [START_EXCLUDE]
        
        let alertMsg = (userInfo["aps"] as! NSDictionary)["alert"] as! NSDictionary
        let payload = userInfo["sendbird"] as! NSDictionary
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: messageKey), object: nil,
                                        userInfo: userInfo)
        handler(UIBackgroundFetchResult.newData)
        // [END_EXCLUDE]
    }
    // [END ack_message_reception]
    func registrationHandler(_ registrationToken: String?, error: Error?) {
        if let registrationToken = registrationToken {
            self.registrationToken = registrationToken
            print("\(registrationToken)")
            AuthService.postIdNotification(registrationId: registrationToken, completion: { (response) in
                print("Post Registration Token success: \(registrationToken)")
            }, fail: { (error) in
                print("Post Registration Token error: \(error._code)")
            })
            
            self.subscribeToTopic()
            let userInfo = ["registrationToken": registrationToken]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: self.registrationKey), object: nil, userInfo: userInfo)
        } else if let error = error {
            print("Registration to GCM failed with error: \(error.localizedDescription)")
            let userInfo = ["error": error.localizedDescription]
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: self.registrationKey), object: nil, userInfo: userInfo)
        }
    }
    
    // [START on_token_refresh]
    func onTokenRefresh() {
        // A rotation of the registration tokens is happening, so the app needs to request a new token.
        print("The GCM registration token needs to be changed.")
        GGLInstanceID.sharedInstance().token(withAuthorizedEntity: gcmSenderID,
                                             scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)
    }
    // [END on_token_refresh]
    // [START upstream_callbacks]
    func willSendDataMessage(withID messageID: String!, error: Error!) {
        if error != nil {
            // Failed to send the message.
        } else {
            // Will send message, you can save the messageID to track the message
        }
    }
    
    func didSendDataMessage(withID messageID: String!) {
        // Did successfully send message identified by messageID
    }
    // [END upstream_callbacks]
    func didDeleteMessagesOnServer() {
        // Some messages sent to this device were deleted on the GCM server before reception, likely
        // because the TTL expired. The client should notify the app server of this, so that the app
        // server can resend those messages.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack
    
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "QClub")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // iOS 9 and below
    lazy var applicationDocumentsDirectory: URL = {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "QClub", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("QClub.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption:true])
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if #available(iOS 10.0, *) {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        } else {
            // iOS 9.0 and below - however you were previously handling it
            if managedObjectContext.hasChanges {
                do {
                    try managedObjectContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
            }
        }
        
    }

}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([UNNotificationPresentationOptions.alert,UNNotificationPresentationOptions.sound,UNNotificationPresentationOptions.badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        if let sendbird = userInfo["sendbird"] as? NSDictionary {
            if let channel  = sendbird["channel"] as? NSDictionary {
                if let url = channel["channel_url"] as? String {
                    SBDGroupChannel.getWithUrl(url, completionHandler: { (groupChannel, error) in
                        if groupChannel?.name == Constants.ChannelName.Letter {
                            let letterTalkVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LetterTalkViewController") as! LetterTalkViewController
                            letterTalkVC.groupChannel = groupChannel
                            UIApplication.shared.keyWindow?.currentViewController()?.navigationController?.pushViewController(letterTalkVC, animated: true)
                        }
                    })
                }
            }
        }
        
        
        
        completionHandler()
    }
}
// [END ios_10_message_handling]

