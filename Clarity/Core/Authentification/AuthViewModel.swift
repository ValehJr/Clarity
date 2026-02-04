//
//  AuthViewModel.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 04.02.26.
//

import Foundation
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool
    @Published var currentUser: User?
    @Published var errorMessage: String?

    private let userKey = "currentUser"

    init() {
        if let userData = KeychainHelper.shared.load(key: userKey),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            self.currentUser = user
            self.isAuthenticated = true
        } else {
            self.currentUser = nil
            self.isAuthenticated = false
        }
    }

    func completeRegistration(user: User) throws {
        errorMessage = nil

        guard let encoded = try? JSONEncoder().encode(user) else {
            throw AuthError.encodingFailed
        }

        guard KeychainHelper.shared.save(key: userKey, data: encoded) else {
            throw AuthError.keychainSaveFailed
        }

        currentUser = user
        isAuthenticated = true
    }

    func logout() {
        _ = KeychainHelper.shared.delete(key: userKey)
        currentUser = nil
        isAuthenticated = false
    }

    func updateUser(_ user: User) throws {
        guard let encoded = try? JSONEncoder().encode(user) else {
            throw AuthError.encodingFailed
        }

        guard KeychainHelper.shared.save(key: userKey, data: encoded) else {
            throw AuthError.keychainSaveFailed
        }

        currentUser = user
    }
}


enum AuthError: LocalizedError {
    case encodingFailed
    case keychainSaveFailed
    case userNotFound
    
    var errorDescription: String? {
        switch self {
        case .encodingFailed:
            return "Failed to encode user data"
        case .keychainSaveFailed:
            return "Failed to save data securely"
        case .userNotFound:
            return "User not found"
        }
    }
}
