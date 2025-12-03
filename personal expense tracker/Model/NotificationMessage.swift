//
//  NotificationMessage.swift
//  personal expense tracker
//
//  Created by 5433 on 12/2/25.
//

import Foundation

struct NotificationMessage: Identifiable, Codable, Hashable {
    var id = UUID()
    var title: String
    var body: String
    var imageString: String
    var date: Date = Date()
}
