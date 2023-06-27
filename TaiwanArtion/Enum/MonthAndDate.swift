//
//  MonthAndDate.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/6/27.
//

import Foundation

public enum Month: Int, CaseIterable {
    case jan = 0, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec
    var numberText: String {
        switch self {
        case .jan: return "1"
        case .feb: return "2"
        case .mar: return "3"
        case .apr: return "4"
        case .may: return "5"
        case .jun: return "6"
        case .jul: return "7"
        case .aug: return "8"
        case .sep: return "9"
        case .oct: return "10"
        case .nov: return "11"
        case .dec: return "12"
        }
    }
    var englishText: String {
        switch self {
        case .jan: return "Jan"
        case .feb: return "Feb"
        case .mar: return "Mar"
        case .apr: return "Apr"
        case .may: return "May"
        case .jun: return "Jun"
        case .jul: return "Jul"
        case .aug: return "Aug"
        case .sep: return "Sep"
        case .oct: return "Oct"
        case .nov: return "Nov"
        case .dec: return "Dec"
        }
    }
}
