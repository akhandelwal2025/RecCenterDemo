//
//  Cart.swift
//  RecCenterDemo
//
//  Created by Ankit Khandelwal on 2/19/21.
//

import Foundation

class Cart: ObservableObject{
    @Published var cartList:Array<String> = []
    func addToCart(activityName:String){
        if !checkCart(activityName: activityName){
            cartList.append(activityName)
        }
            
    }
    
    func removeFromCart(activityName:String){
        cartList.remove(at: cartList.firstIndex(of: activityName)!)
    }
    func checkCart(activityName:String) -> Bool{
        for cartActivity in cartList{
            if activityName == cartActivity{
                return true
            }
        }
        return false
    }
    
    func getCart() -> Array<String>{
        return cartList
    }
}
