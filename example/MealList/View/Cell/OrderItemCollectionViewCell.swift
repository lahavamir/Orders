//
//  OrderItemCollectionViewCell.swift
//  Hotels
//
//  Created by Amir lahav on 22/02/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import UIKit

class OrderItemCollectionViewCell: UICollectionViewCell {

    // varibles
    var shadowDropped:Bool = false
    
    @IBOutlet weak var previousPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemsDiscountPrice: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    func dropShadow()
    {
        if !shadowDropped {
            
            // round corners
            self.contentView.layer.cornerRadius = 4.0
            self.contentView.layer.borderWidth = 0.0
            self.contentView.layer.borderColor = UIColor.clear.cgColor
            self.contentView.layer.masksToBounds = true
            
            // drop shadow
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            self.layer.shadowRadius = 4.0
            
            // better preformance without opacity
            self.layer.shadowOpacity = 1.0
            
            
            self.layer.masksToBounds = false
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
            
            shadowDropped = true
        }
    }
    
    func bind(data: OrderItem)
    {
        guard let calculatePrice =  data.itemPrice, let originalPrice = Double(data.price) else { return }
        itemName.text = data.itemId
        itemsDiscountPrice.text = String(data.itemPrice!)
        
        if calculatePrice < originalPrice {
            previousPrice.text = "Was: \(data.price)"
        }
    }
    
    func set(image:UIImage){
        
    }
    
    override func prepareForReuse() {
        itemName.text = ""
        itemsDiscountPrice.text = ""
        previousPrice.text = ""
    }
}
