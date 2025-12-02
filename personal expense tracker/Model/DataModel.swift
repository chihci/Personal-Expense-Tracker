//
//  DataModel.swift
//  personal expense tracker
//
//  Created by 5433 on 10/27/25.
//

import Foundation
import SwiftUI

struct ExpenseCategory: Identifiable {
    var id = UUID()
    var name: String
    var amount: Double
    var target: Double
    var color: Color
}

struct HistoryList: Identifiable {
    var id = UUID()
    var name: String
    var amount: Double
    var date: String
    var category: String
    var note: String
    var color: Color
}




let expenseData = [
    ExpenseCategory(name: "Food", amount: 320, target: 300, color: .red),
    ExpenseCategory(name: "Transportation", amount: 150, target: 200, color: .blue),
    ExpenseCategory(name: "Shopping", amount: 450, target: 400, color: .orange),
    ExpenseCategory(name: "Bills", amount: 280, target: 200, color: .purple),
    ExpenseCategory(name: "Entertainment", amount: 200, target: 100, color: .pink)
]


let historyData = [
    HistoryList(name: "Food", amount: 100, date: "Today", category: "Food", note: "Lunch with friends", color: .red),
    HistoryList(name: "Salary", amount: 1000, date: "Today", category: "Income", note: "Salary from job",color: .blue)
]



enum ExpenseError: LocalizedError, Identifiable {
    case invalidAmount
    case emptyName
    case emptyCategory
    case invalidDate
    
    var id: String { UUID().uuidString }

    var errorDescription: String? {
        switch self {
        case .invalidAmount:
            return "Please enter a valid number for the amount."
        case .emptyName:
            return "Name cannot be empty."
        case .emptyCategory:
            return "Please select or enter a category."
        case .invalidDate:
            return "Please enter a valid date."
        }
    }
}

struct CurrencyResponse: Codable {
    let data: [String: Double]
}


struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var amount: Double
    var date: String//for text only
    var category: String
    var note: String
    var eventdate: String
    var categoryID: UUID
}

struct categoryData: Identifiable, Codable, Hashable {
    var id = UUID()
    var catname: String
    var colorHex: String
    var target: Double
}

struct NotificationMessage: Identifiable, Codable, Hashable {
    var id = UUID()
    var title: String
    var body: String
    var imageString: String
    var date: String
}

class ExpenseFunction: ObservableObject {
    @AppStorage("ExpenseData") private var storedData: String = "{}"
    @AppStorage("CategoryData") private var storedCategoryData: String = "{}"
    @AppStorage("NotificationMesaage") private var storednotification: String = "{}"
    @AppStorage("alertsEnabled") var alertsEnabled: Bool = true
    
    //notification_messages
    @Published var expense:[ExpenseItem]=[]
    @Published var category:[categoryData]=[]
    @Published var messages:[NotificationMessage]=[]
    
    @Published var showBanner: Bool = false
    @Published var bannerTitle: String = ""
    @Published var bannerMessage: String = ""

    init(){
        load()
        loadCategory()
        loadNotification()
    }
    
    private func load() {
        if let data = storedData.data(using: .utf8),//json only accept data not string
           let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: data) {//converting data in json back to swift data
            expense = decoded
        }else {
            expense = []
        }
    }
    
    
    private func loadCategory() {
        if let data = storedCategoryData.data(using: .utf8),//json only accept data not string
            let decoded = try? JSONDecoder().decode([categoryData].self, from: data) {//converting data in json back to swift data
             category = decoded
         }else {
             category = []
         }
    }
    
    private func loadNotification() {
        if let data = storednotification.data(using: .utf8),//json only accept data not string
            let decoded = try? JSONDecoder().decode([NotificationMessage].self, from: data) {//converting data in json back to swift data
            messages = decoded
         }else {
             messages = []
         }
    }
    
    private func save() {
        if let json = try? JSONEncoder().encode(expense) {
            storedData = String(data: json, encoding: .utf8) ?? "{}"
        }
        
      
    }
    
    private func saveCategory() {
        if let json = try? JSONEncoder().encode(category) {
            storedCategoryData = String(data: json, encoding: .utf8) ?? "{}"
         }
    }
    
    private func saveNotification() {
        if let json = try? JSONEncoder().encode(messages) {
            storednotification = String(data: json, encoding: .utf8) ?? "{}"
         }
    }

    
    private func todayString() -> String {//return a string
        let formatter = DateFormatter()//telling formatter how to convert a date to string
        formatter.dateFormat = "yyyy-MM-dd"//tells what format we want
        return formatter.string(from: .now)//gives me the current date
    }
    
    func addExpense(name: String, amount: Double, category: String, note: String, eventdate: String) {

        let newExpense = ExpenseItem(
            name: name,
            amount: amount,
            date: eventdate,
            category: category,
            note: note,
            eventdate: eventdate,
            categoryID: UUID()
        )

        expense.append(newExpense)  
        save()
    }
    
    func removeExpense(at offsets: IndexSet) {
        expense.remove(atOffsets: offsets)
        save()
    }
    
    
    func addCategory(catname: String, color: Color, target: Int) {
        let hex = color.toHex() ?? "#000000"

        let newCategory = categoryData(
            catname: catname,
            colorHex: hex,
            target: Double(target)
        )

        category.append(newCategory)
        saveCategory()
    }
    
    func removeCategory(at offsets: IndexSet) {
        category.remove(atOffsets: offsets)
        saveCategory()
    }

    func totalamount() -> Double {
        var total: Double = 0
        for item in expense {
            total += item.amount
        }
        
        return total
    }
    
  
    func checkNotification(for category: categoryData, newAmount: Double) {
        
        // 1. Compute total for this category after adding the new amount
        let total = expense
            .filter { $0.category == category.catname }
            .map(\.amount)
            .reduce(0, +)

        // 2. Check overspend
        if total > Double(category.target) {
            overspend(amount: total, category: category)
        }

        // 3. Largest previous purchase BEFORE adding the new one
        let largestPrevious = expense
            .filter { $0.category == category.catname }
            .map(\.amount)
            .max() ?? 0
        
    
        // 4. Check if new amount is the largest purchase
        if newAmount > largestPrevious {
            largePurchase(amount: newAmount)
        }
    }

    
    func overspend(amount:Double, category: categoryData){//make message and put it in notification array
        
        let result = amount-category.target
        let display = String(format: "%.2f", result)
        let newNotification = NotificationMessage(
            id: UUID(),
            title: "Overspend Alert!",
            body: "You have overspent your target amount for \(display)",
            imageString: "exclamationmark.circle.fill",
            date: "date"
        )
        
        messages.append(newNotification)
        showAlertBanner(
                title: "Overspend Alert!",
                message: "You exceeded your budget by \(display)"
            )
        saveNotification()
    }
    
    func largePurchase(amount:Double){//make message and put it in notification array
        
        let newNotification = NotificationMessage(
            id: UUID(),
            title: "Large Purchase Alert!",
            body: "You just made a large purchase of \(amount)",
            imageString: "exclamationmark.circle.fill",
            date: "date"
        )
        messages.append(newNotification)
        showAlertBanner(
            title: "Large Purchase Alert!",
            message: "You spent \(amount) in a single purchase"
        )
        saveNotification()

    }
    
    func removeNotification(at offsets: IndexSet) {
        messages.remove(atOffsets: offsets)
        saveNotification()
    }
    
    func showAlertBanner(title: String, message: String) {
            guard alertsEnabled else { return }

            bannerTitle = title
            bannerMessage = message
            withAnimation { showBanner = true }

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation { self.showBanner = false }
            }
        }
}
