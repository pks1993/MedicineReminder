//
//  RemainderManager.swift
//  MedicineRemainder
//
//  Created by Phyo Kyaw Swar on 29/5/24.
//

import UserNotifications
class RemainderManager {
    static let shared = RemainderManager()
    
    func scheduleNotification(remainderObj : RemainderObj) {
        let content = UNMutableNotificationContent()
        content.title = remainderObj.medicineName
        content.body = remainderObj.noteStr
        content.sound = UNNotificationSound.default
        
        /// create date component with DB date
        
        var dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())

        dateComponent.day = remainderObj.remainderDate.getDayNumber()
        dateComponent.hour = remainderObj.remainderTime.getHour()
        dateComponent.minute = remainderObj.remainderTime.getMinute()
        
        print("Date Component :::::: \(dateComponent)")
        
        // Configure the trigger for a notification saved date
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        // Create a request to schedule the notification
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully!")
            }
        }
    }
}
