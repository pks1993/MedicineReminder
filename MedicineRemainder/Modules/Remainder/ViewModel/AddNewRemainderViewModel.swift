//
//  AddNewRemainderViewModel.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import Foundation
import Combine

protocol AddNewRemainderViewModelProrocol {
    func addNewRemainder(remainderObj : RemainderObj)
    func updateNewRemainderById(remainderObj : RemainderObj)
    
    var addNewRemainderCurrentValueSubject : CurrentValueSubject<RemainderObj?,Never>{get}
    var updateNewRemainderCurrentValueSubject : CurrentValueSubject<RemainderObj?,Never>{get}
}

class AddNewRemainderViewModel : ObservableObject {
    let model = AddNewRemainderModel()
    var anyCancellable = Set<AnyCancellable>()
    
    var medicineTypes : [MedicineType] = [.tablets , .capsules , .creams , .patches , .liquids , .injections]
    var scheduleTypes : [ScheduleTime] = [.afterWakeUp , .beforeLunch , .afterLunch , .beforeDinner , .afterDinner , .beforeBed , .midNight,  .customizeTime]
    var durationTypes : [DurationType] = [.daily , .weekly , .monthly]
    
    @Published var selectedMedicineType : MedicineType = .tablets
    @Published var selectedScheduleTime : ScheduleTime = .afterWakeUp
    @Published var selectedDuration : DurationType = .daily
    @Published var medicineName : String = ""
    @Published var noteStr : String = ""
    
    @Published var isActiveSave : Bool = true
    @Published var isSuccessfullyCreated : Bool = false
    @Published var isPresentDurationView : Bool = false
    
    
    @Published var scheduleTime : ScheduleTime = .afterWakeUp
    @Published var medicineType : MedicineType = .tablets
    @Published var durationType : DurationType = .daily
    
    @Published var isPresentDatePickerSheet : Bool = false
    
    @Published var selectedDate : String = ""
    @Published var selectedTime : String = ""
    
    init() {
        bindObserver()
    }
    
    private func bindObserver() {
        addNewRemainderCurrentValueSubject.sink {
            if let obj = $0 {
                self.isSuccessfullyCreated = true
            }
            else {
                self.isSuccessfullyCreated = false
            }
        }
        .store(in: &anyCancellable)
        
        updateNewRemainderCurrentValueSubject.sink {
            if let obj = $0 {
            self.isSuccessfullyCreated = true
        }
            else {
                self.isSuccessfullyCreated = false
            }
        }
        .store(in: &anyCancellable)
        
        $medicineName.sink {
            self.isActiveSave = !$0.isEmpty
        }
        .store(in: &anyCancellable)
    }
    
    func createObj() -> RemainderObj {
        let obj = RemainderObj()
        obj.objId = getCurrentDateInMilliseconds()
        obj.medicineName = medicineName
        obj.medicineType = selectedMedicineType.rawValue
        obj.scheduleType = selectedScheduleTime.getTime()
        obj.durationType = selectedDuration.getTitle()
        obj.noteStr = noteStr
        obj.remainderDate = selectedDate.convertToDate(formatter: .dateOnly)
        obj.remainderTime = selectedTime.convertToDate(formatter: .timeOnly)
        return obj
    }
    
    // Function to get the current date and time in milliseconds
    func getCurrentDateInMilliseconds() -> String {
        let currentDate = Date()
        let milliseconds = currentDate.timeIntervalSince1970 * 1000
        return String(format: "%.0f", milliseconds)
    }
}

extension AddNewRemainderViewModel : AddNewRemainderViewModelProrocol {
    func addNewRemainder(remainderObj : RemainderObj) {
        model.addNewRemainder(remainderObj: remainderObj)
    }
    
    func updateNewRemainderById(remainderObj: RemainderObj) {
        model.updateNewRemainderById(remainderObj: remainderObj)
    }
    
    var addNewRemainderCurrentValueSubject: CurrentValueSubject<RemainderObj?, Never> {
        return model.addNewRemainderCurrentValueSubject
    }
    
    var updateNewRemainderCurrentValueSubject: CurrentValueSubject<RemainderObj?, Never> {
        return model.updateNewRemainderCurrentValueSubject
    }
    
    
}
