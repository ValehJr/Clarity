//
//  TabEnum.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 03.02.26.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "Home"
    case search = "Search"
    case money = "Money"
    case settings = "Setup"
    
    var icon: ImageResource {
        switch self {
        case .home: return .homeTabIc
        case .search: return .activityIc
        case .money: return .moneyIc
        case .settings: return .boxIc
        }
    }
}
