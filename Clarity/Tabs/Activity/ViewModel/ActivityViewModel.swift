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
    
    init(user: User) {
        self.user = user
    }
    
    var dailyDays: [Date] { user.last7Days }
    var dailyCounts: [Date: Int] { user.dailyHistory }
    
    var hourlyTimes: [Date] { user.last7Hours }
    var hourlyCounts: [Date: Int] { user.hourlyHistory }
    
    var averageSmokedString: String {
        guard user.hasEnoughDataForWeeklyStats else { return "--" }
        return String(format: "%.1f", user.weeklyDailyAverage)
    }
    
    var peakTimeString: String {
        guard let hour = user.peakSmokingHour else { return "--" }
        let date = Calendar.current.date(from: DateComponents(hour: hour)) ?? Date()
        return TimeFormatter.hourly.string(from: date).lowercased()
    }
    
    var comparisonString: String {
        guard user.hasEnoughDataForWeeklyStats else { return "--" }
        let percent = user.percentageChangeFromPreviousWeek
        let sign = percent > 0 ? "+" : ""
        return "\(sign)\(Int(percent))% vs last week"
    }

    var comparisonColor: Color {
        guard user.hasEnoughDataForWeeklyStats else { return .secondaryTextCl }
        
        let percent = user.percentageChangeFromPreviousWeek
        
        if percent > 0 {
            return .warningCl
        } else if percent < 0 {
            return .successCl
        } else {
            return .secondaryTextCl
        }
    }
}
