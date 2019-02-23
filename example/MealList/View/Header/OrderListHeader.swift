//
//  FloatingHeader.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import UIKit

protocol HeaderProtocolDelegate:class {
    
    func didSelect(promotionType:PromotionCalculateType)
}

enum PromotionCalculateType:String
{
    case bestValue
    case bogo
    case percent
    case amount
}


class OrderListHeader: UICollectionReusableView {
    
    
    // color
    
    let lightGray = UIColor.lightGray
    let purple = UIColor.init(red: 111/255, green: 99/255, blue: 133/255, alpha: 1)
    
    // outlet
    
    @IBOutlet weak var bestValueBtn: UIButton!
    @IBOutlet weak var bogo: UIButton!
    @IBOutlet weak var percent: UIButton!
    @IBOutlet weak var amount: UIButton!
    @IBOutlet weak var underlineView: UIView!

    let underlineViewHeight:CGFloat = 3
    var underlineViewY:CGFloat  { return self.underlineView.frame.origin.y }

    
    
    // acction

    @IBAction func percentPressed(_ sender: UIButton) {
        delegate?.didSelect(promotionType: .percent)
        updateUI(sender)

    }
    
    
    @IBAction func bogoPressed(_ sender: UIButton) {
        delegate?.didSelect(promotionType: .bogo)
        updateUI(sender)

    }
    @IBAction func bestValuePressed(_ sender: UIButton) {
        delegate?.didSelect(promotionType: .bestValue)
        updateUI(sender)

    }

    @IBAction func amountPressed(_ sender: UIButton) {
        delegate?.didSelect(promotionType: .amount)
        updateUI(sender)
    }
    
    var btns:[UIButton] { return  [bestValueBtn,bogo,percent,amount]  }
    
    weak var delegate:HeaderProtocolDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
        setUnderlinePosition(bestValueBtn)
        setSelectBtn(bestValueBtn)

    }
    

    func updateUI(_ sender:UIButton)
    {
        setUnderlinePosition(sender)
    }
    
    
    
    func setUnderlinePosition(_ sender:UIButton)
    {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .allowUserInteraction, animations: {
                self.underlineView.frame = CGRect(x: sender.frame.origin.x, y: self.underlineViewY, width: sender.frame.width, height: self.underlineViewHeight)
                self.setSelectBtn(sender)
            }, completion: nil)
        }

    }
    
    func setSelectBtn(_ sender:UIButton)
    {
        for btn in btns {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.setTitleColor(lightGray, for: .normal)
        }
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        sender.setTitleColor(purple, for: .normal)

    }
}




