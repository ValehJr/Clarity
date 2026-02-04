//
//  ClarityApp.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 31.01.26.
//

import SwiftUI
import SwiftData

@main
struct ClarityApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                MainTabView()
                    .environmentObject(authViewModel)
            } else {
                RegisterView()
                    .environmentObject(authViewModel)
            }
        }
    }
}
