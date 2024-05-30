//
//  ScheduleView.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var addNewRemainderViewModel : AddNewRemainderViewModel
    @State var isSelected = false
    @State var selectedDate = Date()
    var body: some View {
        VStack{
            HStack {
                Text("Time and Schedule")
                    .font(.system(size: 15.0))
                Spacer()
            }
            ScrollView(.horizontal , showsIndicators: false) {
                HStack {
                    ForEach(addNewRemainderViewModel.scheduleTypes , id: \.self) {time in
                        getScheduleView(scheduleTime: time)
                            .onTapGesture {
                                switch time {
                                case .customizeTime :
                                    addNewRemainderViewModel.isPresentDatePickerSheet = true
                                default :
                                    addNewRemainderViewModel.scheduleTime = time
                                    addNewRemainderViewModel.selectedDate = Date().convertToDateString(formatter: .dateOnly)
                                    addNewRemainderViewModel.selectedTime = time.getTime()
                                }
                                
                            }
                            .id(time)
                            
                    }
                }
            }

        }
        .onReceive(addNewRemainderViewModel.$scheduleTime, perform: { value in
            addNewRemainderViewModel.selectedScheduleTime = value
        })
    }
    
    @ViewBuilder
    private func getScheduleView(scheduleTime : ScheduleTime) -> some View {
            let selected = addNewRemainderViewModel.selectedScheduleTime == scheduleTime
           
            switch scheduleTime {
            case .customizeTime:
                Text(addNewRemainderViewModel.selectedTime.isEmpty ? "Customize time" : addNewRemainderViewModel.selectedTime)
                    .font(.caption)
                    .padding()
                    .background((selected ? Color.blue.opacity(0.7) : Color.clear), alignment: .center)
                    .edgesIgnoringSafeArea(.all)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray.opacity(0.3) , lineWidth: 1)
                        .shadow(radius: 3),
                        alignment: .center
                    )
            default :
                Text(scheduleTime.getTitle())
                    .font(.caption)
                    .padding()
                    .background((selected ? Color.blue.opacity(0.7) : Color.clear), alignment: .center)
                    .edgesIgnoringSafeArea(.all)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray.opacity(0.3) , lineWidth: 1)
                        .shadow(radius: 3),
                        alignment: .center
                    )
            }
        
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
            .environmentObject(AddNewRemainderViewModel())
    }
}
