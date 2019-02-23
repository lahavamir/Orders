//
//  HotelListViewController + CollectionViewDataSource.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit


extension OrderListViewController:UICollectionViewDataSource
{
    
    // collection view data source methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = orderList?.dequeueReusableCell(withReuseIdentifier: OrderItemCollectionViewCell.uniqueIdentifier, for: indexPath) as? OrderItemCollectionViewCell else {
            fatalError("cant register cell")
        }
        
        // get formated data from view model
        guard let data = viewModel.cell(indexPath) else {
            return UICollectionViewCell()
        }
        
        // bind to cell
        cell.bind(data:data)

        // configure cell if needed
        cell.dropShadow()
        
        DispatchQueue.global(qos: .userInitiated).async {
            // get image on background queue
            self.viewModel.getImage(for:data.imageUrl, complition: { (image) in
                // update on main queue
                DispatchQueue.main.async {
                    cell.set(image: image)
                }
            })
        }
        
        return cell
    }    
    
}
