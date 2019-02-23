//
//  OrderListViewModel.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit


protocol OrderListViewModelDelegate:class {
    func reload()
}

class OrderListViewModel {
    
    // delegate
    weak var delegate:OrderListViewModelDelegate?
    
    // model
    let model:OrderListModel

    // chunckSize to group network calls
    let chunkSize:Int = 10
    
    init(model:OrderListModel) {
        self.model = model
    }
    
    // calculate all promotion value combination and return the best offer for the user
    var promotionEngine:PromotionEngine?
    
    // data source
    var numberOfItems:Int  = 0
    
    // discounted order price
    var discountOrderPrice:Double = 0
    
    // total order price before discount
    var orderPrice:Double = 0
    
    var totalOrderDetailViewModel:TotalOrderDetailFooterViewModel?
    
    // Order data
    var orderItems:[OrderItem] = []
    {
        didSet{
            // update ui
            numberOfItems = orderItems.count
        }
    }
    
    func getMeal(parametrs: Data)
    {
        // fetch objects from internet connection
        model.fetchMeals(parametrs: parametrs, complition: {[weak self] (meal) in
            
            guard let strongSelf = self else { return }
        
            strongSelf.promotionEngine = PromotionEngine(meal:meal)
            
            // get images from the server and save them local
            strongSelf.getPhotosFor(meal)
            
            // do heavy stuff on the background
            DispatchQueue.global(qos: .default).async {
               
                guard let order = strongSelf.promotionEngine?.getDiscountItems(.bestValue) else { return }
                
                // populte viewModel proporties after getting data from the enging
                strongSelf.updateProperties(order: order)
                
                DispatchQueue.main.async {
                    
                    // get the main queue back and update view
                    strongSelf.delegate?.reload()
                }
            }


            
        }) { (err) in
            print(err)
        }
    }
    
    // update self proprties
    func updateProperties(order:mealItemsValue)
    {
        self.orderItems = order.items
        self.discountOrderPrice = order.discountPrice
        self.orderPrice = order.originalPrice
        self.totalOrderDetailViewModel = TotalOrderDetailFooterViewModel(orderAmount: "\(orderPrice)", discount: "\(orderPrice-discountOrderPrice)", payAmount: "\(discountOrderPrice)")
    }

    
    // calculate new price by promotion type
    func calculatePrice(by:PromotionCalculateType)
    {
        DispatchQueue.global().async {
            guard let order = self.promotionEngine?.getDiscountItems(by) else { return }
            self.updateProperties(order: order)
            DispatchQueue.main.async {
                self.delegate?.reload()
            }
        }

    }
    
    func getPhotosFor(_ meal:Meal)
    {
        let itmes = meal.items.chunked(into: chunkSize)
        
        for item in itmes {
            
            model.fetchImages(orderItems: item, complition: {[weak self] (photos) in
                // save photos to db
                self?.save(photos)
            }) { (error) in
                /// update user
                
            }

        }
        
        
    }
    
    // save images to disk
    func save(_ images:[(UIImage,String)])
    {
        DispatchQueue.global(qos: .background).async {
            /// save images to local DB
            print("save to db")
            ///
        }
    }
    
    
    // get data for cell
    func cell(_ forIndex:IndexPath) -> OrderItem?
    {
        if forIndex.row < orderItems.count  {
            return orderItems[forIndex.row]
        }
        return nil
    }
    
    func getImage(for url:String, complition:((UIImage)->()))
    {
        // get image from disk
        complition(UIImage())
    }
    
}


struct TotalOrderDetailFooterViewModel {
    let orderAmount:String
    let discount:String
    let payAmount:String
}
