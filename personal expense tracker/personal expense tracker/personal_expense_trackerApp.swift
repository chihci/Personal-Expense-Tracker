//
//  personal_expense_trackerApp.swift
//  personal expense tracker
//
//  Created by 5433 on 10/26/25.
//

import SwiftUI

@main
struct personal_expense_trackerApp: App {
    @StateObject private var expenseData1 = ExpenseFunction()
    @StateObject private var currencyConverter = CurrencyConverter()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(expenseData1)
                .environmentObject(currencyConverter) 
        }
    }
}
