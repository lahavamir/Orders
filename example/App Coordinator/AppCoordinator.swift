//
//  AppCoordinator.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator:Coordinator
{
    var window:UIWindow
    var pressenter: UINavigationController
    var listCoordinator:ListCoordinator
    
    init(window:UIWindow) {
        
        self.window = window
        
        // setup container
        pressenter = UINavigationController()
        pressenter.navigationBar.prefersLargeTitles = true

        /// test contoller
        let test = UIViewController()
        test.view.backgroundColor = .brown
//        pressenter.pushViewController(test, animated: false)
        
        listCoordinator = ListCoordinator(pressenter: pressenter)
        
    }
    
    
    func start() {
        
        self.window.rootViewController = pressenter
        
        listCoordinator.start()
        
        self.window.makeKeyAndVisible()
    }

}
