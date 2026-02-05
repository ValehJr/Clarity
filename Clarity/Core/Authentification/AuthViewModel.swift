//
//  AuthViewModel.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 04.02.26.
//

import Foundation
import Combine
import SwiftData

@MainActor
class AuthViewModel: ObservableObject {
    @Published var currentUser: User?

    func logout(context: ModelContext) {
        if let user = currentUser {
            context.delete(user)
        }
        currentUser = nil
    }
}
