//
//  BarChartView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 06.02.26.
//

import SwiftUI
import Charts

enum ChartType {
    case daily
    case hourly
}

struct BarChartView: View {
    let dates: [Date]
    let history: [Date: Int]
    let title: String
    let type: ChartType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .appFont(weight: .semibold, size: 20, foregroundColor: .primaryTextCl)
            
            Chart {
                ForEach(dates, id: \.self) { date in
                    let count = history[date] ?? 0
                    
                    let label = type == .daily
                        ? date.formatted(.dateTime.weekday(.abbreviated)).uppercased()
                    : TimeFormatter.hourly.string(from: date).lowercased()
                    
                    let isHighlighted = isCurrentTime(date)
                    
                    BarMark(
                        x: .value("Time", label),
                        y: .value("Count", count)
                    )
                    .cornerRadius(8)
                    .foregroundStyle(isHighlighted ? Color.profileICCl.opacity(0.9) : Color.mutedTextCl.opacity(0.4))
                    .annotation(position: .top, spacing: 4) {
                        if count == 0 {
                            EmptyView()
                        } else {
                            Text("\(count)")
                                .appFont(weight: .bold, size: 12, foregroundColor: isHighlighted ? Color.profileICCl.opacity(0.9) : Color.mutedTextCl.opacity(0.6))
                        }
                    }
                }
            }
            .chartYAxis(.hidden)
            .chartXAxis {
                AxisMarks(position: .bottom) { _ in
                    AxisValueLabel()
                        .font(Font.system(size: 12, weight: .bold))
                        .foregroundStyle(.secondaryTextCl)
                }
            }
            .frame(height: 180)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.fieldStrokeCl.opacity(0.7))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(.fieldStrokeCl, lineWidth: 2)
        )
    }
    
    private func isCurrentTime(_ date: Date) -> Bool {
        let calendar = Calendar.current
        if type == .daily {
            return calendar.isDateInToday(date)
        } else {
            return calendar.isDate(date, equalTo: Date(), toGranularity: .hour)
        }
    }
}
