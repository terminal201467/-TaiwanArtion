//
//  Area.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import Foundation

enum Area: Int, CaseIterable {
    case north = 0, middle, south, east, island, correct
    var text: String {
        switch self {
        case .north: return "北部"
        case .middle: return "中部"
        case .south: return "南部"
        case .east: return "東部"
        case .island: return "離島"
        case .correct: return ""
        }
    }
}
