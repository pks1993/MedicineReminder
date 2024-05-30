//
//  RemainderItemView.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 29/05/2024.
//

import SwiftUI

struct RemainderItemView: View {
    @EnvironmentObject var homeViewModel : HomeViewModel
    @Binding var remainderObj : RemainderObj
    var body: some View {
        HStack(spacing : 15) {
            /// note : get medicine type image view
            getImageView()
            
            /// note : get medicine name and Time
            getMedicineNameAndTime()
            
            Spacer()
            
            ///  note : get more button View
            getMoreButtonView()
            
        }
        
        .frame(height: 80)
        .padding()
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray.opacity(0.3) , lineWidth: 1)
                .shadow(radius: 3),
            alignment: .center
        )
        .onAppear(perform: {
            homeViewModel.selectedRemainder = remainderObj
        })
    
    }
    
    @ViewBuilder
    private func getImageView() -> some View {
        let medicineType = MedicineType(rawValue: remainderObj.medicineType) ?? .tablets
        let imageName = medicineType.getImageName()
        
        Image(imageName)
            .resizable()
            .frame(width : 50 , height: 50)
    }
    
    @ViewBuilder
    private func getMedicineNameAndTime() -> some View {
        
        VStack(alignment: .leading) {
            Text(remainderObj.medicineName)
                .font(.system(size: 15.0))
            
            Text((ScheduleTime(rawValue: remainderObj.scheduleType) ?? .afterWakeUp).getTitle())
                .font(.caption)
                .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                .background(Color.blue.opacity(0.7), alignment: .center)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray.opacity(0.3) , lineWidth: 1)
                        .shadow(radius: 3),
                    alignment: .center
                )
                
        }
    }
    
    @ViewBuilder
    private func getMoreButtonView() -> some View {
        VStack{
            Button {
                homeViewModel.isPresentBottomSheetAlert = true
            } label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .frame(width: 28 , height: 7)
                    .accentColor(.black)
            }
            Spacer()
        }

    }
}

struct RemainderItemView_Previews: PreviewProvider {
    static var previews: some View {
        RemainderItemView(remainderObj: .constant(RemainderObj()))
    }
}
