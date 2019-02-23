//
//  PromotionEngine.swift
//  Hotels
//
//  Created by Amir lahav on 22/02/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation

typealias mealItemsValue = (items:[OrderItem], originalPrice:Double, discountPrice:Double)


protocol PromotionEngineProtocol {
    
    func getDiscountItems(_ promotion:PromotionCalculateType ) -> mealItemsValue?
}

class PromotionEngine:NSObject, PromotionEngineProtocol {
    

    private let meal:Meal
    
    // dependency injection
    // engine can be tested with any meal
    
    init(meal:Meal) {
        self.meal = meal
    }
    
    
    // MARK: API
    
    // get new array of items, original order price, and price after discount
    public func getDiscountItems(_ promotion:PromotionCalculateType ) -> mealItemsValue?
    {

        // calculate each discount option
        let bogoMeal = calaculateMealValue(meal, byDiscountType: .BOGO)
        let percentMeal = calaculateMealValue(meal, byDiscountType: .PERCENT)
        let amountMeal = calaculateMealValue(meal, byDiscountType: .AMOUNT)
        let  mealDiscountOptions:[mealItemsValue] = [bogoMeal,percentMeal, amountMeal]
        
        switch promotion {
        case .bestValue:
            // get the minimum value
            return mealDiscountOptions.min(by: { (a, b) in
                return a.discountPrice < b.discountPrice
            })
        case .bogo:
            return bogoMeal
        case .percent:
            return percentMeal
        case .amount:
            return amountMeal
        }

        
    }
  
    // MARK: Calculation functions
    
    private func calaculateMealValue(_ meal: Meal, byDiscountType:DiscountType) -> mealItemsValue
    {
        
        let mealOrginalPrice = getOriginalPrice(items: meal.items)
        
        // get promotion
        guard let promotion = self.getPromotion(meal.promotions, for: byDiscountType) else {
            return (meal.items, mealOrginalPrice, mealOrginalPrice)
        }
        
        // empty items array
        var items:[OrderItem] = []
        
        switch byDiscountType {
        
        case .BOGO:

            // get new items base on promotion - buy one get one
            items = self.discount(items: meal.items, condition: promotion.condition)

            
        case .PERCENT:
            
            // get new items base on percent condition on specific items
            items = self.discount(items: meal.items, promotion: promotion)

            
        case .AMOUNT:
            
            // get promotion
            guard let value = promotion.value else {
                return (meal.items, mealOrginalPrice, mealOrginalPrice)
            }
            
            // get new items base on constant discout amount
            items = self.discount(items: meal.items, byValue: value)
            

            
        }
        
        // calculate new price
        let newPprice = self.getMealPrice(items: items)
        print("new price is: \(newPprice)")
        
        
        // return new items, original price, discount price
        return (items, mealOrginalPrice, newPprice)
        
        
    }
    

    
    // calculate discount base on item list - PERCENT
    // param: - items: list of order items
    //        - promotion: hold list of discount prices and discount value
    // return:- array of order items
    // time complexity: O(n)
    private func discount(items:[OrderItem], promotion:Promotion) -> [OrderItem]
    {
        
        // unwarp instance
        guard let itemsPromot = promotion.condition?.items, let strValue = promotion.value, let calculateValue = Double(strValue) else { return items }
        
        // loop though all items and check if item is on discount
        // apply discount to items and return new array of items
        return items.map({ (item) in
            guard let itemPrice = Double(item.price) else { return item }
            var newItem = item
            if itemsPromot.contains(item.itemId) {
                // item is in discount item list
                // apply discount
                newItem.itemPrice = itemPrice * (1 - calculateValue/100)
                return newItem
            }else {
                newItem.itemPrice = itemPrice
                return newItem
            }
        })
    }
    
    // calculate discount base on value - AMOUNT
    // param: - items: list of order items
    //        - byValue: discount value
    // return:- array of order items
    // time complexity: O(n)
    private func discount(items:[OrderItem], byValue:String?) -> [OrderItem]
    {
        // unwarp instance
        guard let strValue = byValue, let calculateValue = Double(strValue) else { return items }
        
        // loop through every item and apply constant discount
        return items.map({ (item) in
            
                var newItem = item
                guard let itemPrice = Double(item.price) else { return item }
                newItem.itemPrice = itemPrice * (1 - calculateValue/100)
                return newItem
        })
    }
    
    
    
    // calculate discount base buy one get one for free - BOGO
    // param: - items: list of order items
    //        - condition: hold buy item and free item
    // return:- array of order items
    // time complexity: O(n)
    private func discount(items:[OrderItem], condition:Condition?) -> [OrderItem]
    {
        var orderItems:[OrderItem] = []
        
        // loop through every item and apply normal prices
        orderItems = items.map({ (item) in
            var newItem = item
            newItem.itemPrice = Double(item.price) ?? 0
            return newItem
        })
        
        // unwarp instance
        guard let condition = condition, let buyItem = condition.buyItemId, let getItem = condition.getItemId else { return items }
        
        // check if both items are in user order
        if orderItems.contains(where: {$0.itemId == buyItem}) && orderItems.contains(where: {$0.itemId == getItem})
        {
            print("both item here")
            // find the first instance and make it free of charge
            
            if let index = orderItems.index(where: {$0.itemId == getItem}){
                orderItems[index].update(price: 0)
            }
            
        }

        return orderItems
    }
    
    
    
    //MARK: helpers
    
    func getPromotion(_ promotions:[Promotion], for discount:DiscountType) -> Promotion?
    {
        let promotion = promotions.filter({$0.type == discount.rawValue}).compactMap({return $0})
        
        return promotion.first
        
    }
    
    
    func getMealPrice(items:[OrderItem]) -> Double
    {
        return items.reduce(0, { (result, item) in
            let price = item.itemPrice ?? 0
            return result + price
        })
    }
    
    func getOriginalPrice(items:[OrderItem]) -> Double
    {
        return items.reduce(0, { (result, item) in
            let price = Double(item.price) ?? 0
            return result + price
        })
    }
    
}



enum DiscountType:String
{
    case BOGO
    case PERCENT
    case AMOUNT
}
