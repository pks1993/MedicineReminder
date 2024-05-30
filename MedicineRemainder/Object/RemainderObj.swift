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
    
}
