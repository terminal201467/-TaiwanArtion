//
//  CalendarLogic.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/2.
//

import Foundation

class CalendarLogic {
    
    static let shared = CalendarLogic()
    
    private var dates: [Date] = []
    
    private let calendar = Calendar.current
    
    private let currentDay = Date()
    
    private lazy var currentMonth = calendar.component(.month, from: currentDay)
    
    private lazy var firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDay))!
    
    private lazy var weekdayOffset = (calendar.component(.weekday, from: firstDayOfMonth) + 5) % 7 // 計算偏移量
    
    //MARK: - Initialization
//    init() {
//        generateCalendarDates()
//        print("currentMonth:\(currentMonth)")
//    }
    
    //MARK: - Logic Method
    
//    func generateCalendarDates() {
//        var dateComponents = DateComponents()
//        dateComponents.year = currentYear
//        dateComponents.month = currentMonth
//        dateComponents.day = 1
//
//        guard let firstDayOfMonth = calendar.date(from: dateComponents) else {
//            fatalError("Failed to create start date.")
//        }
//
//        let date = calendar.date(byAdding: .day, value: indexPath.item, to: firstDayOfMonth)
//
//        let isCurrentMonth = calendar.isDate(date!, equalTo: currentDay, toGranularity: .month)
//
//        let weekDay = calendar.component(.weekday, from: date!)
//
//        guard let DayOfMonth = calendar.date(byAdding: .month, value: 1, to: firstDayOfMonth) else {
//            fatalError("Failed to create end date.")
//        }
//
//        var currentDateIterator = firstDayOfMonth
//        while currentDateIterator < endDayOfMonth {
//            self.dates.append(currentDateIterator)
//            currentDateIterator = calendar.date(byAdding: .day, value: 1, to: currentDateIterator)!
//        }
//    }
    
    //MARK: -Year
    private lazy var currentYear = calendar.component(.year, from: currentDay)
    
    func getCurrentYear() -> Int {
        print("currentYear:\(currentYear)")
        return currentYear
    }
    
    //MARK: -Month
    private lazy var currentSelectedMonth: Month = Month(rawValue: currentMonth - 1)!
    
    func monthCellForRowAt(indexPath: IndexPath) -> (month: Month, isSelected: Bool) {
        let month = Month(rawValue: indexPath.row)!
        let isSelected = Month(rawValue: indexPath.row) == currentSelectedMonth
        return (month, isSelected)
    }
    
    func monthDidSelectedRowAt(indexPath: IndexPath) {
        currentSelectedMonth = Month(rawValue: indexPath.row)!
    }

    //MARK: -Date
    
    func dateCellForRowAt(indexPath: IndexPath) -> (dateString: String, date: Date, isToday: Bool, isCurrentMonth: Bool) {
        let date = calendar.date(byAdding: .day, value: indexPath.item - weekdayOffset, to: firstDayOfMonth)!
        let isCurrentMonth = calendar.isDate(date, equalTo: currentDay, toGranularity: .month)
        let isToday = calendar.isDateInToday(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let dateString = dateFormatter.string(from: date)
        return (dateString, date, isToday, isCurrentMonth)
    }

    func dateDidSelectedRowAt(indexPath: IndexPath) {
        let selectedDate = dateCellForRowAt(indexPath: indexPath).date
        print("Selected Date: \(selectedDate)")
    }

}
