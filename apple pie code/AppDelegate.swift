//
//  AppDelegate.swift
//  apple pie code
//
//  Created by Сергей Земсков on 09.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow (frame: UIScreen.main.bounds)
        
//      window?.backgroundColor = .yellow
// цвет для проверки правильной работы при запуске приложения
        
        window?.rootViewController = ViewController ()
        window?.makeKeyAndVisible()
        return true
    }
}
