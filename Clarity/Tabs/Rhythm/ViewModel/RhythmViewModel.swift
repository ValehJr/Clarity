//
//  RhythmViewModel.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 06.02.26.
//

import Combine
import Foundation

class RhythmViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }

    var dailyDays: [Date] { user.last7Days }
    var dailyCounts: [Date: Int] { user.dailyHistory }
    
    var hourlyTimes: [Date] { user.last7Hours }
    var hourlyCounts: [Date: Int] { user.hourlyHistory }
}
