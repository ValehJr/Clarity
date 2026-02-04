//
//  HomeView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 03.02.26.
//

import SwiftUI

struct HomeView: View {
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: Date())
    }
    
    @StateObject private var vm = HomeViewModel()

    
    var body: some View {
        ZStack(alignment:.top) {
            LinearGradient(gradient: Gradient(colors: [.backgroundThreeCl,.backgroundTwoCl, .backgroundCl]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea(.all)
            
            
            VStack {
                title
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                todaysCount
                    .padding(.top,60)
                
                plusButton
                    .padding([.vertical,.trailing])
                    .frame(maxWidth: .infinity,alignment: .trailing)

                calendarView
                    
            }
            .padding()
        }
        .onAppear {
            vm.loadMockData()
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
            Text("0")
                .appFont(weight: .bold, size: 52,foregroundColor: .primaryTextCl)
            Text("TODAY'S COUNT")
                .appFont(weight: .bold, size: 18,foregroundColor: .secondaryTextCl)
        }
    }
    
    var plusButton: some View {
        Button {
            
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
        CalendarView(range: vm.calendarRange, counts: vm.calendarCounts)
    }
}

#Preview {
    HomeView()
}
