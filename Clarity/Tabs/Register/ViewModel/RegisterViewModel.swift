//
//  RegisterViewModel.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 01.02.26.
//

import Combine
import Foundation
import SwiftData

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var packSize: String = ""
    @Published var packPrice: String = ""
    @Published var dailyAverage: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var isContinueButtonValid: Bool {
        !name.isEmpty && !email.isEmpty && email.isValidEmail
    }
    
    var isFinishButtonValid: Bool {
        !packSize.isEmpty && !packPrice.isEmpty && !dailyAverage.isEmpty
    }
    
    func completeRegistration(context: ModelContext) async {
        isLoading = true
        guard let packSizeInt = Int(packSize),
              let packPriceDouble = Double(packPrice),
              let dailyAverageInt = Int(dailyAverage) else {
            return
        }
        
        let smokingData = SmokingData(
            packSize: packSizeInt,
            packPrice: packPriceDouble,
            dailyAverage: dailyAverageInt
        )
        
        let user = User(name: name, email: email, smokingData: smokingData)
        
        context.insert(user)
        
        isLoading = false
    }
}

enum RegistrationStep {
    case smokingHabits
}
