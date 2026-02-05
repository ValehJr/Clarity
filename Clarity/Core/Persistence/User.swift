//
//  User.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 04.02.26.
//

import Foundation
import SwiftData

@Model
class User {
    @Attribute(.unique) var id: String
    var name: String
    var email: String
    var smokingData: SmokingData
    
    @Relationship(deleteRule: .cascade, inverse: \SmokeEntry.user)
    var entries: [SmokeEntry] = []

    init(name: String, email: String, smokingData: SmokingData) {
        self.id = UUID().uuidString
        self.name = name
        self.email = email
        self.smokingData = smokingData
    }
}
