//
//  DateExtensions.swift
//  personal expense tracker
//
//  Created by 5433 on 12/2/25.
//

import Foundation

extension Date {
    func timeAgo() -> String {
        let seconds = Int(Date().timeIntervalSince(self))

        if seconds < 60 {
            return "Just now"
        } else if seconds < 3600 {
            return "\(seconds / 60) minutes ago"
        } else if seconds < 86400 {
            return "\(seconds / 3600) hours ago"
        } else if seconds < 172800 {
            return "Yesterday"
        } else {
            return "\(seconds / 86400) days ago"
        }
    }
}
