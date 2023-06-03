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
    
    //MARK: - Initialization
    init() {
        generateCalendarDates()
    }
    
    //MARK: - Logic Method
    
    func generateCalendarDates() {
        let year = calendar.component(.year, from: currentDay)
        let month = calendar.component(.month, from: currentDay)
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = 1
        
        guard let startDate = calendar.date(from: dateComponents) else {
            fatalError("Failed to create start date.")
        }

        guard let endDate = calendar.date(byAdding: .month, value: 1, to: startDate) else {
            fatalError("Failed to create end date.")
        }

        var currentDateIterator = startDate
        while currentDateIterator < endDate {
            self.dates.append(currentDateIterator)
            currentDateIterator = calendar.date(byAdding: .day, value: 1, to: currentDateIterator)!
        }
    }
    
    //MARK: -Year

    
    //MARK: -Month
    private var currentSelectedMonth: Month = .jan
    
    func monthCellForRowAt(indexPath: IndexPath) -> (month: Month, isSelected: Bool) {
        let month = Month(rawValue: indexPath.row)!
        let isSelected = Month(rawValue: indexPath.row) == currentSelectedMonth
        return (month, isSelected)
    }
    
    func monthDidSelectedRowAt(indexPath: IndexPath) {
        Month(rawValue: indexPath.row)
    }

    //MARK: -Date
    
    func dateCellForRowAt(indexPath: IndexPath) -> (date: String, isToday: Bool) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let dateString = dateFormatter.string(from: dates[indexPath.row])
        let isToday = dates[indexPath.row] == currentDay
        return (dateString, isToday)
    }
    
    func dateDidSelectedRowAt(indexPath: IndexPath) {
        dates[indexPath.row]
        print("selectedDay:\(dates[indexPath.row])")
    }
    
}
