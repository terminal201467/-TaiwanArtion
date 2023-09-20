//
//  NotifyModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import Foundation

//MARK: - NotifyModel
struct Notification {
    
    var title: String
    var description: String
    var dateString: String
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString) ?? Date()
    }
    
    var dateBefore: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let pastDate = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            
            let currentDate = Date()
            let components = calendar.dateComponents([.day], from: pastDate, to: currentDate)
            if let days = components.day {
                return days
            }
        }
        return 0
    }
}
