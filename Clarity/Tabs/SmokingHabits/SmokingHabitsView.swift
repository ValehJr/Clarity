//
//  SmokingHabitsView.swift
//  Clarity
//
//  Created by Valeh Ismayilov on 01.02.26.
//

import SwiftUI

struct SmokingHabitsView: View {
    @State var packSize: String = ""
    @State var packPrice: String = ""
    @State var dailyAverage: String = ""
    
    @FocusState var isPackSizeFocused: Bool
    @FocusState var isPackPriceFocused: Bool
    @FocusState var isDailyAverageFocused: Bool
    
    var body: some View {
        ZStack {
            Color.backgroundCl.ignoresSafeArea()
            VStack(spacing:24) {
                title
                    .padding(.bottom,24)
                
                packSizeField
                
                packPriceField
                
                dailyAverageField
                
                finishButton
                Spacer()
            }
            .padding(.top,90)
        }
        .onTapGesture {
            isPackSizeFocused = false
            isPackPriceFocused = false
            isDailyAverageFocused = false
        }
    }
    
    var title: some View {
        VStack(spacing: 8) {
            Text("Smoking Habits ")
                .appFont(weight: .bold, size: 36,foregroundColor: .prrimaryTextCl)
            
            Text("This helps us calculate your savings.")
                .appFont(weight: .medium, size: 18,foregroundColor: .secondaryTextCl)
        }
    }
    
    var packSizeField: some View {
        VStack(alignment: .leading) {
            Text("CIGARETTES PER PACK")
                .appFont(weight: .bold, size: 12,foregroundColor: .secondaryTextCl)
            
            TextField("", text: $packSize)
                .imagePlaceholderStyle(
                    placeholder: "20",
                    text: $packSize,
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
            
            TextField("", text: $packPrice)
                .imagePlaceholderStyle(
                    placeholder: "20",
                    text: $packPrice,
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
            
            TextField("", text: $dailyAverage)
                .imagePlaceholderStyle(
                    placeholder: "20",
                    text: $dailyAverage,
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
            
        } label: {
            Text("Finish Setup")
                .appFont(weight: .bold, size: 16, foregroundColor: .white)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.successCl)
                )
        }
        .padding(.horizontal,24)
    }
    
}

#Preview {
    SmokingHabitsView()
}
