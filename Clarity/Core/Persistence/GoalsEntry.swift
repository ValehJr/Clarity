//
//  GoalsEntry.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 12.02.26.
//

import SwiftData
import Foundation

@Model
class GoalsEntry: Identifiable {
    var id: UUID
    var title: String
    var amount: Double
    var user: User?
    
    init(id: UUID = UUID(), title: String, amount: Double,user: User? = nil) {
        self.id = id
        self.title = title
        self.amount = amount
        self.user = user
    }
}
