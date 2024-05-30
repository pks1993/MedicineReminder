//
//  DatePicketSheetView.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 29/5/24.
//

import SwiftUI

struct DatePickerSheetView: View {
    @EnvironmentObject var addRemainderViewModel : AddNewRemainderViewModel
    @State var selectedDate = Date()
  
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                Spacer()
                DatePicker("Please enter a date", selection: $selectedDate)
                Button("Done") {
                    selectedDate = selectedDate.convertToDateString(formatter: .dateAndTime).convertToDate(formatter: .dateAndTime)
                    addRemainderViewModel.selectedScheduleTime = .customizeTime
                    addRemainderViewModel.selectedDate = selectedDate.convertToDateString(formatter: .dateOnly)
                    addRemainderViewModel.selectedTime = selectedDate.convertToDateString(formatter: .timeOnly)
                    addRemainderViewModel.isPresentDatePickerSheet = false
                }
                .padding()
                
            }
            .frame(height: reader.size.height * 0.3)
        }
    }
}

struct DatePickerSheetView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerSheetView()
            .environmentObject(AddNewRemainderViewModel())
    }
}
