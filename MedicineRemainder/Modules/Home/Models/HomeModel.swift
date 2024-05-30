//
//  HomeModel.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 29/05/2024.
//

import Foundation
import Combine

protocol HomeModelProtocol {
    func getAllNewRemainders()
    func deletRemainderById(remainderId : String)
    
    var allRemaindersCurrentValueSubject : CurrentValueSubject<[RemainderObj]?,Never>{get}
    var isDeletedCurrentValueSubject : CurrentValueSubject<Bool?,Never>{get}
}
class HomeModel : ObservableObject {
    let databaseManager = DatabaseManager.shared
    var anyCancellable = Set<AnyCancellable>()
    
    private var remaindersCurrentValueSubject = CurrentValueSubject<[RemainderObj]?,Never>(nil)
    private var deleteRemainderCurrentValueSubject = CurrentValueSubject<Bool?,Never>(nil)
    private func getAllRemainders() {
        databaseManager.getAllRemainders()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error :::::: \(error.localizedDescription)")
                default :
                    break
                }
            } receiveValue: {
                if let objs = $0 {
                    self.remaindersCurrentValueSubject.send(objs)
                }
                else {
                    self.remaindersCurrentValueSubject.send(nil)
                }
            }
            .store(in: &anyCancellable)

    }
    
    private func deleteRemainder(remainderId : String) {
        print("deleteRemainder")

        databaseManager.deleteRemainderById(remainderId: remainderId)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error :::::::: \(error.localizedDescription)")
                default :
                    break
                }
            } receiveValue: {
                self.deleteRemainderCurrentValueSubject.send($0)
            }
            .store(in: &anyCancellable)

    }
}

extension HomeModel : HomeModelProtocol {
    func deletRemainderById(remainderId: String) {
        deleteRemainder(remainderId: remainderId)
    }
    
    var isDeletedCurrentValueSubject: CurrentValueSubject<Bool?, Never> {
        return deleteRemainderCurrentValueSubject
    }
    
    func getAllNewRemainders() {
        getAllRemainders()
    }
    
    var allRemaindersCurrentValueSubject: CurrentValueSubject<[RemainderObj]?, Never> {
        return remaindersCurrentValueSubject
    }
}
