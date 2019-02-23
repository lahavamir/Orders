//
//  Array extention.swift
//  Hotels
//
//  Created by Amir lahav on 23/02/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
