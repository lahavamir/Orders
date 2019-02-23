//
//  APIServiceProtocol.swift
//  Hotels
//
//  Created by Amir lahav on 13/02/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit

protocol APIServiceProtocol {
    
    // generic fetch for Decodable objects
    func fetch<T:Decodable>(request:RequestData, type:T.Type, complition:@escaping (Resualt<T>)->())

    // fetch images
    func fetchImage(request:RequestData, complition:@escaping (UIImage)->())

}
