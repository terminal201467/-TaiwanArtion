//
//  SearchViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import Foundation

enum FilterType: Int, CaseIterable {
    case city = 0, place, date, price
    var text: String {
        switch self {
        case .city: return "縣市"
        case .place: return "展覽館"
        case .date: return "日期"
        case .price: return "票價"
        }
    }
}

enum AlreadyFilter: Int, CaseIterable {
    case result = 0, news, nearest, filterIcon
    var text: String {
        switch self {
        case .result: return "搜尋結果"
        case .news: return "藝文新聞"
        case .nearest: return "距離最近"
        case .filterIcon: return "filter"
        }
    }
}


class SearchViewModel {
    
    //MARK: - data
    
    static let shared = SearchViewModel()
    
    private var store: [ExhibitionModel] = []
    
    private var filterStore: [ExhibitionModel] = []
    
    private var hotSearch: [ExhibitionModel] = []
    
    private var isSearchModeOn: Bool = false
    
    private var currentItem: Int?
    
    public func changedModeWith(isSearching: Bool) {
        isSearchModeOn = isSearching
    }
    
    public func getCurrentItem() -> Int? {
        return currentItem
    }
    
    //MARK: - CollectionView methods
    func collectionViewNumberOfRowInSection(section: Int) -> Int {
        return isSearchModeOn ? AlreadyFilter.allCases.count : FilterType.allCases.count
    }
    
    func collectionViewCellForRowAt(indexPath: IndexPath) -> (title: String, isSelected: Bool?) {
        if isSearchModeOn {
            if currentItem == nil {
                return (AlreadyFilter.allCases[indexPath.row].text, nil)
            } else {
                let isSelected = AlreadyFilter(rawValue: indexPath.row) == .init(rawValue: currentItem!)
                return (AlreadyFilter.allCases[indexPath.row].text, isSelected)
            }
        } else {
            if currentItem == nil {
                return (FilterType.allCases[indexPath.row].text, nil)
            } else {
                let isSelected = FilterType(rawValue: indexPath.row) == .init(rawValue: currentItem!)
                return (FilterType.allCases[indexPath.row].text, isSelected)
            }
        }
    }
    
    func collectionViewDidSelectedRowAt(indexPath: IndexPath) {
        isSearchModeOn ? AlreadyFilter.allCases[indexPath.row].text : FilterType.allCases[indexPath.row].text
    }
    
    //MARK: - TableView methods
    func tableViewNumberOfRowInSection(section: Int) -> Int {
        //未搜尋狀態
        if isSearchModeOn {
            switch AlreadyFilter(rawValue: section) {
            case .result: return 1
            case .news: return 1
            case .nearest: return 1
            case .filterIcon: return 1
            case .none: return 1
            }
        } else {
            switch FilterType(rawValue: section) {
            case .city: return Area.allCases.count //
            case .place: return 1 //展覽館
            case .date: return 2 //時間、日期
            case .price: return 1
            case .none: return 1
            }
        }
    }
    
    func tableViewCellForRowAt(indexPath: IndexPath) -> [Any] {
        if isSearchModeOn {
            currentItem = 0
            switch AlreadyFilter(rawValue: currentItem!) {
            case .result: return filterStore
            case .news: return filterStore
            case .nearest: return filterStore
            case .filterIcon: return filterStore
            case .none: return filterStore
            }
        } else {
            if let item = currentItem {
                switch FilterType(rawValue: currentItem!) {
                case .city:
                    switch Area(rawValue: indexPath.section) {
                    case .north: NorthernCity.allCases.map{$0.text}
                    case .middle: CentralCity.allCases.map{$0.text}
                    case .south: SouthernCity.allCases.map{$0.text}
                    case .east: EasternCity.allCases.map{$0.text}
                    case .island: OutlyingIslandCity.allCases.map{$0.text}
                    case .none: print("none")
                    }
                case .place: return Place.allCases.map{$0.title}
                case .date: return Date.allCases.map{$0.text}
                case .price: return Price.allCases.map{$0.text}
                case .none: return hotSearch.map { $0.title }
                }
            } else {
                return hotSearch.map { $0.title }
            }
            
        }
    }
    
    func tableViewDidSelectedRowAt(indexPath: IndexPath) {
        
    }
    
    
}
