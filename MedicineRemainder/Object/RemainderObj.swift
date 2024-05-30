//
//  RemainderObj.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import Foundation
import Realm
import RealmSwift

class RemainderObj : Object , ObjectKeyIdentifiable  {
    @Persisted var objId : String = ""
    @Persisted var medicineName : String = "Testing"
    @Persisted var medicineType : String = "tablets"
    @Persisted var scheduleType : String = "daily"
    @Persisted var durationType : String = "1 months"
    @Persisted var noteStr : String = "testing"
    @Persisted var remainderDate : Date = Date()
    @Persisted var remainderTime : Date = Date()
    
    //    @objc dynamic var objId : String = ""
    //    @objc dynamic var medicineName : String = "Testing"
    //    @objc dynamic var medicineType : String = "tablets"
    //    @objc dynamic var scheduleType : String = "daily"
    //    @objc dynamic var durationType : String = "1 months"
    //    @objc dynamic var noteStr : String = "testing"
    //    @objc dynamic var remainderDate : Date = Date()
    //    @objc dynamic var remainderTime : Date = Date()
    //
    //    override class func primaryKey() -> String? {
    //        return self.objId
    //    }
}
