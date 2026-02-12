//
//  RhytmView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 05.02.26.
//

import SwiftUI

struct ActivityView: View {
    @StateObject private var vm: ActivityViewModel
    
    init(user: User) {
        _vm = StateObject(wrappedValue: ActivityViewModel(user: user))
    }
    var body: some View {
        ZStack(alignment:.top) {
            LinearGradient(gradient: Gradient(colors: [.backgroundThreeCl,.backgroundTwoCl, .backgroundCl]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea(.all)
            
            VStack {
                title
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                HStack(spacing:18) {
                    average
                    
                    peakTime
                }
                .padding(.top,12)
                .fixedSize(horizontal: false, vertical: true)
                
                ScrollView(.vertical, showsIndicators: false) {
                    hourlyChartView
                        .padding(.vertical,12)
                    
                    dailyChartView
                        .padding(.bottom,12)
                    
                }
                .scrollBounceBehavior(.basedOnSize)
            }
            .padding()

        }
    }
    
    var title: some View {
        Text("ACTIVITY")
            .appFont(weight: .bold, size: 28,foregroundColor: .primaryTextCl)
    }
    
    var dailyChartView: some View {
        BarChartView(dates: vm.dailyDays, history: vm.dailyCounts, title: "Last 7 Days", type: .daily)
    }
    
    var hourlyChartView: some View {
        BarChartView(dates: vm.hourlyTimes, history: vm.hourlyCounts, title: "Last 7 Hours", type: .hourly)
    }
    
    var average: some View {
        VStack(alignment:.leading,spacing:8) {
            Text("7 Days Average")
                .appFont(weight: .semibold, size: 16,foregroundColor: .secondaryTextCl)
            
            Text(vm.averageSmokedString)
                .appFont(weight: .bold, size: 20,foregroundColor: .primaryTextCl)
            
//            Text(vm.comparisonString)
//                .appFont(weight: .semibold, size: 12, foregroundColor: .successCl)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.fieldStrokeCl.opacity(0.7))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.fieldStrokeCl, lineWidth: 2)
        )
    }
    
    var peakTime: some View {
        VStack(alignment:.leading,spacing:8) {
            Text("7 Days Peak Time")
                .appFont(weight: .semibold, size: 16,foregroundColor: .secondaryTextCl)
                .minimumScaleFactor(0.3)
                .lineLimit(1)
            
            Text(vm.peakTimeString)
                .appFont(weight: .bold, size: 20,foregroundColor: .primaryTextCl)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)

        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.fieldStrokeCl.opacity(0.7))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.fieldStrokeCl, lineWidth: 2)
        )
    }
}

#Preview {
    ActivityView(user: .init(name: "Valeh", email: "I", smokingData: .init(packSize: 1, packPrice: 1, dailyAverage: 10)))
}
