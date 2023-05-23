//  AppDelegate.swift
//  OCRMobile
//  Created by Kenan Baylan on 7.05.2023.


import UIKit
import Foundation
import CoreData


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let hasOpenedBefore = UserDefaults.standard.bool(forKey: "hasOpenedBefore")
        
        if hasOpenedBefore {
            // Show loading page
            UserDefaults.standard.set(true, forKey: "hasOpenedBefore")
            
            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
            let loadingViewIdentifier = LoadingViewController.identifier
            
            let initialViewController = storyboard.instantiateViewController(withIdentifier: loadingViewIdentifier)
            
            window?.rootViewController = initialViewController
            
        } else {
            
            // Example: Set your initial view controller as the root view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainTabbarController")
            window?.rootViewController = initialViewController
        }
        
        
        return true
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    
    //MARK: Core Data
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ScannedFiles")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
        
        
    }()
    
    
    //MARK: CoreData Saving
    func saveContext () {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            
            do {
                try context.save()
            } catch {
                
                //some text
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
    
}

