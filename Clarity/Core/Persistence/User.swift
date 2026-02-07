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

extension User {
    var hasEnoughDataForWeeklyStats: Bool {
        guard let firstEntry = entries.sorted().first else { return false }
        
        let daysSinceStart = Calendar.current.dateComponents([.day], from: firstEntry.timestamp, to: Date()).day ?? 0
        
        return daysSinceStart >= 7
    }
    
    var recentEntries: [SmokeEntry] {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        guard let sevenDaysAgo = calendar.date(byAdding: .day, value: -6, to: todayStart) else { return [] }
        return entries.filter { $0.timestamp >= sevenDaysAgo }
    }
    
    var weeklyDailyAverage: Double {
        let totalSmoked = Double(recentEntries.count)
        return totalSmoked / 7.0
    }
    
    var peakSmokingHour: Int? {
        let entries = recentEntries
        guard !entries.isEmpty else { return nil }
        
        let hourlyCounts = Dictionary(grouping: entries) { entry in
            Calendar.current.component(.hour, from: entry.timestamp)
        }
        return hourlyCounts.max(by: { $0.value.count < $1.value.count })?.key
    }
    
    var percentageChangeFromPreviousWeek: Double {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        
        let currentAvg = weeklyDailyAverage
        
        guard let startOfPrevWeek = calendar.date(byAdding: .day, value: -13, to: todayStart),
              let endOfPrevWeek = calendar.date(byAdding: .day, value: -7, to: todayStart) else {
            return 0.0
        }
        
        let prevEntries = entries.filter {
            $0.timestamp >= startOfPrevWeek && $0.timestamp < endOfPrevWeek
        }
        
        let prevAvg = Double(prevEntries.count) / 7.0
        
        if prevAvg == 0 {
            return 0.0
        }
        
        return ((currentAvg - prevAvg) / prevAvg) * 100
    }
}
