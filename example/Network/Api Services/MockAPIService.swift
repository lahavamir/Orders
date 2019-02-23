//
//  MockAPIService.swift
//  Hotels
//
//  Created by Amir lahav on 13/02/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit

class MockAPIService: APIServiceProtocol {
    
    // generic fetch for Decodable objects
    func fetch<T:Decodable>(request:RequestData, type:T.Type, complition:@escaping (Resualt<T>)->())
    {
        
        guard let data:T = loadJson(filename: "OrderResponse") as? T else {
            return
        }
        
        // on complition
        complition(Resualt.succes(data))
    }
    
    func fetchImage(request:RequestData, complition:@escaping (UIImage)->())
    {
        let image = UIImage()
        complition(image)
    }
    
    // helper load json file and parse it to Hotels array
    
    func loadJson(filename fileName: String) -> Meal? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Meal.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    
}
