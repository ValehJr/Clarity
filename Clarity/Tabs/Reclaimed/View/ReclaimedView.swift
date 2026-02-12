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
    
    var moneyView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(.dollarIc)
                .resizable()
                .scaledToFit()
                .frame(width: 24,height: 24)
                .foregroundStyle(vm.isMoneyLost ? .white : .profileICCl)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(vm.isMoneyLost ? .warningCl.opacity(0.3) : .profileICCl.opacity(0.3))
                )
            
            Text(vm.isMoneyLost ? "Money Lost" : "Money Saved")
                .appFont(weight: .semibold, size: 16,foregroundColor: vm.isMoneyLost ? .white : .profileICCl)
            
            Text(vm.regainedAmountString)
                .appFont(weight: .black, size: 24,foregroundColor: .white)
        }
        .padding()
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(vm.isMoneyLost ? LinearGradient(colors: [.warningCl.opacity(0.6),.warningCl.opacity(0.4),.warningCl.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [.profileICCl.opacity(0.3),.profileICCl.opacity(0.2),.profileICCl.opacity(0.15)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(vm.isMoneyLost ? .warningCl.opacity(0.6) : .profileICCl.opacity(0.6),lineWidth: 1)
        )
    }
    
    var timeView: some View {
        HStack {
            Image(.clockIc)
                .resizable()
                .scaledToFit()
                .frame(width: 32,height: 32)
                .foregroundStyle(vm.isTimeLost ? .white : .timeRegainedCl)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(vm.isTimeLost ? .warningCl.opacity(0.3) : .timeRegainedCl.opacity(0.3))
                )
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                
                Text(vm.isTimeLost ? "Time Lost" : "Time Regained")
                    .appFont(weight: .semibold, size: 20,foregroundColor: vm.isTimeLost ? .white : .timeRegainedCl)
                
                Text(vm.regainedTime)
                    .appFont(weight: .black, size: 32,foregroundColor: .white)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(vm.isTimeLost ? LinearGradient(colors: [.warningCl.opacity(0.6),.warningCl.opacity(0.4),.warningCl.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(colors: [.successCl.opacity(0.6),.successCl.opacity(0.4),.successCl.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(vm.isMoneyLost ? .warningCl.opacity(0.6) : .successCl,lineWidth: 1)
        )
    }
    
    var cigarettesAvoidedView: some View {
        VStack(alignment: .leading,spacing: 12) {
            Image(.flameIc)
                .resizable()
                .scaledToFit()
                .frame(width: 24,height: 24)
                .foregroundStyle(.white)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.white.opacity(0.2))
                )
            
            
            Text("Cigarettes Avoided")
                .appFont(weight: .semibold, size: 16,foregroundColor: .white)
                .minimumScaleFactor(0.9)
                .lineLimit(1)
            
            Text(vm.cigarettesAvoided)
                .appFont(weight: .bold, size: 24,foregroundColor: .white)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        colors: [
                            .cigarettesAvoidedGradientThreeCl,
                            .cigarettesAvoidedGradientTwoCl,
                            .cigarettesAvoidedGradientOneCl.opacity(0.8)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .cigarettesAvoidedGradientThreeCl.opacity(0.3), radius: 10, x: 0, y: 5)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.cigarettesAvoidedGradientTwoCl,lineWidth: 1)
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
