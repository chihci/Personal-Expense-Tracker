//
//  ExpenseError.swift
//  personal expense tracker
//
//  Created by 5433 on 12/2/25.
//

import Foundation

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
