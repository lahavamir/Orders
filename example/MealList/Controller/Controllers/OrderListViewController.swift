//
//  HotelListViewController.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController  {
    

    
    
    
    let viewModel:OrderListViewModel

    // custom inititation
    init(viewModel:OrderListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self

        // fake paramates
        let param = Data()
        // fetch meals from server
        viewModel.getMeal(parametrs: param)
        // Do any additional setup after loading the view.
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // outlets
 
    @IBOutlet weak var orderList: UICollectionView?{
        didSet{
            guard  let hotelList = orderList else {
                return
            }
            
            // common inition
            hotelList.delegate = self
            hotelList.dataSource = self
            hotelList.registerNib(OrderItemCollectionViewCell.self)
            hotelList.registerHeaderNib(OrderListHeader.self)
            hotelList.registerFooterNib(TotalAmountFooterCollectionReusableView.self)
            
            // layout modificaiton
            let layout = UICollectionViewFlowLayout()
            layout.sectionFootersPinToVisibleBounds = true
            hotelList.collectionViewLayout = layout
        }
    }
    
}






