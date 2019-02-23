//
//  Coordinator Porotocol.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit


// coordinator protocl. every flow start with coordinator
protocol Coordinator {
    
    var pressenter:UINavigationController { get }
    func start()
}
