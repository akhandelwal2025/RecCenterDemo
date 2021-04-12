//
//  ItemRow.swift
//  RecCenterDemo
//
//  Created by Ankit Khandelwal on 2/19/21.
//

import SwiftUI

struct ItemRow: View {
    var activityName:String
    var isInCart:Bool
    
    var body: some View {
        HStack{
            Text(activityName)
                .padding(.horizontal)
            Spacer()
            if isInCart{
                Image(systemName: "checkmark.circle")
                    .padding(.horizontal)
            }
            else{
                Image(systemName: "checkmark.circle")
                    .padding(.horizontal)
                    .hidden()
            }
            
        }
        
        
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(activityName: "yo man", isInCart: false)
    }
}
