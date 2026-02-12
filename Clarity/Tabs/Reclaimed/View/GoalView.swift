//
//  GoalView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 11.02.26.
//

import SwiftUI

struct GoalView: View {
    var goalText: String
    var goalMoney: Double
    var savedMoney: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            title
            
            moneyView
            
            progressBar
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.fieldStrokeCl.opacity(0.7))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.fieldStrokeCl, lineWidth: 2)
        )
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    var title: some View {
        Text(goalText)
            .appFont(weight: .bold, size: 20, foregroundColor: .primaryTextCl)
    }
    
    var goalMoneyView: some View {
        Text(goalMoney, format: .number
            .precision(.fractionLength(0...2))
            .locale(Locale(identifier: "en_US_POSIX"))
        )
        .appFont(weight: .semibold, size: 16, foregroundColor: .secondaryTextCl)
    }

    var savedMoneyView: some View {
        Text(savedMoney, format: .number
            .precision(.fractionLength(0...2))
            .locale(Locale(identifier: "en_US_POSIX"))
        )
        .appFont(weight: .semibold, size: 16, foregroundColor: .primaryTextCl)
    }

    var moneyView: some View {
        HStack {
            savedMoneyView
            
            Text("/")
                .appFont(weight: .semibold, size: 18, foregroundColor: .primaryTextCl)
            
            goalMoneyView
        }
    }
    
    @ViewBuilder
    var progressBar: some View {
        let progress: CGFloat = {
            guard goalMoney > 0 else { return 0 }
            return min(max(CGFloat(savedMoney) / CGFloat(goalMoney), 0), 1)
        }()

        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 7)
                    .frame(height: 16)
                    .foregroundColor(.secondaryTextCl.opacity(0.3))
                
                RoundedRectangle(cornerRadius: 7)
                    .fill(
                        LinearGradient(
                            colors: [.progressBarFirstCl, .progressBarSecondCl, .progressBarThirdCl],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: geometry.size.width * progress, height: 16)
            }
        }
        .frame(height: 16)
    }
}

#Preview {
    GoalView(goalText: "AirPods", goalMoney: 120, savedMoney: 32)
}
