//
//  MedicineTypeView.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import SwiftUI

struct MedicineTypeView: View {
    @EnvironmentObject var addNewRemainderViewModel : AddNewRemainderViewModel
//    @State var selectedMedicineType : MedicineType = .tablets
    var body: some View {
        VStack {
            HStack{
                Text("Type")
                    .font(.system(size: 15.0))
                Spacer()
            }
            
            ScrollView(.horizontal , showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(addNewRemainderViewModel.medicineTypes , id: \.self) { type in
                        getMedicineTypeView(type : type)
                            .onTapGesture {
                                addNewRemainderViewModel.medicineType = type
                            }
                        
                    }
                }
            }
            
        }
        .onReceive(addNewRemainderViewModel.$medicineType, perform: { value in
            addNewRemainderViewModel.selectedMedicineType = value
        })
    }
    
    @ViewBuilder
    private func getMedicineTypeView(type : MedicineType) -> some View {
        let selected = addNewRemainderViewModel.selectedMedicineType == type
        
        ZStack {
            Image(type.getImageName())
                .resizable()
                .frame(width: 50 , height: 50)
                .padding()
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray.opacity(0.3) , lineWidth: 1)
                    .shadow(radius: 3),
                    alignment: .center
                )
            
            if selected {
                withAnimation {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 20 , height: 20)
                        .foregroundColor(.blue)
                        .padding(.leading , 50)
                        .padding(.top , -35)
                }
                
            }
        }
        
        
    }
}

struct MedicineTypeView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineTypeView()
            .environmentObject(AddNewRemainderViewModel())
    }
}
