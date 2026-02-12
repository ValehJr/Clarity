//
//  ReclaimedView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 08.02.26.
//

import SwiftUI

struct ReclaimedView: View {
    
    @StateObject private var vm: ReclaimedViewModel
    
    init(user: User) {
        _vm = StateObject(wrappedValue: ReclaimedViewModel(user: user))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.backgroundThreeCl,.backgroundTwoCl, .backgroundCl]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 18) {
                title
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                moneyView
                    .padding(.vertical,12)
                
                timeView
                
                goalsTitle
                    .padding(.top)
                
                goals
                
            }
            .padding()
            .blur(radius: vm.showGoalPopup ? 4 : 0)
            .disabled(vm.showGoalPopup)
        
            if vm.showGoalPopup {
                    Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            vm.showGoalPopup = false
                        }
                    }
                    .transition(.opacity)
                
                GoalAddView(
                    goalNameText: vm.goalTitle,
                    amountText: vm.goalAmount,
                    onSave: { name, amount in
                        print("Added: \(name) for $\(amount)")
                        
                        withAnimation {
                            vm.showGoalPopup = false
                        }
                    },
                    onCancel: {
                        withAnimation {
                            vm.showGoalPopup = false
                        }
                    }
                )
                .transition(.scale(scale: 0.9).combined(with: .opacity))
                .zIndex(2)
            }
        }
    }
    
    var title: some View {
        Text("RECLAIMED")
            .appFont(weight: .bold, size: 28,foregroundColor: .primaryTextCl)
    }
    
    var moneyView: some View {
        VStack {
            HStack {
                Image(.dollarIc)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32,height: 32)
                    .foregroundStyle(.profileICCl)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.black.opacity(0.3))
                    )
                Spacer()
                
                VStack(alignment:.trailing,spacing:12) {
                    Text("Money Saved")
                        .appFont(weight: .semibold, size: 22,foregroundColor: .profileICCl)
                    
                    Text("52.52$")
                        .appFont(weight: .black, size: 36,foregroundColor: .primaryTextCl)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(colors: [.profileICCl.opacity(0.3),.profileICCl.opacity(0.2),.profileICCl.opacity(0.15)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.profileICCl.opacity(0.6),lineWidth: 1)
        )
    }
    
    var timeView: some View {
        VStack {
            HStack {
                Image(.clockIc)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32,height: 32)
                    .foregroundStyle(.timeRegainedCl)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.black.opacity(0.3))
                    )
                Spacer()
                
                VStack(alignment:.trailing,spacing:12) {
                    Text("Time Regained")
                        .appFont(weight: .semibold, size: 22,foregroundColor: .timeRegainedCl)
                    
                    Text("12h 45m")
                        .appFont(weight: .black, size: 36,foregroundColor: .primaryTextCl)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(colors: [.successCl.opacity(0.6),.successCl.opacity(0.4),.successCl.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.successCl,lineWidth: 1)
        )
    }
    
    var goalsTitle: some View {
        HStack {
            Text("Goals")
                .appFont(weight: .bold, size: 24, foregroundColor: .primaryTextCl)
            
            Spacer()
            
            Button {
                withAnimation {
                    vm.showGoalPopup = true
                }
            } label: {
                Image(.plusIc)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24,height: 24)
                    .foregroundStyle(.primaryTextCl)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.secondaryTextCl.opacity(0.4))
            )
            
        }
    }
    
    var goals: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 24) {
                GoalView(goalText: "AirPods", goalMoney: 120, savedMoney: 32)
                GoalView(goalText: "AirPods", goalMoney: 120, savedMoney: 32)
                GoalView(goalText: "AirPods", goalMoney: 120, savedMoney: 32)
                GoalView(goalText: "AirPods", goalMoney: 120, savedMoney: 32)
                
            }
        }
    }
}

#Preview {
    ReclaimedView(user: .init(name: "Valeh", email: "I", smokingData: .init(packSize: 1, packPrice: 1, dailyAverage: 10)))
}
