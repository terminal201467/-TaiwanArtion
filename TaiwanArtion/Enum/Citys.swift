//
//  CityEnum.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import Foundation

enum NorthernCity: Int, CaseIterable {
    case taipei = 1
    case newTaipei = 2
    case keelung = 3
    case yilan = 4

    var text: String {
        switch self {
        case .taipei: return "台北市"
        case .newTaipei: return "新北市"
        case .keelung: return "基隆市"
        case .yilan: return "宜蘭縣"
        }
    }
}

enum CentralCity: Int, CaseIterable {
    case taoyuan = 1
    case hsinchu = 2
    case hsinchuCounty = 3
    case miaoli = 4
    case taichung = 5
    
    var text: String {
        switch self {
        case .taoyuan: return "桃園市"
        case .hsinchu: return "新竹市"
        case .hsinchuCounty: return "新竹縣"
        case .miaoli: return "苗栗縣"
        case .taichung: return "台中市"
        }
    }
}

enum SouthernCity: Int, CaseIterable {
    case changhua = 1
    case nantou = 2
    case chiayi = 3
    case chiayiCounty = 4
    case tainan = 5
    
    var text: String {
        switch self {
        case .changhua: return "彰化縣"
        case .nantou: return "南投縣"
        case .chiayi: return "嘉義市"
        case .chiayiCounty: return "嘉義縣"
        case .tainan: return "台南市"
        }
    }
}

enum EasternCity: Int, CaseIterable {
    case hualien = 1
    case taitung = 2
    
    var text: String {
        switch self {
        case .hualien: return "花蓮縣"
        case .taitung: return "台東縣"
        }
    }
}

enum OutlyingIslandCity: Int, CaseIterable {
    case penghu = 1
    case kinmen = 2
    case matsu = 3
    
    var text: String {
        switch self {
        case .penghu: return "澎湖縣"
        case .kinmen: return "金門縣"
        case .matsu: return "馬祖縣"
        }
    }
}

