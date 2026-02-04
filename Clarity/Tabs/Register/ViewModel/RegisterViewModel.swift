//
//  RegisterViewModel.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 01.02.26.
//

import Combine
import Foundation

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
    
    func completeRegistration(authViewModel: AuthViewModel) async {
        guard let user = createUser() else {
            errorMessage = "Please fill all fields correctly"
            return
        }
        
        isLoading = true
        
        do {
            try authViewModel.completeRegistration(user: user)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    private func createUser() -> User? {
        guard let packSizeInt = Int(packSize),
              let packPriceDouble = Double(packPrice),
              let dailyAverageInt = Int(dailyAverage) else {
            return nil
        }
        
        let smokingData = SmokingData(
            packSize: packSizeInt,
            packPrice: packPriceDouble,
            dailyAverage: dailyAverageInt
        )
        
        return User(name: name, email: email, smokingData: smokingData)
    }
}

enum RegistrationStep {
    case smokingHabits
}
