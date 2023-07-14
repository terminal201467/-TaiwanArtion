//
//  CustomCalendarViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/13.
//

import RxSwift
import RxCocoa
import RxRelay

protocol CalendarOutput{
    //所有當月日期
    var isAllowToTap: BehaviorRelay<Bool> { get }
    var outputMonth: BehaviorRelay<String> { get }
    var sendOutSelecteMonthAndDate: BehaviorRelay<(String, String)> { get }
}

protocol CalendarInput {
    //輸入年、月
    var inputYear: BehaviorRelay<String> { get }
    var inputMonth: BehaviorRelay<String> { get }
    var inputDate: BehaviorRelay<String> { get }
    var correctTime: PublishRelay<Void> { get }
    var storeTime: BehaviorRelay<String> { get }
    var currentMonthDate: BehaviorRelay<String> { get }
    var nextMonth: BehaviorRelay<Void> { get }
    var preMonth: BehaviorRelay<Void> { get }
}

protocol CalendarViewModelType {
    var input: CalendarInput { get }
    var output: CalendarOutput { get }
}

class CustomCalendarViewModel: CalendarViewModelType, CalendarInput, CalendarOutput {

    private let disposeBag = DisposeBag()
    
    //MARK: -Input
    var inputYear: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    var inputMonth: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    var inputDate: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    var correctTime: RxRelay.PublishRelay<Void> = PublishRelay()
    var storeTime: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    var nextMonth: RxRelay.BehaviorRelay<Void> = BehaviorRelay(value: ())
    var preMonth: RxRelay.BehaviorRelay<Void> = BehaviorRelay(value: ())
    
    //MARK: -Output
    var currentMonthDate: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    var isAllowToTap: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var outputMonth: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    var sendOutSelecteMonthAndDate: RxRelay.BehaviorRelay<(String, String)> = BehaviorRelay(value: ("",""))
    
    //MARK: - input/output
    var input: CalendarInput { self }
    
    var output: CalendarOutput { self }
    
    //MARK: - CalendarLogic
    
    private var selectedYear: String = ""
    
    private var selectedMonth: String = ""
    
    private var selectedDate: String = ""
    
    //MARK: - CurrentTimeProperties
    
    private let calendar = Calendar.current
    
    private let currentDay = Date()
    
    private lazy var currentMonth = calendar.component(.month, from: currentDay)
    
    private lazy var currentYear = calendar.component(.year, from: currentDay)
    
    private lazy var firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDay))!
    
    private lazy var weekdayOffset = (calendar.component(.weekday, from: firstDayOfMonth) + 5) % 7 // 計算偏移量
    
    init() {
        inputYear.subscribe(onNext: { year in
            self.selectedYear = year
        }).disposed(by: disposeBag)
        
        inputMonth.subscribe(onNext: { month in
            self.selectedMonth = month
            self.outputMonth.accept(month)
        }).disposed(by: disposeBag)
        
        inputDate.subscribe(onNext: { date in
            self.selectedDate = date
        }).disposed(by: disposeBag)
        
        correctTime.subscribe(onNext: {
            self.sendOutSelecteMonthAndDate.accept((self.selectedMonth, self.selectedDate))
        }).disposed(by: disposeBag)
        
        checkTime()
    }
    
    private func checkTime() {
        if selectedYear != "" && selectedMonth != "" && selectedDate != "" {
            isAllowToTap.accept(true)
        } else {
            isAllowToTap.accept(false)
        }
    }
    
    func dateCellForRowAt(indexPath: IndexPath) -> (dateString: String, date: Date, isToday: Bool, isCurrentMonth: Bool) {
        let date = calendar.date(byAdding: .day, value: indexPath.item - weekdayOffset, to: firstDayOfMonth)!
        let isCurrentMonth = calendar.isDate(date, equalTo: currentDay, toGranularity: .month)
        let isToday = calendar.isDateInToday(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let dateString = dateFormatter.string(from: date)
        return (dateString, date, isToday, isCurrentMonth)
    }
    
    func didSelectedRowAt(indexPath: IndexPath) -> Date {
        let date = calendar.date(byAdding: .day, value: indexPath.item - weekdayOffset, to: firstDayOfMonth)!
        return date
    }
}
