//
//  ContentView.swift
//  personal expense tracker
//
//  Created by 5433 on 10/26/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView{
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            NotificationView()
                .tabItem{
                    Image(systemName: "bell")
                    Text("Notifications")
                }
            SettingView()
                .tabItem{
                    Image(systemName: "gearshape")
                    Text("Setting")
                }
        }
        .background(.white)
    }
}

#Preview {
    ContentView()
        .environmentObject(ExpenseFunction())
        .environmentObject(CurrencyConverter())
}
