//
//  StatCard.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 15.02.26.
//

import SwiftUI

struct StatCardStyle {
    let background: LinearGradient
    let border: Color?
    let iconForeground: Color
    let iconBackground: Color
    let titleColor: Color
}

struct StatCard: View {
    
    enum Layout {
        case vertical
        case horizontal
    }
    
    let icon: ImageResource
    let title: String
    let value: String
    let layout: Layout
    let style: StatCardStyle
    
    var body: some View {
        Group {
            switch layout {
            case .vertical:
                VStack(alignment: .leading, spacing: 12) {
                    iconView
                    titleView
                    valueView
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            case .horizontal:
                HStack {
                    iconView
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        titleView
                        valueView
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(style.background)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(style.border ?? .clear, lineWidth: 1)
        )
    }
    
    private var iconView: some View {
        Image(icon)
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundStyle(style.iconForeground)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(style.iconBackground)
            )
    }
    
    private var titleView: some View {
        Text(title)
            .appFont(
                weight: .semibold,
                size: layout == .vertical ? 16 : 20,
                foregroundColor: style.titleColor
            )
            .minimumScaleFactor(0.9)
            .lineLimit(1)
    }
    
    private var valueView: some View {
        Text(value)
            .appFont(
                weight: .black,
                size: layout == .vertical ? 24 : 32,
                foregroundColor: .white
            )
    }
}
