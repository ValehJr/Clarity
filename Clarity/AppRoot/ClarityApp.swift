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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RegisterView()
        }
        .modelContainer(sharedModelContainer)
    }
}
