//
//  ListCoordinator.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit

class ListCoordinator: Coordinator {
    
    var pressenter: UINavigationController
    var listController:OrderListViewController?
    
    init(pressenter:UINavigationController) {
        self.pressenter = pressenter
    }
    
    func setupNavigationBar()
    {
        
        // navigation bar properties
        self.pressenter.navigationBar.topItem?.title = "My Order"
        self.pressenter.navigationBar.barTintColor = UIColor(red: 120/255, green: 96/255, blue: 196/255, alpha: 1)
        self.pressenter.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.pressenter.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func start() {
        
        // fake APIService can be inject to model
        let mockService = MockAPIService()
        
        // real APIService
        let apiService = APIService()
        
        // api service injected to Model
        let listModel = OrderListModel(apiService: mockService)
        
        // model Injected to View Model
        let listViewModel = OrderListViewModel(model: listModel)
        
        // View Model inject to View Controller
        let list = OrderListViewController(viewModel: listViewModel)
        
        // controller to pressenter
        pressenter.pushViewController(list, animated: false)

        // setup navigation properties
        setupNavigationBar()

        listController = list
        
    }
        
}
