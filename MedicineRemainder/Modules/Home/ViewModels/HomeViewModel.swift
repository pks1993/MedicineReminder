//
//  HomeViewModel.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import Foundation
import Combine
import UserNotifications

protocol HomeViewModelProtocol {
    func getAllNewRemainders()
    func deletRemainderById(remainderId : String)
    
    var allRemaindersCurrentValueSubject : CurrentValueSubject<[RemainderObj]?,Never>{get}
    var isDeletedCurrentValueSubject : CurrentValueSubject<Bool?,Never>{get}
}
class HomeViewModel : ObservableObject {
    let model = HomeModel()
    let remainderManager = RemainderManager.shared
    var anyCancellabl = Set<AnyCancellable>()
    
    @Published var dateTypes : [DateType] = [.today , .week , .month]
    @Published var selectedDateType : DateType = .today
    @Published var selectedDayShort : String = ""
    @Published var selectedDay : Int = 0
    @Published var selectedDate : Date = Date()
    @Published var isPresentBottomSheetAlert : Bool = false
    
    @Published var day : Int = 0
    
    @Published var allRemainders : [RemainderObj] = []
    @Published var selectedRemainder : RemainderObj? = nil
    @Published var isShowDeletedAlert : Bool = false
    @Published var isEmptyData : Bool = false
    @Published var isNavigateToEditView : Bool = false
    @Published var isNavigateToDetailView : Bool = false 
    init() {
        bindObserver()
    }
    
    func bindObserver() {
        allRemaindersCurrentValueSubject.sink { value in
            self.allRemainders = value ?? []
            self.allRemainders.forEach { obj in
                self.remainderManager.scheduleNotification(remainderObj: obj)
            }
            self.isEmptyData = self.allRemainders.isEmpty
        }
        .store(in: &anyCancellabl)
        
        isDeletedCurrentValueSubject.drop {
            $0 == nil
        }
        .sink {
            if let isSuccess = $0 {
                self.allRemainders.removeAll()
                self.getAllNewRemainders()
                self.isShowDeletedAlert = isSuccess
            }
            else {
                self.isShowDeletedAlert = false
            }
            
        }
        .store(in: &anyCancellabl)
        
        $selectedDateType.sink {
            print("Date Type :::::: \($0)")
            self.getAllNewRemainders()
            switch $0 {
            case .today :
                self.allRemainders = self.allRemainders.filter({
                    let currentDate = Calendar.current.dateComponents([.year, .month, .day], from: Date())
                    let remainderDate = Calendar.current.dateComponents([.year , .month , .day], from: $0.remainderDate)

                    return remainderDate == currentDate
                })
            case .week :
                self.allRemainders = self.allRemainders.filter({
                  
                    // Get the current date
                    let currentDate = Date()

                    // Create a calendar instance
                    let calendar = Calendar.current

                    // Get the date components for the current date
                    let currentComponents = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: currentDate)

                    // Get the start of the week
                    var startOfWeekComponents = DateComponents()
                    startOfWeekComponents.weekday = calendar.firstWeekday
                    startOfWeekComponents.weekOfYear = currentComponents.weekOfYear
                    startOfWeekComponents.yearForWeekOfYear = currentComponents.yearForWeekOfYear

                    if let startOfWeek = calendar.date(from: startOfWeekComponents) {
                        // Get the end of the week
                        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
                        
                        // Check if your date falls within this week
                        let remainderDate = Calendar.current.dateComponents([.year , .month , .day], from: $0.remainderDate).date ?? Date()
                        
                        return remainderDate >= startOfWeek && remainderDate <= endOfWeek && currentDate.getMonth() == remainderDate.getMonth()
                        
                    }
                    return false
                })
            case .month :
                self.allRemainders = self.allRemainders.filter({$0.remainderDate.getMonth() == Date().getMonth()})
            }
            
        }
        .store(in: &anyCancellabl)
        
        $selectedDay.sink {
            self.getAllNewRemainders()
            var currentDate = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            currentDate.day = $0
            
            self.allRemainders = self.allRemainders.filter({
                let remainderDate = Calendar.current.dateComponents([.year , .month , .day], from: $0.remainderDate)

                return remainderDate == currentDate
            })
        }
        .store(in: &anyCancellabl)
    }
    
    
}

extension HomeViewModel : HomeViewModelProtocol {
    func deletRemainderById(remainderId: String) {
        model.deletRemainderById(remainderId: remainderId)
    }
    
    var isDeletedCurrentValueSubject: CurrentValueSubject<Bool?, Never> {
        return model.isDeletedCurrentValueSubject
    }
    
    func getAllNewRemainders() {
        model.getAllNewRemainders()
    }
    
    var allRemaindersCurrentValueSubject: CurrentValueSubject<[RemainderObj]?, Never> {
        return model.allRemaindersCurrentValueSubject
    }
    
    
}
