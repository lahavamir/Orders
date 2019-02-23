//
//  APIService.swift
//  Full app
//
//  Created by Amir lahav on 05/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit


class APIService:APIServiceProtocol {
    
    let session:URLSession
    
    init(session:URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // generic fetch for Decodable objects
    func fetch<T:Decodable>(request:RequestData, type:T.Type, complition:@escaping (Resualt<T>)->())
    {
        
        let session = URLSession.shared
        do {
        let request = try prepare(request: request)
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if let error = error {
                        complition(Resualt.error(APIError.networkError(error)))
                }else{
                    if let object = try? JSONDecoder().decode(T.self, from: data!){
                        complition(Resualt.succes(object))
                    }else{
                        // TODO: popup alert with error
                        }
                }
            })
            
            dataTask.resume()
        }catch{
            
        }
    }
    
    func fetchImage(request:RequestData, complition:@escaping (UIImage)->())
    {
        
    }

    
    func prepare(request:RequestData) throws -> URLRequest
    {
        let headers = [
            "Postman-Token": "e1ed2662-cac0-40c4-9022-56e8c8217d9c,2961aec5-9d0a-4528-b1ef-a46d1160081b",
            "cache-control": "no-cache,no-cache",
            "content-type": "application/json",
            "x-access-token": "yEQ2XUX6343fyRhWDTd4"
        ]
        
        let fullURL = "\(request.baseURL)/\(request.path)"
        guard let url = URL(string: fullURL) else {
            throw APIError.badInput
        }
        var apiRequest = URLRequest(url: url)
        
        switch request.param {
            
        case .url(let param):
            if let param = param {
                let queryItems = param.map { pair in
                    return URLQueryItem(name: pair.key, value: pair.value)
                }
                guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                    throw APIError.badInput
                }
                components.queryItems = queryItems
                apiRequest.url = components.url
            }
            
        case .body(let param):
            apiRequest.httpBody = param
        }

        apiRequest.httpMethod = request.method.rawValue
        apiRequest.allHTTPHeaderFields = headers
        
        return apiRequest
    }
    
    
}
