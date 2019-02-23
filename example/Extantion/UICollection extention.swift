//
//  UITableView Extention.swift
//  Full app
//
//  Created by Amir lahav on 04/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit


extension UICollectionReusableView: ReusableView,Xibable{}

extension UICollectionView
{
    
    
    // register collection view cell
    func registerNib<T:UICollectionViewCell>(_:T.Type){
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forCellWithReuseIdentifier: T.uniqueIdentifier)
    }
    
    // register collection view header/footer
    func registerHeaderNib<T:UICollectionReusableView>(_:T.Type)
    {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.uniqueIdentifier)
    }
    
    func registerFooterNib<T:UICollectionReusableView>(_:T.Type)
    {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.uniqueIdentifier)
    }
}
