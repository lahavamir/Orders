//
//  RequestData.swift
//  Full app
//
//  Created by Amir lahav on 05/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation


public enum HTTPMethod:String
{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    /// and more
}

public enum RequesParametres
{
    case url(_ : [String:String]?)
    case body(_ : Data)
}

public protocol RequestPorotocol
{
    var baseURL:String { get }
    var path:String { get }
    var method:HTTPMethod { get }
    var param:RequesParametres { get }
    var headers:[String:Any] { get }
}

extension RequestPorotocol
{
    var param:RequesParametres  {
        return  .url([:])
    }
    var headers:[String:String] {
        return [:]
    }
}

enum APIError:Error
{
    case networkError(Error)
    case badInput
}

enum Resualt<T:Decodable>
{
    case succes(T)
    case error(APIError)
}


struct RequestData:RequestPorotocol
{
    let baseURL: String
    let path: String
    let method: HTTPMethod
    let headers: [String : Any]
    let param: RequesParametres
    
    init(baseURL:String,
         path:String,
         method:HTTPMethod = .get,
         headers:[String:Any] = [:],
         param:RequesParametres = .url([:])) {
        
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
        self.param = param
    }
    
}
