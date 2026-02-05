//
//  RootView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 04.02.26.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @Query private var users: [User]
    
    var body: some View {
        if let user = users.first {
            MainTabView(user: user)
        } else {
            RegisterView()
        }
    }
}
