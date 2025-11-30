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

struct categoryData: Identifiable, Codable {
    var id = UUID()
    var catname: String
    var colorHex: String
    var target: Int
}

class ExpenseFunction: ObservableObject {
    @AppStorage("ExpenseData") private var storedData: String = "{}"
    @AppStorage("CategoryData") private var storedCategoryData: String = "{}"
    @Published var expense:[ExpenseItem]=[]
    @Published var category:[categoryData]=[]
    
    init(){
        load()
        loadCategory()
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
            target: target
        )

        category.append(newCategory)
        saveCategory()
    }
    
    func removeCategory(at offsets: IndexSet) {
        category.remove(atOffsets: offsets)
        saveCategory()
    }

    
    
  
    
    
}
