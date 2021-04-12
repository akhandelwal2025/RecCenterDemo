//
//  CartView.swift
//  RecCenterDemo
//
//  Created by Ankit Khandelwal on 2/19/21.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: Cart
    var body: some View {
        List{
            let cartList:Array<String> = cart.getCart()
            ForEach(cartList, id: \.self){ activity in
                ItemRow(activityName: activity, isInCart: false)
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
