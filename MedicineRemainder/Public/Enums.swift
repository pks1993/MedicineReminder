//
//  Enums.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 28/05/2024.
//

import Foundation

/// note : date type for home view filter
enum DateType : String {
    case today
    case week
    case month
    
    func getTitle() -> String {
        switch self {
        case .today :
            return "Today"
        case .week :
            return "Week"
        case .month :
            return "Month"
        }
    }
}

/// Medicine type for add remainder
enum MedicineType : String  {
    case tablets
    case capsules
    case liquids
    case creams
    case patches
    case injections
    
    func getImageName() -> String {
        return self.rawValue
    }
}

/// schedule time for add remainder
enum ScheduleTime : String , Hashable {
    case afterWakeUp /// note : 7:30 AM
    case beforeLunch /// note : 11:30 AM
    case afterLunch /// note : 1:30 PM
    case beforeDinner /// note : 5:30 PM
    case afterDinner /// note :  6:30 PM
    case beforeBed  /// note : 9:30 PM
    case midNight /// note 11:30 PM
    case customizeTime  /// note : insert preferred time
    
    func getTitle() -> String {
        switch self {
        case .afterWakeUp:
            return "After wakeup"
        case .beforeLunch:
            return "Before lunch"
        case .afterLunch:
            return "After lunch"
        case .beforeDinner:
            return "Before dinner"
        case .afterDinner:
            return "After dinner"
        case .beforeBed:
            return "Before bed"
        case .midNight:
            return "Midnight"
        case .customizeTime:
            return "Customize time"
        }
    }
    
    func getTime() -> String {
        switch self {
        case .afterWakeUp:
            return "7:30 AM"
        case .beforeLunch:
            return "11:30 AM"
        case .afterLunch:
            return "1:30 PM"
        case .beforeDinner:
            return "5:30 PM"
        case .afterDinner:
            return "6:30 PM"
        case .beforeBed:
            return "9:30 PM"
        case .midNight:
            return "11:30 PM"
        case .customizeTime:
            return ""
        }
    }
}

/// Frequently for add remainder
enum DurationType : String {
    case daily
    case weekly
    case monthly
    
    func getTitle() -> String {
        switch self {
        case .daily :
            return "Daily"
        case .weekly :
            return "Weekly"
        case .monthly :
            return "Monthly"
        }
    }
}

/// General Date format
enum DateFormat : String {
    case dateOnly = "yyyy-MM-dd"
    case timeOnly = "hh:mm aa"
    case dateAndTime = "yyyy-MM-dd hh:mm:ss aa"
}

/// ViewMode for remainder /* edit / add new/ update */
enum AddRemainderViewMode {
    case edit
    case addNew
    case detail
    
}
