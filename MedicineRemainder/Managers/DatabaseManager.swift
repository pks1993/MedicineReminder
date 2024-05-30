//
//  DatabaseManager.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import Foundation
import Realm
import RealmSwift
import Combine

protocol DatabaseManagerProtocol {
    /// insert obj , update obj
    func savedRemainder(remainderObj : RemainderObj) -> AnyPublisher<RemainderObj?,Error>
    func updateRemainderById(remainderObj : RemainderObj) -> AnyPublisher<RemainderObj?,Error>
    
    /// select all , select by Id
    func getAllRemainders() -> AnyPublisher<[RemainderObj]?,Error>
    func getRemainderById(remainderId : String) -> AnyPublisher<RemainderObj?,Error>

    /// delete all , delete by id
    func deleteAllRemainders() -> AnyPublisher<Bool?,Error>
    func deleteRemainderById(remainderId : String) -> AnyPublisher<Bool?,Error>
}
class DatabaseManager : ObservableObject {

    static let shared = DatabaseManager()
    
    init() {
        configuration()
    }
    
    private func configuration() {
        print("Realm Path :::: \(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        Realm.Configuration.defaultConfiguration.schemaVersion = 1
        Realm.Configuration.defaultConfiguration.migrationBlock = { migration , oldVersion in
            
        }
    }
    
    
}

extension DatabaseManager : DatabaseManagerProtocol {
    func savedRemainder(remainderObj: RemainderObj) -> AnyPublisher<RemainderObj?, Error> {
        return Future<RemainderObj?,Error> {promise in
            do {
                let realm = try! Realm()
                try realm.write {
                    realm.create(RemainderObj.self, value: remainderObj)
                    promise(.success(remainderObj))
                }
            } catch {
                print("Failed . Error: \(error.localizedDescription)")
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func updateRemainderById(remainderObj: RemainderObj) -> AnyPublisher<RemainderObj?, Error> {
        return Future<RemainderObj?,Error> {promise in
            do {
                let realm = try! Realm()
                try realm.write {
                    if let obj = realm.objects(RemainderObj.self).filter({$0.objId == remainderObj.objId}).first {
                        realm.create(RemainderObj.self, value: remainderObj , update: .all)
                    }
                    else {
                        realm.create(RemainderObj.self , value: remainderObj)
                    }
                    
                    promise(.success(remainderObj))
                }
            }
            catch {
                print("Failed . Error: \(error.localizedDescription)")
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getAllRemainders() -> AnyPublisher<[RemainderObj]?, Error> {
        return Future<[RemainderObj]? , Error> { promise in
            do {
                let realm = try! Realm()
                try realm.write {
                    let objs = realm.objects(RemainderObj.self)
                    if !objs.isEmpty{
                        var remainders = [RemainderObj]()
                        objs.forEach {
                            remainders.append($0)
                        }
                        promise(.success(remainders))
                    }
                    else {
                        promise(.success(nil))
                    }
                }
            }
            catch {
                print("Failed . Error: \(error.localizedDescription)")
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getRemainderById(remainderId: String) -> AnyPublisher<RemainderObj?, Error> {
        return Future<RemainderObj?,Error> {promise in
            do {
                let realm = try! Realm()
                try realm.write {
                    if let obj = realm.objects(RemainderObj.self).filter({$0.objId == remainderId}).first {
                        promise(.success(obj))
                    }
                    else {
                        promise(.success(nil))
                    }
                }
            } catch {
                print("Failed . Error: \(error.localizedDescription)")
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteAllRemainders() -> AnyPublisher<Bool?, Error> {
        return Future<Bool?,Error> {promise in
            do {
                let realm = try! Realm()
                try realm.write {
                    realm.deleteAll()
                    promise(.success(true))
                }
            }
            catch {
                print("Failed . Error: \(error.localizedDescription)")
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteRemainderById(remainderId : String) -> AnyPublisher<Bool?, Error> {
        return Future<Bool?,Error> {promise in
            do {
                let realm = try! Realm()
                try realm.write {
                    if let obj = realm.objects(RemainderObj.self).filter({$0.objId == remainderId}).first {
                        realm.delete(obj)
                        promise(.success(true))
                    }
                    else {
                        promise(.success(false))
                    }
                   
                }
            }
            catch {
                print("Failed . Error: \(error.localizedDescription)")
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
