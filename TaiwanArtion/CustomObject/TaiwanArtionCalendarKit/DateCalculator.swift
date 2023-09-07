//
//  TaiwanArtionCalendarInfo.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/9/5.
//

import Foundation

class DateCalculator {
    
    var selectedDateCompletion: ((Date) -> Void)?
    
    private var selectedDate: Date?
    //calendar
    private let calendar = Calendar.current
    //Date
    private let currentDate = Date()
    //Month
    private lazy var currentMonth = calendar.component(.month, from: currentDate)
    //Year
    private lazy var currentYear = calendar.component(.year, from: currentDate)
    
    private lazy var firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
    
    private lazy var weekdayOffset = (calendar.component(.weekday, from: firstDayOfMonth) + 5) % 7 // 計算偏移量
    
    private var eventsString: [String] = []
    
    private var eventsDate: [Date] {
        return eventsString.map { dateString in
            let dateFormat = DateFormatter()
            return dateFormat.date(from: dateString) ?? Date()
        }
    }
    
    var currentDateString: String {
        return currentDate.formatted()
    }
    
    func setCalendarYear(year: Int) {
        currentYear = year
    }
    
    func setCalendarMonth(month: Int) {
        currentMonth = month
    }
    
    func dateCellForRowAt(indexPath: IndexPath) -> (dateString: String, date: Date, isToday: Bool, isCurrentMonth: Bool) {
        let date = calendar.date(byAdding: .day, value: indexPath.item - weekdayOffset, to: firstDayOfMonth)!
        let isCurrentMonth = calendar.isDate(date, equalTo: currentDate, toGranularity: .month)
        let isToday = calendar.isDateInToday(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let dateString = dateFormatter.string(from: date)
        return (dateString, date, isToday, isCurrentMonth)
    }
    
    func eventDateCellForRowAt(indexPath: IndexPath) -> Bool {
        let date = calendar.date(byAdding: .day, value: indexPath.item - weekdayOffset, to: firstDayOfMonth)!
        let isEventDate = eventsDate[indexPath.row] == date
        return isEventDate
    }
    
    func singleDidSelectedRowAt(indexPath: IndexPath) {
        let date = calendar.date(byAdding: .day, value: indexPath.item - weekdayOffset, to: firstDayOfMonth)!
        selectedDate = date
        selectedDateCompletion?(date)
    }
    
    func multipleSelectedRowAt(indexPaths: [IndexPath]) -> [Date] {
        return indexPaths.map { indexPath in
            calendar.date(byAdding: .day, value: indexPath.item - weekdayOffset, to: firstDayOfMonth)!
        }
    }
}
