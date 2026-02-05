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
    let container: ModelContainer

    init() {
        container = try! ModelContainer(for: User.self)
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(container)
    }
}
