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
    
    var isContinueButtonValid: Bool {
        !name.isEmpty && !email.isEmpty && email.isValidEmail
    }
    
    var isFinishButtonValid: Bool {
        !packSize.isEmpty && !packPrice.isEmpty && !dailyAverage.isEmpty
    }
}
