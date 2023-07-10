//
//  File.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/10.
//

import Foundation

class DateInterface {

    func generateYearStrings() -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        var yearStrings = [String]()
        
        // 設定起始年份為1900年
        var dateComponents = DateComponents()
        dateComponents.year = 1900
        dateComponents.month = 1
        dateComponents.day = 1
        guard let startDate = Calendar.current.date(from: dateComponents) else {
            return yearStrings
        }
        
        // 設定結束年份為2023年
        dateComponents.year = 2023
        dateComponents.month = 12
        dateComponents.day = 31
        guard let endDate = Calendar.current.date(from: dateComponents) else {
            return yearStrings
        }
        
        // 生成年份範圍內的年份字串
        var currentDate = startDate
        while currentDate <= endDate {
            let yearString = dateFormatter.string(from: currentDate)
            yearStrings.append(yearString)
            
            guard let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: currentDate) else {
                break
            }
            
            currentDate = nextYear
        }
        
        return yearStrings
    }

}
