//
//  DateTypeView.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import SwiftUI

struct DateTypeView: View {
    @EnvironmentObject var homeViewModel : HomeViewModel
    var body: some View {
        HStack {
            ForEach(homeViewModel.dateTypes , id:\.self) { type in
                Spacer()
                getDateItemView(type: type)
                Spacer()
            }
        }
        .padding()
        
    }
    
    @ViewBuilder
    private func getDateItemView(type : DateType) -> some View {
        VStack {
            Text(type.getTitle())
                .font(.system(.headline))
                .foregroundColor(type == homeViewModel.selectedDateType ? .purple : .black)
            if homeViewModel.selectedDateType == type {
                withAnimation {
                    Divider()
                        .frame(width: CGFloat(type.getTitle().count) * 13 , height: 5)
                        .background(Color.purple , alignment: .center)
                        .cornerRadius(3)
                }
            }
        }
        .onTapGesture {
            homeViewModel.selectedDateType = type
        }
        
    }
}

struct DateTypeView_Previews: PreviewProvider {
    static var previews: some View {
        DateTypeView()
            .environmentObject(HomeViewModel())
    }
}
