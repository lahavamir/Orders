//
//  HotelListViewController Sort Delegate.swift
//  Hotels
//
//  Created by Amir lahav on 13/02/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit
import DeepDiff


extension OrderListViewController:HeaderProtocolDelegate
{
    // user try diffrent promtion types
    func didSelect(promotionType: PromotionCalculateType) {
        viewModel.calculatePrice(by: promotionType)
    }
    
}

extension OrderListViewController:OrderListViewModelDelegate
{
    // should reload data
    func reload() {
        orderList?.reloadData()
    }
}
