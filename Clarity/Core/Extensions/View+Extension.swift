//
//  View+Extension.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 01.02.26.
//

import SwiftUI

extension View {
    func appFont(
        weight: Font.Weight,
        size: CGFloat,
        foregroundColor: Color = .primary
    ) -> some View {
        self
            .font(.system(size: size,weight: weight))
            .foregroundColor(foregroundColor)
    }
    
    func floatingPlaceholderStyle(
        placeholder: String,
        text: Binding<String>,
        placeholderColor: Color = .gray,
        backgroundColor: Color = .clear,
        strokeColor: Color = .gray
    ) -> some View {
        self.modifier(
            FloatingPlaceholderTextField(
                placeholder: placeholder,
                placeholderColor: placeholderColor,
                strokeColor: strokeColor,
                backgroundColor: backgroundColor,
                text: text
            )
        )
    }
    
    func imagePlaceholderStyle(
        placeholder: String,
        text: Binding<String>,
        placeholderColor: Color = .gray,
        strokeColor: Color = .gray,
        backgroundColor: Color = Color(uiColor: .systemBackground),
        leftIcon: Image? = nil
    ) -> some View {
        self.modifier(
            ImagePlaceholderTextField(
                placeholder: placeholder,
                placeholderColor: placeholderColor,
                text: text,
                strokeColor: strokeColor,
                backgroundColor: backgroundColor,
                leftIcon: leftIcon
            )
        )
    }
}
