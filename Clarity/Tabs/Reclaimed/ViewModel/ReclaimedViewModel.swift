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
    @Published var regainedTime: String = "12h45m"
    @Published var regainedAmount: String = "$100"
    @Published var goalTitle: String = ""
    @Published var goalAmount: String = ""
    @Published var showGoalPopup = false

    var goals: [GoalsEntry] = []

    init(user: User) {
        self.user = user
    }
}
