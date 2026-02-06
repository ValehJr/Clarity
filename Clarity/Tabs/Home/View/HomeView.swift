//
//  HomeView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 03.02.26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm: HomeViewModel
    @Environment(\.modelContext) private var context

    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: Date())
    }
    
    init(user: User) {
        _vm = StateObject(wrappedValue: HomeViewModel(user: user))
    }

    
    var body: some View {
        ZStack(alignment:.top) {
            LinearGradient(gradient: Gradient(colors: [.backgroundThreeCl,.backgroundTwoCl, .backgroundCl]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea(.all)
            
            
            VStack {
                title
                    .frame(maxWidth: .infinity,alignment: .leading)
                ScrollView(.vertical, showsIndicators: false) {
                    todaysCount
                        .padding(.top,60)
                    
                    plusButton
                        .padding([.vertical,.trailing])
                        .frame(maxWidth: .infinity,alignment: .trailing)

                    calendarView
                }
                .scrollBounceBehavior(.basedOnSize)
            }
            .padding()
        }
    }

    var title: some View {
        VStack(alignment: .leading) {
            Text(dateString)
                .appFont(weight: .semibold, size: 18,foregroundColor: .secondaryTextCl)
            
            Text("Hi,")
                .appFont(weight: .bold, size: 24, foregroundColor: .primaryTextCl)
        }
    }
    
    var todaysCount: some View {
        VStack(spacing: 8) {
            Text("\(vm.cigarettesSmokedToday)")
                .appFont(weight: .bold, size: 52,foregroundColor: .primaryTextCl)
            Text("TODAY'S COUNT")
                .appFont(weight: .bold, size: 18,foregroundColor: .secondaryTextCl)
        }
    }
    
    var plusButton: some View {
        Button {
            vm.addNewSmoke(context: context)
        } label: {
            Image(.plusIc)
                .resizable()
                .scaledToFit()
                .frame(width: 36,height: 36)
                .foregroundStyle(.white)
                .background {
                    RoundedRectangle(cornerRadius: 18)
                        .frame(width: 60,height: 60)
                        .foregroundStyle(.primaryAccentCl)
                        .shadow(color: .primaryAccentCl.opacity(0.6), radius: 5, x: -3, y: 5)
                        .shadow(color: .primaryAccentCl.opacity(0.6), radius: 5, x: 3, y: 5)
                }
        }
    }
    
    var calendarTitle: some View {
        Text("Last 30 Days")
            .appFont(weight: .bold, size: 20,foregroundColor: .primaryTextCl)
    }
    
    var calendarView: some View {
        CalendarView(dailyAverage: vm.user.smokingData.dailyAverage, range: vm.calendarRange, counts: vm.calendarCounts)
    }
}

#Preview {
    HomeView(user: .init(name: "Valeh", email: "I", smokingData: .init(packSize: 1, packPrice: 1, dailyAverage: 10)))
}
