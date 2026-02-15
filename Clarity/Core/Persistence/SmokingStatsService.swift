//
//  SmokingStatsService.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 12.02.26.
//


import Foundation
import SwiftData

struct SmokingStatsService {
    static func costPerCigarette(for data: SmokingData) -> Double {
        guard data.packSize > 0 else { return 0 }
        return data.packPrice / Double(data.packSize)
    }
    
    static func expectedCigarettes(since startDate: Date, dailyAverage: Int) -> Int {
        let calendar = Calendar.current
        let daysPassed = calendar.dateComponents([.day], from: startDate, to: Date()).day ?? 0
        let adjustedDays = max(1, daysPassed)
        return adjustedDays * dailyAverage
    }
    
    static func calculateMoneyImpact(user: User) -> Double {
        let data = user.smokingData
        
        let startDate = user.entries.sorted().first?.timestamp ?? Date()
        
        let actualSmokedCount = user.entries.count
        let expectedCount = expectedCigarettes(since: startDate, dailyAverage: data.dailyAverage)
        
        let avoidedCount = expectedCount - actualSmokedCount
        let singleCost = costPerCigarette(for: data)
        
        return Double(avoidedCount) * singleCost
    }
    
    static func calculateTimeReclaimed(user: User) -> Double {
        let data = user.smokingData
        let minutesPerCigarette = 17.0
        
        let startDate = user.entries.sorted().first?.timestamp ?? Date()
        let actualSmokedCount = user.entries.count
        let expectedCount = expectedCigarettes(since: startDate, dailyAverage: data.dailyAverage)
        
        let avoidedCount = expectedCount - actualSmokedCount
        
        return Double(avoidedCount) * minutesPerCigarette
    }
    
    static func calculateCigarettesAvoided(user: User) -> Int {
        let data = user.smokingData
        let startDate = user.entries.sorted().first?.timestamp ?? Date()
        let actualSmokedCount = user.entries.count
        let expectedCount = expectedCigarettes(since: startDate, dailyAverage: data.dailyAverage)
        
        return max(0, expectedCount - actualSmokedCount)
    }
    
    static func getLast7Days() -> [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (0..<7).reversed().compactMap { offset in
            calendar.date(byAdding: .day, value: -offset, to: today)
        }
    }
    
    static func getDailyHistory(entries: [SmokeEntry]) -> [Date: Int] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: entries) { entry in
            calendar.startOfDay(for: entry.timestamp)
        }
        return grouped.mapValues { $0.count }
    }
    
    static func getLast7Hours() -> [Date] {
        let calendar = Calendar.current
        let currentHour = calendar.dateInterval(of: .hour, for: Date())?.start ?? Date()
        return (0..<7).reversed().compactMap { offset in
            calendar.date(byAdding: .hour, value: -offset, to: currentHour)
        }
    }
    
    static func getHourlyHistory(entries: [SmokeEntry]) -> [Date: Int] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: entries) { entry in
            calendar.dateInterval(of: .hour, for: entry.timestamp)?.start ?? entry.timestamp
        }
        return grouped.mapValues { $0.count }
    }
    
    static func getDetailedWeeklyStats(entries: [SmokeEntry]) -> (average: Double, peakHour: Int?, percentChange: Double, hasEnoughData: Bool) {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        
        guard let firstEntry = entries.min() else {
            return (0, nil, 0, false)
        }
        let startOfFirstDay = calendar.startOfDay(for: firstEntry.timestamp)
        let daysSinceStart = calendar.dateComponents([.day], from: startOfFirstDay, to: todayStart).day ?? 0
        
        let hasEnoughData = daysSinceStart >= 7
        
        guard let sevenDaysAgo = calendar.date(byAdding: .day, value: -6, to: todayStart) else {
            return (0, nil, 0, hasEnoughData)
        }
        
        let recentEntries = entries.filter { $0.timestamp >= sevenDaysAgo }
        let currentAvg = Double(recentEntries.count) / 7.0
        
        var peakHour: Int? = nil
        if !recentEntries.isEmpty {
            let hourlyCounts = Dictionary(grouping: recentEntries) {
                calendar.component(.hour, from: $0.timestamp)
            }
            peakHour = hourlyCounts.max(by: { $0.value.count < $1.value.count })?.key
        }
        
        var percentChange: Double = 0.0
        
        if let startOfPrevWeek = calendar.date(byAdding: .day, value: -13, to: todayStart),
           let endOfPrevWeek = calendar.date(byAdding: .day, value: -7, to: todayStart) {
            
            let prevEntries = entries.filter {
                $0.timestamp >= startOfPrevWeek && $0.timestamp < endOfPrevWeek
            }
            let prevAvg = Double(prevEntries.count) / 7.0
            
            if prevAvg > 0 {
                percentChange = ((currentAvg - prevAvg) / prevAvg) * 100
            }
        }
        
        return (currentAvg, peakHour, percentChange, hasEnoughData)
    }
}
