//
//  SmokeEntry.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 04.02.26.
//

import SwiftData
import Foundation

@Model
class SmokeEntry: Comparable {
    static func < (lhs: SmokeEntry, rhs: SmokeEntry) -> Bool {
        lhs.timestamp < rhs.timestamp
    }
    
    var timestamp: Date
 
    var user: User?
    
    init(timestamp: Date = .now, user: User? = nil) {
        self.timestamp = timestamp
        self.user = user
    }
}
