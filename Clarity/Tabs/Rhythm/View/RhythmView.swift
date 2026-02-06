//
//  RhytmView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 05.02.26.
//

import SwiftUI

struct RhythmView: View {
    @StateObject private var vm: RhythmViewModel
    
    init(user: User) {
        _vm = StateObject(wrappedValue: RhythmViewModel(user: user))
    }
    var body: some View {
        ZStack(alignment:.top) {
            LinearGradient(gradient: Gradient(colors: [.backgroundThreeCl,.backgroundTwoCl, .backgroundCl]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea(.all)
            
            VStack {
                title
                    .frame(maxWidth: .infinity,alignment: .leading)
                ScrollView(.vertical, showsIndicators: false) {
                    hourlyChartView
                        .padding(.vertical)
                    
                    dailyChartView
                }
                .scrollBounceBehavior(.basedOnSize)
            }
            .padding()

        }
    }
    
    var title: some View {
        Text("ACTIVITY")
            .appFont(weight: .bold, size: 30,foregroundColor: .primaryTextCl)
    }
    
    var dailyChartView: some View {
        BarChartView(dates: vm.dailyDays, history: vm.dailyCounts, title: "Last 7 Days", type: .daily)
    }
    
    var hourlyChartView: some View {
        BarChartView(dates: vm.hourlyTimes, history: vm.hourlyCounts, title: "Last 7 Hours", type: .hourly)
    }
}

#Preview {
    RhythmView(user: .init(name: "Valeh", email: "I", smokingData: .init(packSize: 1, packPrice: 1, dailyAverage: 10)))
}
