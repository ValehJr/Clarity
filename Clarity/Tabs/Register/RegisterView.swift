//
//  ContentView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 31.01.26.
//

import SwiftUI
import SwiftData

struct RegisterView: View {
    @State var name: String = ""
    @State var email: String = ""
    @FocusState var isNameFocused: Bool
    @FocusState var isEmailFocused: Bool
    
    
    var body: some View {
        ZStack {
            Color.backgroundCl.ignoresSafeArea()
            VStack(spacing:16) {
                
                profileIcon
                title
                    .padding(.bottom)
                
                nameField
                    .padding(.bottom,8)
                
                emailField
                    .padding(.bottom,24)
                
                continueButton
                Spacer()
            }
            .padding(.top,90)
        }
        .onTapGesture {
            isNameFocused = false
            isEmailFocused = false
        }
    }
    
    var profileIcon: some View {
        Image(.profileIc)
            .resizable()
            .frame(width: 45, height: 45)
            .scaledToFill()
            .foregroundStyle(.profileICCl)
            .background(
                Circle()
                    .fill(.profileICBackCl)
                    .frame(width: 90,height: 90)
            )
            .frame(width: 90, height: 90)
    }
    
    var title: some View {
        VStack(spacing: 8) {
            Text("Create Profile")
                .appFont(weight: .bold, size: 36,foregroundColor: .prrimaryTextCl)
            
            Text("Let's start your journey")
                .appFont(weight: .medium, size: 18,foregroundColor: .secondaryTextCl)
        }
    }
    
    var nameField: some View {
        VStack(alignment: .leading) {
            Text("Full name")
                .appFont(weight: .bold, size: 12,foregroundColor: .secondaryTextCl)
            
            TextField("", text: $name)
                .floatingPlaceholderStyle(
                    placeholder: "Steve Jobs",
                    text: $name,
                    placeholderColor:.secondaryTextCl,
                    backgroundColor: .fieldStrokeCl,
                    strokeColor: .fieldStrokeCl
                )
                .focused($isNameFocused)
                .autocorrectionDisabled(true)
                .textContentType(.name)
                .appFont(weight: .medium, size: 14)
        }
        .padding(.horizontal,24)
    }
    
    var emailField: some View {
        VStack(alignment: .leading) {
            Text("Email Address")
                .appFont(weight: .bold, size: 12,foregroundColor: .secondaryTextCl)
            
            TextField("", text: $email)
                .floatingPlaceholderStyle(
                    placeholder: "example@example.com",
                    text: $email,
                    placeholderColor:.secondaryTextCl,
                    backgroundColor: .fieldStrokeCl,
                    strokeColor: .fieldStrokeCl
                )
                .focused($isEmailFocused)
                .autocorrectionDisabled(true)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .appFont(weight: .medium, size: 14)
        }
        .padding(.horizontal,24)
    }
    
    var continueButton: some View {
        Button {
            
        } label: {
            Text("Continue")
                .appFont(weight: .bold, size: 16, foregroundColor: .white)
        }
        .frame(maxWidth: .infinity, minHeight: 52)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.primaryAccentCl)
        )
        .padding(.horizontal,24)
    }
}

#Preview {
    RegisterView()
        .modelContainer(for: Item.self, inMemory: true)
}
