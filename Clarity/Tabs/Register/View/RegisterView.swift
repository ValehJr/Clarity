//
//  ContentView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 31.01.26.
//

import SwiftUI
import SwiftData

struct RegisterView: View {
    @StateObject var vm = RegisterViewModel()
    @FocusState var isNameFocused: Bool
    @FocusState var isEmailFocused: Bool
    
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
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
            .onAppear {
                isNameFocused = true
            }
            .navigationDestination(for: RegistrationStep.self) { step in
                SmokingHabitsView(vm: vm)
            }
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
                .appFont(weight: .bold, size: 36,foregroundColor: .primaryTextCl)
            
            Text("Let's start your journey")
                .appFont(weight: .medium, size: 18,foregroundColor: .secondaryTextCl)
        }
    }
    
    var nameField: some View {
        VStack(alignment: .leading) {
            Text("Full name")
                .appFont(weight: .bold, size: 12,foregroundColor: .secondaryTextCl)
            
            TextField("", text: $vm.name)
                .floatingPlaceholderStyle(
                    placeholder: "Steve Jobs",
                    text: $vm.name,
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
            
            TextField("", text: $vm.email)
                .floatingPlaceholderStyle(
                    placeholder: "example@example.com",
                    text: $vm.email,
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
            navigationPath.append(RegistrationStep.smokingHabits)
        } label: {
            Text("Continue")
                .appFont(weight: .bold, size: 16, foregroundColor: .white)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(vm.isContinueButtonValid ? .primaryAccentCl : .primaryAccentCl.opacity(0.5))
                )
        }
        .padding(.horizontal,24)
        .disabled(!vm.isContinueButtonValid)
    }
}

#Preview {
    RegisterView()
        .modelContainer(for: Item.self, inMemory: true)
}
