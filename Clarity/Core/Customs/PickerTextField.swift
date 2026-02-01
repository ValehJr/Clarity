//
//  ImagePlaceholderTextField.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 01.02.26.
//

import SwiftUI

struct ImagePlaceholderTextField: ViewModifier {
    let placeholder: String
    let placeholderColor: Color
    let text: Binding<String>
    let strokeColor: Color
    let backgroundColor: Color
    let leftIcon: Image?
    @FocusState private var isFocused: Bool
    
    func body(content: Content) -> some View {
        HStack(spacing: 12) {
            // Left icon
            if let leftIcon = leftIcon {
                leftIcon
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(placeholderColor)
                    .frame(width: 24, height: 24)
            }
            
            // Text field with placeholder
            ZStack(alignment: .leading) {
                // Show placeholder only when text is empty
                if text.wrappedValue.isEmpty {
                    Text(placeholder)
                        .foregroundColor(placeholderColor.opacity(0.6))
                        .appFont(weight: .medium, size: 14)
                        .allowsHitTesting(false)
                }
                
                content
                    .foregroundColor(placeholderColor)
                    .focused($isFocused)
            }
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
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
