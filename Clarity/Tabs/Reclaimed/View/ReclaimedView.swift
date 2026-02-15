//
//  ReclaimedView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 08.02.26.
//

import SwiftUI

struct ReclaimedView: View {
    
    @StateObject private var vm: ReclaimedViewModel
    @Environment(\.colorScheme) var colorScheme
    
    
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
                
                HStack(spacing: 12) {
                    moneyView
                    
                    cigarettesAvoidedView
                }
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
                        
                        vm.addGoal(title: name, amount: amount)
                        
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
    
    private var moneyView: some View {
        StatCard(
            icon: .dollarIc,
            title: vm.isMoneyLost ? "Money Lost" : "Money Saved",
            value: vm.regainedAmountString,
            layout: .vertical,
            style: moneyStyle
        )
    }
    
    private var moneyStyle: StatCardStyle {
        if vm.isMoneyLost {
            return StatCardStyle(
                background: LinearGradient(
                    colors: [.lostCl, .lostTwoCl],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                border: colorScheme == .dark ? .lostCl.opacity(0.5) : nil,
                iconForeground: .white,
                iconBackground: .white.opacity(0.2),
                titleColor: .white.opacity(0.9)
            )
        } else {
            return StatCardStyle(
                background: LinearGradient(
                    colors: colorScheme == .dark
                    ? [.profileICCl.opacity(0.6), .profileICCl.opacity(0.4)]
                    : [.ceruleanCl, .bluerocraticCl],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                border: colorScheme == .dark ? .profileICCl.opacity(0.6) : nil,
                iconForeground: .white,
                iconBackground: .white.opacity(0.2),
                titleColor: .white.opacity(0.9)
            )
        }
    }
    
    
    private var timeView: some View {
        StatCard(
            icon: .clockIc,
            title: vm.isTimeLost ? "Time Lost" : "Time Regained",
            value: vm.regainedTime,
            layout: .horizontal,
            style: timeStyle
        )
    }
    
    private var timeStyle: StatCardStyle {
        if vm.isTimeLost {
            return StatCardStyle(
                background: LinearGradient(
                    colors: [.lostCl, .lostTwoCl],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                border: colorScheme == .dark ? .lostCl.opacity(0.5) : nil,
                iconForeground: .white,
                iconBackground: .white.opacity(0.2),
                titleColor: .white.opacity(0.9)
            )
        } else {
            return StatCardStyle(
                background: LinearGradient(
                    colors: colorScheme == .dark
                    ? [.timeRegainedCl.opacity(0.3), .timeRegainedCl.opacity(0.15)]
                    : [.envyLoveCl, .prairieCl],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                border: colorScheme == .dark ? .timeRegainedCl.opacity(0.6) : nil,
                iconForeground: colorScheme == .dark ? .timeRegainedCl : .white,
                iconBackground: colorScheme == .dark
                ? .timeRegainedCl.opacity(0.3)
                : .white.opacity(0.2),
                titleColor: colorScheme == .dark
                ? .timeRegainedCl
                : .white.opacity(0.9)
            )
        }
    }
    
    
    private var cigarettesAvoidedView: some View {
        StatCard(
            icon: .flameIc,
            title: "Cigarettes Avoided",
            value: vm.cigarettesAvoided,
            layout: .vertical,
            style: cigarettesStyle
        )
    }
    
    private var cigarettesStyle: StatCardStyle {
        StatCardStyle(
            background: LinearGradient(
                colors: [.cigarettesAvoidedOneCl, .cigarettesAvoidedTwoCl],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            border: nil,
            iconForeground: .white,
            iconBackground: .white.opacity(0.2),
            titleColor: .white.opacity(0.9)
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
                    .foregroundStyle(.white)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.secondaryTextCl.opacity(0.4))
            )
            
        }
    }
    
    var goals: some View {
        List {
            ForEach(vm.sortedGoals) { goal in
                GoalView(
                    goalText: goal.title,
                    goalMoney: goal.amount,
                    savedMoney: max(0, vm.currentSavings)
                )
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
                
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        withAnimation {
                            vm.deleteGoal(goal)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ReclaimedView(user: .init(name: "Valeh", email: "I", smokingData: .init(packSize: 1, packPrice: 1, dailyAverage: 10)))
}
