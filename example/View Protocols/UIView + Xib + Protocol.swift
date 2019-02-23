//
//  UIView XIB Protocol.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit



// uniqueIdentifier for dequeue reusable cell
protocol ReusableView {
    
    static var uniqueIdentifier:String {get}
}

// defualt implementation
extension ReusableView where Self:UIView {
    
    static var uniqueIdentifier:String {
        return NSStringFromClass(self)
    }
}


protocol Xibable {
    
    static var nibName:String {get}
}

extension Xibable where Self:UIView {
    
    static var nibName:String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}



