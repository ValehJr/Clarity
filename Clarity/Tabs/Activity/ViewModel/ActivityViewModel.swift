//
//  RhythmViewModel.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 06.02.26.
//

import Combine
import Foundation
import SwiftUI

class ActivityViewModel: ObservableObject {
    @Published var user: User
    @Published var dailyDays: [Date] = []
    @Published var dailyCounts: [Date: Int] = [:]
    
    @Published var hourlyTimes: [Date] = []
    @Published var hourlyCounts: [Date: Int] = [:]
    
    @Published var averageSmokedString: String = "--"
    @Published var peakTimeString: String = "--"
    @Published var comparisonString: String = "--"
    @Published var comparisonColor: Color = .secondaryTextCl
    
    init(user: User) {
        self.user = user
        refreshStats()
    }
    
    func refreshStats() {
        self.dailyDays = SmokingStatsService.getLast7Days()
        self.dailyCounts = SmokingStatsService.getDailyHistory(entries: user.entries)
        
        self.hourlyTimes = SmokingStatsService.getLast7Hours()
        self.hourlyCounts = SmokingStatsService.getHourlyHistory(entries: user.entries)
        
        let stats = SmokingStatsService.getDetailedWeeklyStats(entries: user.entries)
        
        if stats.hasEnoughData {
            self.averageSmokedString = String(format: "%.1f", stats.average)
            
            if let peak = stats.peakHour {
                let date = Calendar.current.date(from: DateComponents(hour: peak)) ?? Date()
                self.peakTimeString = TimeFormatter.hourly.string(from: date).lowercased()
            } else {
                self.peakTimeString = "--"
            }
            
            let sign = stats.percentChange > 0 ? "+" : ""
            self.comparisonString = "\(sign)\(Int(stats.percentChange))% vs last week"
            
            if stats.percentChange > 0 {
                self.comparisonColor = .warningCl
            } else if stats.percentChange < 0 {
                self.comparisonColor = .successCl
            } else {
                self.comparisonColor = .secondaryTextCl
            }
            
        } else {
            self.averageSmokedString = "--"
            self.peakTimeString = "--"
            self.comparisonString = "--"
            self.comparisonColor = .secondaryTextCl
        }
    }
}
