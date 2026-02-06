//
//  TimeFormatter.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 06.02.26.
//


import SwiftUI

struct TimeFormatter {
    static let hourly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter
    }()
}