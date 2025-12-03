//
//  CategoryData.swift
//  personal expense tracker
//
//  Created by 5433 on 12/2/25.
//

import Foundation

struct categoryData: Identifiable, Codable, Hashable {
    var id = UUID()
    var catname: String
    var colorHex: String
    var target: Double
}
