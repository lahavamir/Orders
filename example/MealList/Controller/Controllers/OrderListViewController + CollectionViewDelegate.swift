//
//  HotelListViewController + CollectionViewDelegate.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit

extension OrderListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    //MARK: collection view delegate methods
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width - cardMargin * 2
        return CGSize(width: width, height: cardHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets (top: 4, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        switch kind {

        case UICollectionView.elementKindSectionFooter:
            
            // dequeue footer
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: TotalAmountFooterCollectionReusableView.uniqueIdentifier, for: indexPath) as? TotalAmountFooterCollectionReusableView, let data = viewModel.totalOrderDetailViewModel else { return UICollectionReusableView()}
                
                view.bind(data: data)
                
                return view
            
        case UICollectionView.elementKindSectionHeader:
            
            // dequeue header and set delegate
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OrderListHeader.uniqueIdentifier, for: indexPath) as? OrderListHeader else { return UICollectionReusableView()}
                    view.delegate = self
            return view
            
        default:
            return UICollectionReusableView()
        }
        

    }
}
