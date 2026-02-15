//
//  GoalAddView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 12.02.26.
//

import SwiftUI

struct GoalAddView: View {
    @State var goalNameText: String
    @State var amountText: String
    
    var onSave: (String, Double) -> Void
    var onCancel: () -> Void
    
    var body: some View {
        VStack(alignment: .leading,spacing: 16) {
            title
            
            goalNameField
            amountField
            
            actionButtons
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.tabCl)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.fieldStrokeCl,lineWidth: 1.5)
        )
        .padding(.horizontal, 24)
    }
    
    var title: some View {
        Text("New Goal")
            .appFont(weight: .semibold, size: 20, foregroundColor: .primaryTextCl)
    }
    
    var goalNameField: some View {
        TextField("", text: $goalNameText)
            .floatingPlaceholderStyle(
                placeholder: "e.g. New Guitar",
                text: $goalNameText,
                placeholderColor:.secondaryTextCl,
                backgroundColor: .fieldStrokeCl,
                strokeColor: .fieldStrokeCl
            )
            .autocorrectionDisabled(true)
            .textContentType(.name)
            .appFont(weight: .medium, size: 14)
    }
    
    var amountField: some View {
        TextField("", text: $amountText)
            .floatingPlaceholderStyle(
                placeholder: "0.00",
                text: $amountText,
                placeholderColor:.secondaryTextCl,
                backgroundColor: .fieldStrokeCl,
                strokeColor: .fieldStrokeCl
            )
            .autocorrectionDisabled(true)
            .keyboardType(.numberPad)
            .appFont(weight: .medium, size: 14)
    }
    
    var actionButtons: some View {
        HStack {
            Button {
                onCancel()
            } label: {
                Text("Cancel")
                    .appFont(weight: .semibold, size: 16,foregroundColor: .primaryTextCl)
                    .frame(maxWidth: .infinity)
                    .frame(height: 28)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        Color.fieldStrokeCl.opacity(0.4)
                    )
            )
            
            Spacer()
            
            Button {
                if let amount = Double(amountText), !goalNameText.isEmpty {
                    onSave(goalNameText, amount)
                }
            } label: {
                Text("Done")
                    .appFont(weight: .semibold, size: 16,foregroundColor: .primaryTextCl)
                    .frame(maxWidth: .infinity)
                    .frame(height: 28)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        Color.progressBarFirstCl
                    )
            )
            .opacity(goalNameText.isEmpty || amountText.isEmpty ? 0.5 : 1.0)
            .disabled(goalNameText.isEmpty || amountText.isEmpty)
        }
    }
}

#Preview {
    GoalAddView(goalNameText: "", amountText: "",
                onSave: { name, amount in
        print("Saved goal: \(name) with amount: \(amount)")
    }, onCancel: {
        print("Cancelled")
    })
}
