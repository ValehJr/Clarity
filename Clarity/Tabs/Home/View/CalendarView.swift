//
//  CalendarView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 03.02.26.
//

import SwiftUI

struct CalendarView: View {
    
    let range: [Date]
    let counts: [Date: Int]
    
    var body: some View {
        calendarView
    }
    
    var calendarView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Last 30 Days")
                .appFont(weight: .bold, size: 20, foregroundColor: .primaryTextCl)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                ForEach(range, id: \.self) { date in
                    dayCell(for: date)
                }
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.fieldStrokeCl)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.fieldStrokeCl, lineWidth: 1.5)
            )
        }
    }
    
    @ViewBuilder
    func dayCell(for date: Date) -> some View {
        let isToday = Calendar.current.isDateInToday(date)
        let isFuture = date > Date.now && !isToday
        
        let dayKey = Calendar.current.startOfDay(for: date)
        let count = counts[dayKey] ?? 0
        
        let backgroundColor = cellColor(for: count, isFuture: isFuture)
        
        Text(date.formatted(.dateTime.day()))
            .appFont(
                weight: .semibold,
                size: 14,
                foregroundColor: .white
            )
            .frame(width: 40, height: 40)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor)
            }
    }
    
    func cellColor(for count: Int, isFuture: Bool) -> Color {
        if isFuture {
            return Color.gray.opacity(0.2)
        }
        
        switch count {
        case 0:
            return Color.gray.opacity(0.3)
        case 1...3:
            return Color.primaryAccentCl.opacity(0.7)
        case 4...7:
            return Color.primaryAccentCl
        case 8...12:
            return Color.warningCl.opacity(0.7)
        default:
            return Color.warningCl
        }
    }
}
