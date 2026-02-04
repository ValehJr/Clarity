//
//  SmokingHabitsView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 01.02.26.
//

import SwiftUI

struct SmokingHabitsView: View {
    @ObservedObject var vm: RegisterViewModel
    @EnvironmentObject var authViewModel: AuthViewModel

    @FocusState var isPackSizeFocused: Bool
    @FocusState var isPackPriceFocused: Bool
    @FocusState var isDailyAverageFocused: Bool
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.backgroundThreeCl,.backgroundTwoCl, .backgroundCl]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .ignoresSafeArea(.all)
            
            
            VStack(spacing:24) {
                title
                    .padding(.bottom,24)
                
                packSizeField
                
                packPriceField
                
                dailyAverageField
                
                finishButton
                Spacer()
            }
            .padding(.top,60)
        }
        .onTapGesture {
            isPackSizeFocused = false
            isPackPriceFocused = false
            isDailyAverageFocused = false
        }
        .onAppear {
            isPackSizeFocused = true
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(.chevronLeftIc)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.primaryTextCl)
                }
            }
            .sharedBackgroundVisibility(.hidden)
        }
    }
    
    var title: some View {
        VStack(spacing: 8) {
            Text("Smoking Habits ")
                .appFont(weight: .bold, size: 36,foregroundColor: .primaryTextCl)
            
            Text("This helps us calculate your savings.")
                .appFont(weight: .medium, size: 18,foregroundColor: .secondaryTextCl)
        }
    }
    
    var packSizeField: some View {
        VStack(alignment: .leading) {
            Text("CIGARETTES PER PACK")
                .appFont(weight: .bold, size: 12,foregroundColor: .secondaryTextCl)
            
            TextField("", text: $vm.packSize)
                .imagePlaceholderStyle(
                    placeholder: "20",
                    text: $vm.packSize,
                    placeholderColor: .secondaryTextCl,
                    strokeColor: .fieldStrokeCl,
                    backgroundColor: .fieldStrokeCl,
                    leftIcon: Image(.boxIc)
                )
                .focused($isPackSizeFocused)
                .autocorrectionDisabled(true)
                .appFont(weight: .medium, size: 14)
        }
        .padding(.horizontal,24)
    }
    
    var packPriceField: some View {
        VStack(alignment: .leading) {
            Text("PRICE PER PACK")
                .appFont(weight: .bold, size: 12,foregroundColor: .secondaryTextCl)
            
            TextField("", text: $vm.packPrice)
                .imagePlaceholderStyle(
                    placeholder: "20",
                    text: $vm.packPrice,
                    placeholderColor: .secondaryTextCl,
                    strokeColor: .fieldStrokeCl,
                    backgroundColor: .fieldStrokeCl,
                    leftIcon: Image(.moneyIc)
                )
                .focused($isPackPriceFocused)
                .autocorrectionDisabled(true)
                .appFont(weight: .medium, size: 14)
        }
        .padding(.horizontal,24)
    }
    
    var dailyAverageField: some View {
        VStack(alignment: .leading) {
            Text("DAILY AVERAGE")
                .appFont(weight: .bold, size: 12,foregroundColor: .secondaryTextCl)
            
            TextField("", text: $vm.dailyAverage)
                .imagePlaceholderStyle(
                    placeholder: "20",
                    text: $vm.dailyAverage,
                    placeholderColor: .secondaryTextCl,
                    strokeColor: .fieldStrokeCl,
                    backgroundColor: .fieldStrokeCl,
                    leftIcon: Image(.activityIc)
                )
                .focused($isDailyAverageFocused)
                .autocorrectionDisabled(true)
                .appFont(weight: .medium, size: 14)
        }
        .padding(.horizontal,24)
    }
    
    var finishButton: some View {
        Button {
            Task {
                await vm.completeRegistration(authViewModel: authViewModel)
            }
        } label: {
            Text("Finish Setup")
                .appFont(weight: .bold, size: 16, foregroundColor: .white)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(vm.isFinishButtonValid ? .successCl : .successCl.opacity(0.5))
                )
        }
        .padding(.horizontal,24)
        .disabled(!vm.isFinishButtonValid)
    }
    
}

#Preview {
    SmokingHabitsView(vm: RegisterViewModel())
}
