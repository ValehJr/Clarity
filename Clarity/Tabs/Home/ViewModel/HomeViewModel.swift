//
//  HomeViewModel.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 03.02.26.
//

import Combine
import Foundation
import SwiftData

class HomeViewModel: ObservableObject {
    @Published var user: User
    private let calendar = Calendar.current
    
    var cigarettesSmokedToday: Int {
        user.entries.filter { calendar.isDateInToday($0.timestamp) }.count
    }
    
    var hourlyBreakdownForToday: [Int: Int] {
        let todayEntries = user.entries.filter { calendar.isDateInToday($0.timestamp) }
        
        let grouped = Dictionary(grouping: todayEntries) { entry in
            calendar.component(.hour, from: entry.timestamp)
        }
        
        return grouped.mapValues { $0.count }
    }
    
    var dailyHistory: [Date: Int] {
        let grouped = Dictionary(grouping: user.entries) { entry in
            calendar.startOfDay(for: entry.timestamp)
        }
        
        return grouped.mapValues { $0.count }
    }
    
    init(user: User) {
        self.user = user
    }
    
    func addNewSmoke(context: ModelContext) {
        let newEntry = SmokeEntry(timestamp: Date())
        
        user.entries.append(newEntry)
        
        try? context.save()
        objectWillChange.send()
    }
}

extension HomeViewModel {
    
    var calendarRange: [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        let range = (0..<30).compactMap { offset -> Date? in
            calendar.date(byAdding: .day, value: -offset, to: today)
        }
    
        return range.reversed()
    }
    
    var calendarCounts: [Date: Int] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: user.entries) { entry in
            calendar.startOfDay(for: entry.timestamp)
        }

        return grouped.mapValues { $0.count }
    }
}

//extension HomeViewModel {
//    func loadMockData() {
//        let data = generateMockCalendarData()
//        self.calendarRange = data.range
//        self.calendarCounts = data.counts
//        
//    }
//    
//    private func generateMockCalendarData() -> (range: [Date], counts: [Date: Int]) {
//        let calendar = Calendar.current
//        let today = Date()
//        
//        let range = (0..<30).compactMap { offset -> Date? in
//            calendar.date(byAdding: .day, value: -offset, to: today)
//        }.reversed()
//        
//        var counts: [Date: Int] = [:]
//        let mockCounts = [7, 0, 3, 0, 5, 6, 0,
//                          0, 9, 10, 0, 12, 0, 0,
//                          15, 0, 0, 18, 0, 20, 21,
//                          0, 0, 24, 25, 0, 27, 0,
//                          0, 30]
//        
//        for (index, date) in range.enumerated() {
//            let dayKey = calendar.startOfDay(for: date)
//            let isFuture = date > today && !calendar.isDateInToday(date)
//            
//            if !isFuture && index < mockCounts.count {
//                counts[dayKey] = mockCounts[index]
//            }
//        }
//        
//        return (Array(range), counts)
//    }
//}
