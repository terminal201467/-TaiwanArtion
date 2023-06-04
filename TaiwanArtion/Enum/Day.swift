//
//  Day.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/4.
//

import Foundation

enum Day: Int, CaseIterable {
    case today = 0, tomorrow, thisWeek, finished
    var text: String {
        switch self {
        case .today: return "今天"
        case .tomorrow: return "明天"
        case .thisWeek: return "本週"
        case .finished: return "已結束"
        }
    }
}
