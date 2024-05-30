//
//  String + Extension.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 29/5/24.
//

import Foundation

extension String {
    func convertToDate(formatter : DateFormat) -> Date {
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale.current
//        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = formatter.rawValue
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }
}
