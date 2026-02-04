//
//  User.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 04.02.26.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let smokingData: SmokingData
    
    init(name: String, email: String, smokingData: SmokingData) {
        self.id = UUID().uuidString
        self.name = name
        self.email = email
        self.smokingData = smokingData
    }
}
