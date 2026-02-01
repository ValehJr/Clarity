//
//  FloatingPlaceholderTextField.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 01.02.26.
//


import SwiftUI

struct FloatingPlaceholderTextField: ViewModifier {
    let placeholder: String
    let placeholderColor: Color
    let strokeColor: Color
    let backgroundColor: Color
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    private var shouldFloatPlaceholder: Bool {
        isFocused || !text.isEmpty
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            Text(placeholder)
                .foregroundColor(placeholderColor)
                .appFont(weight: .medium, size: shouldFloatPlaceholder ? 8 : 14)
                .padding(.horizontal, 16)
                .background(
                    .clear
                )
                .offset(
                    y: shouldFloatPlaceholder ? -12 : 0
                )
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: shouldFloatPlaceholder)
                .allowsHitTesting(false)
            
            content
                .foregroundColor(placeholderColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .padding(.top, shouldFloatPlaceholder ? 8 : 0)
                .focused($isFocused)
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(backgroundColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(strokeColor, lineWidth: 1.5)
        )
    }
}
