//
//  SmokingData.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 04.02.26.
//

import SwiftData

@Model
class SmokingData {
    var packSize: Int
    var packPrice: Double
    var dailyAverage: Int
    
    init(packSize: Int, packPrice: Double, dailyAverage: Int) {
        self.packSize = packSize
        self.packPrice = packPrice
        self.dailyAverage = dailyAverage
    }
}
