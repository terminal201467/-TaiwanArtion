//
//  HomeViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/18.
//

import Foundation

enum Month: Int, CaseIterable {
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

class HomeViewModel {
    
    static let shared = HomeViewModel()
    
    var hotExhibition: [ExhibitionModel] = [
        ExhibitionModel(title: "未來身體-超自然雕塑", location: "台南市", date: "2023.05.18 - 05.20", image: "futureBody"),
        ExhibitionModel(title: "熊洞 bear hole", location: "台南市", date: "2023.03.21 - 4.20", image: "bearHole"),
        ExhibitionModel(title: "亻─ 生而為人", location: "台南市", date: "2023.03.21 - 4.20", image: "bornAsHuman"),
        ExhibitionModel(title: "植物觀－2023朱銘美術館年度特展", location: "台南市", date: "2023.03.21 - 4.20", image: "jumain"),
        ExhibitionModel(title: "糖衣的風景」江⼝綾⾳個展", location: "台南市", date: "2023.03.21 - 4.20", image: "oilPaintin")
    ]
    
    var mainPhoto: [ExhibitionModel] = [
        ExhibitionModel(title: "奇美博物館驚魂夜", location: "台南市", date: "2023.03.21 - 4.20", image: "noIdea"),
        ExhibitionModel(title: "奇美博物館驚魂夜", location: "台南市", date: "2023.03.21 - 4.20", image: "noIdea"),
        ExhibitionModel(title: "奇美博物館驚魂夜", location: "台南市", date: "2023.03.21 - 4.20", image: "noIdea")
    ]
    
    private var selectedMonth: Month = .jan
    
    private var selectedHabby: HabbyItem? = nil
    
    //MARK: - MonthCollectionView
    func didMonthSelectItemAt(indexPath: IndexPath) {
        selectedMonth = Month(rawValue: indexPath.row)!
        //打API要該月份的資料
    }
    
    func monthCellForRowAt(indexPath: IndexPath) -> (selectedMonth: Month, isSelected: Bool) {
        let month = Month.allCases[indexPath.row]
        let isSelected = Month(rawValue: indexPath.row) == selectedMonth
        return (month, isSelected)
    }
    
    //MARK: - HabbyCollectionView
    func didSelectHabbyItemAt(indexPath: IndexPath) {
        selectedHabby = HabbyItem(rawValue: indexPath.row)
        //打API要Habby的資料
        print("selectedHabby:\(HabbyItem(rawValue: indexPath.row)?.titleText)")
    }
    
    func habbyCellForRowAt(indexPath: IndexPath) -> (selectedHabby :HabbyItem, isSelected: Bool) {
        let habby = HabbyItem.allCases[indexPath.row]
        let isSelected = HabbyItem(rawValue: indexPath.row) == selectedHabby
        return (habby, isSelected)
    }
}
