//
//  Place.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/4.
//

import Foundation

enum Place: Int, CaseIterable {
    case cultureArea = 0, artGallery, museums, exhibitionHall, artCenter
    var title: String {
        switch self {
        case .cultureArea: return "文創園區"
        case .artGallery: return "美術館"
        case .museums: return "博物館"
        case .exhibitionHall: return "展覽館"
        case .artCenter: return "藝文中心"
        }
    }
}

enum DateKind: Int, CaseIterable {
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

enum Price: Int, CaseIterable {
    case paid = 0, free
    var text: String {
        switch self {
        case .paid: return "付費展"
        case .free: return "免費展"
        }
    }
}

enum TimeSection: Int, CaseIterable {
    case dateKind = 0, calendar, correct
}
