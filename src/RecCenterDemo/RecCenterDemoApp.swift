//
//  RecCenterDemoApp.swift
//  RecCenterDemo
//
//  Created by Ankit Khandelwal on 2/19/21.
//

import SwiftUI

@main

struct RecCenterDemoApp: App {
    @StateObject var cart = Cart()
    @StateObject var helper:Helper = Helper()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cart)
                .environmentObject(helper)
        }
    }
}

class Helper: ObservableObject{
    @Published var viewShown:Bool = false
    @Published var activityChosen:String = ""
}
