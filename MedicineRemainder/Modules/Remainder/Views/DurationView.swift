//
//  DurationView.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import SwiftUI

struct DurationView: View {
    @EnvironmentObject var addRemainderViewModel : AddNewRemainderViewModel
    var body: some View {
        HStack{
            getDurationView()
        }
        .onReceive(addRemainderViewModel.$durationType, perform: { value in
            addRemainderViewModel.selectedDuration = value
        })
    }
    
    @ViewBuilder
    private func getDurationView() -> some View {
        VStack {
            HStack{
                Text("Duration")
                    .font(.system(size: 15.0))
                Spacer()
            }
            
            Button {
                addRemainderViewModel.isPresentDurationView = true
            } label: {
                HStack {
                    Spacer()
                        .frame(width: 15)
                    Text(addRemainderViewModel.selectedDuration.getTitle())
                        .font(.caption)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.up.chevron.down")
                        .accentColor(.black)
                    Spacer()
                        .frame(width: 15)
                }
            }
            .frame(height: 40)
            .background(Color.gray.opacity(0.3) , alignment: .center)
            .cornerRadius(8)
            

        }
    }
}

struct DurationView_Previews: PreviewProvider {
    static var previews: some View {
        DurationView()
    }
}
