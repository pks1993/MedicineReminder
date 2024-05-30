//
//  AddNewRemainderModel.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import Foundation
import Combine

protocol AddNewRemainderModelProtocol {
    func addNewRemainder(remainderObj : RemainderObj)
    func updateNewRemainderById(remainderObj : RemainderObj)
    
    var addNewRemainderCurrentValueSubject : CurrentValueSubject<RemainderObj?,Never>{get}
    var updateNewRemainderCurrentValueSubject : CurrentValueSubject<RemainderObj?,Never>{get}
}

class AddNewRemainderModel : ObservableObject {
    let databaseManager = DatabaseManager.shared
    var anyCancellable = Set<AnyCancellable>()
    
    private let newRemainderCurrentValueSubject = CurrentValueSubject<RemainderObj?,Never>(nil)
    private let updateRemainderCurrentValueSubject = CurrentValueSubject<RemainderObj?,Never>(nil)
    
    private func addRemainder(remainderObj : RemainderObj) {
        databaseManager.savedRemainder(remainderObj: remainderObj)
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    print("Error ::::: \(error.localizedDescription)")
                default :
                    break
                }
            } receiveValue: { obj in
                self.newRemainderCurrentValueSubject.send(obj)
            }
            .store(in: &anyCancellable)

    }
    
    private func updateRemainderById(remainderObj : RemainderObj) {
        databaseManager.updateRemainderById(remainderObj: remainderObj)
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    print("Error ::::: \(error.localizedDescription)")
                default :
                    break
                }
            } receiveValue: { obj in
                self.updateRemainderCurrentValueSubject.send(obj)
            }
            .store(in: &anyCancellable)
    }
    
}

extension AddNewRemainderModel : AddNewRemainderModelProtocol {
    func addNewRemainder(remainderObj : RemainderObj) {
        addRemainder(remainderObj : remainderObj)
    }
    
    func updateNewRemainderById(remainderObj: RemainderObj) {
        updateRemainderById(remainderObj: remainderObj)
    }
    
    var addNewRemainderCurrentValueSubject: CurrentValueSubject<RemainderObj?, Never> {
        return newRemainderCurrentValueSubject
    }
    
    var updateNewRemainderCurrentValueSubject: CurrentValueSubject<RemainderObj?, Never> {
        return updateRemainderCurrentValueSubject
    }
    
    
}
