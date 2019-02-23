//
//  Hotel.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit

class OrderListModel:NSObject {
    
    // api service conform to APIServiceProtocol
    let apiService:APIServiceProtocol
    
    
    // initiation with conform to api protocol
    init<T:APIServiceProtocol>(apiService:T) {
        self.apiService = apiService
    }
    
    
    // fetch hotels
    func fetchMeals(parametrs:Data, complition:@escaping ((Meal)->()), error:@escaping ((String)->()))
    {
        
        // create request
        let request = RequestData(baseURL: "base url", path: "path", method: .get, headers: [:], param: .body(parametrs))
        
        // submit request
        apiService.fetch(request: request, type: Meal.self) { (result) in
            switch result
            {
            case .succes(let meal):
                complition(meal)
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    // fetch images from server
    func fetchImages(orderItems:[OrderItem], complition:@escaping (([(UIImage,String)])->()), error:@escaping ((String)->()))
    {
        let group = DispatchGroup()
        var images:[(UIImage,String)] = []
        
        // loop through items in array and make each one of the call for image.
        // when all photos are download send it back for saving to local DB
        for item in orderItems
        {
            group.enter()
            
            // create dummy request
            let request = RequestData(baseURL: "\(item.imageUrl)", path: "path", method: .get, headers: [:], param: .url(nil))
            
            // submit request
            apiService.fetchImage(request: request) { (image) in

                // simulate call to server takes 0...5 seconeds
                let fraction = Double.random(in: 0 ..< 5)

                DispatchQueue.main.asyncAfter(deadline: .now() + fraction, execute: {
                    
                    images.append((image,"\(item.imageUrl)"))
                    
                    group.leave()
                })

                
                
            }
        }
        
        group.notify(queue: .global()) {
            complition(images)
        }
    }
    
    

}




// meal contain items and promotion
struct Meal:Codable {
    let items:[OrderItem]
    let promotions:[Promotion]
}

// order item
struct OrderItem:Codable,Hashable
{
    let itemId:String
    let price:String
    let imageUrl:String
    var itemPrice:Double?
    
    mutating func update(price:Double)
    {
        itemPrice = price
    }
}

// every meal has 3 type of promotion
// BOGO - buy one get one
// PERCENT - discount of particular items
// AMOUNT - diccount amount of all order

struct Promotion:Codable {
    let promotionId:String
    let type:String
    let condition:Condition?
    let value:String?
}

struct Condition:Codable {
    let buyItemId:String?
    let getItemId:String?
    let items:[String]?
}
