//
//  Date + Extension.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 29/5/24.
//

import Foundation


extension Date {
    func convertToDateString(formatter : DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        
        // Set the input date format
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        // convert input date to string
        
        let dateString = dateFormatter.string(from: self)
        
        // Convert the input string to a Date object
        if let date = dateFormatter.date(from: dateString) {
            // Update date formatter to the desired output format
            dateFormatter.dateFormat = formatter.rawValue
            
            // Convert date to string in desired format
            let formattedDateString = dateFormatter.string(from: date)
            
            return formattedDateString
        } else {
            return ""
        }
    }
    
    func getMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self)
    }
    
    func getDayShort() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
    
    func getDayNumber() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        return components.day ?? 0
    }
    
    func getHour() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "hh"
        return Int(dateFormatter.string(from: self)) ?? 0
    }
    
    func getMinute() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "mm"
        return Int(dateFormatter.string(from: self)) ?? 0
    }
    
    func getWeek() -> [Date] {
        let currentDate = Date()
        
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: currentDate)
        
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        
        let daysMonth = (range.lowerBound ..< range.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: currentDate) }
        
        return daysMonth
    }
    
    func getWeekday() -> Int {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: self)
        
        return weekday
        // Adjust for Sunday being represented as 1
//        return (weekday + 5) % 7
    }
}
