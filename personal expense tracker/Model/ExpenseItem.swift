//
//  ExpenseItem.swift
//  personal expense tracker
//
//  Created by 5433 on 12/2/25.
//

import Foundation

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
