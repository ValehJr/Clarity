//
//  MainTabView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 03.02.26.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    var user: User
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home: HomeView(user: user)
                case .search: Color.gray.ignoresSafeArea()
                case .money: Color.red.ignoresSafeArea()
                case .settings: Color.black.ignoresSafeArea()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            customTabBar
                .padding(.horizontal, 12)
                .padding(.bottom, 10)
        }
    }
    
    var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button {
                    withAnimation(.spring()) {
                        selectedTab = tab
                    }
                } label: {
                    tabItem(tab: tab, isSelected: selectedTab == tab)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
        .background {
            Capsule()
                .fill(Color.tabCl)
                .overlay(
                    Capsule()
                        .stroke(Color.fieldStrokeCl, lineWidth: 2)
                )

        }

    }
    
    func tabItem(tab: Tab, isSelected: Bool) -> some View {
        HStack(spacing: 4) {
            Image(tab.icon)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: isSelected ? 15 : 20, height: isSelected ? 15 : 20)
                .padding(.vertical, isSelected ? 10 : 0)
                .foregroundStyle(isSelected ? .white : .gray)
            
            if isSelected {
                Text(tab.rawValue)
                    .appFont(weight: .bold, size: 12, foregroundColor: .white)
                    .transition(.opacity.combined(with: .move(edge: .leading)))
            }
        }
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color.primaryAccentCl : Color.clear)
        .clipShape(Capsule())
    }
}
#Preview {
    MainTabView(user: .init(name: "Valer", email: "valer@gmail.com", smokingData: .init(packSize: 1, packPrice: 1, dailyAverage: 1)))
}
