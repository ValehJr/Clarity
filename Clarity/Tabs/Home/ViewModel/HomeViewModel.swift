//
//  HomeViewModel.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 03.02.26.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var calendarRange: [Date] = []
    @Published var calendarCounts: [Date: Int] = [:]
    
    func loadMockData() {
        let data = generateMockCalendarData()
        self.calendarRange = data.range
        self.calendarCounts = data.counts
        
    }
    
    private func generateMockCalendarData() -> (range: [Date], counts: [Date: Int]) {
        let calendar = Calendar.current
        let today = Date()
        
        let range = (0..<30).compactMap { offset -> Date? in
            calendar.date(byAdding: .day, value: -offset, to: today)
        }.reversed()
        
        var counts: [Date: Int] = [:]
        let mockCounts = [7, 0, 3, 0, 5, 6, 0,
                          0, 9, 10, 0, 12, 0, 0,
                          15, 0, 0, 18, 0, 20, 21,
                          0, 0, 24, 25, 0, 27, 0,
                          0, 30]
        
        for (index, date) in range.enumerated() {
            let dayKey = calendar.startOfDay(for: date)
            let isFuture = date > today && !calendar.isDateInToday(date)
            
            if !isFuture && index < mockCounts.count {
                counts[dayKey] = mockCounts[index]
            }
        }
        
        return (Array(range), counts)
    }
}
