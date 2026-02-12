//
//  ReclaimedViewModel.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 12.02.26.
//

import Combine
import Foundation

class ReclaimedViewModel: ObservableObject {
    @Published var user: User
    
    @Published var regainedTime: String = "--"
    @Published var regainedAmountString: String = "$0.00"
    @Published var cigarettesAvoided: String = "0"
    
    @Published var currentSavings: Double = 0.0
    
    @Published var isMoneyLost: Bool = false
    @Published var isTimeLost: Bool = false
    
    @Published var goalTitle: String = ""
    @Published var goalAmount: String = ""
    @Published var showGoalPopup = false
    
    
    var sortedGoals: [GoalsEntry] {
        user.goalsEntries.sorted { $0.amount < $1.amount }
    }
    
    init(user: User) {
        self.user = user
        refreshStats()
    }
    
    func refreshStats() {
        let money = SmokingStatsService.calculateMoneyImpact(user: user)
        
        if money < 0 {
            self.isMoneyLost = true
            self.currentSavings = 0.0
            self.regainedAmountString = String(format: "$%.2f", abs(money))
        } else {
            self.isMoneyLost = false
            self.currentSavings = money
            self.regainedAmountString = String(format: "$%.2f", money)
        }
        
        let minutes = SmokingStatsService.calculateTimeReclaimed(user: user)
        
        if minutes < 0 {
            self.isTimeLost = true
            self.regainedTime = formatMinutes(abs(minutes))
        } else {
            self.isTimeLost = false
            self.regainedTime = formatMinutes(minutes)
        }
        
        let avoided = SmokingStatsService.calculateCigarettesAvoided(user: user)
        self.cigarettesAvoided = "\(avoided)"
    }
    
    func addGoal(title: String, amount: Double) {
        
        let newGoal = GoalsEntry(title: title, amount: amount, user: user)
        user.goalsEntries.append(newGoal)
        
        goalTitle = ""
        goalAmount = ""
        showGoalPopup = false
    }
    
    func deleteGoal(_ goal: GoalsEntry) {
        if let index = user.goalsEntries.firstIndex(where: { $0.id == goal.id }) {
            user.goalsEntries.remove(at: index)
        }
    }
    
    private func formatMinutes(_ totalMinutes: Double) -> String {
        let hours = Int(totalMinutes / 60)
        let mins = Int(totalMinutes) % 60
        return "\(hours)h \(mins)m"
    }
}
