//
//  User.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 04.02.26.
//

import Foundation
import SwiftData

@Model
class User {
    @Attribute(.unique) var id: String
    var name: String
    var email: String
    var smokingData: SmokingData
    
    @Relationship(deleteRule: .cascade, inverse: \SmokeEntry.user)
    var entries: [SmokeEntry] = []
    
    init(name: String, email: String, smokingData: SmokingData) {
        self.id = UUID().uuidString
        self.name = name
        self.email = email
        self.smokingData = smokingData
    }
}

extension User {
    var dailyHistory: [Date: Int] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: entries) { entry in
            calendar.startOfDay(for: entry.timestamp)
        }
        return grouped.mapValues { $0.count }
    }
    
    var last7Days: [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (0..<7).reversed().compactMap { offset in
            calendar.date(byAdding: .day, value: -offset, to: today)
        }
    }
    
    var hourlyHistory: [Date: Int] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: entries) { entry in
            calendar.dateInterval(of: .hour, for: entry.timestamp)?.start ?? entry.timestamp
        }
        return grouped.mapValues { $0.count }
    }
    
    var last7Hours: [Date] {
        let calendar = Calendar.current
        let currentHour = calendar.dateInterval(of: .hour, for: Date())?.start ?? Date()
        
        return (0..<7).reversed().compactMap { offset in
            calendar.date(byAdding: .hour, value: -offset, to: currentHour)
        }
    }
}
