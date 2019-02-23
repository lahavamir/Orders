//
//  TotalAmountFooterCollectionReusableView.swift
//  Hotels
//
//  Created by Amir lahav on 22/02/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import UIKit

class TotalAmountFooterCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var pay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(data:TotalOrderDetailFooterViewModel){
        totalAmount.text = data.orderAmount
        discount.text = data.discount
        pay.text = data.payAmount
    }
    
}
