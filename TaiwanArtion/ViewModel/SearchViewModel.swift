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
    
    private var store: [ExhibitionModel] = []
    
    private var filterStore: [ExhibitionModel] = []
    
    private var hotSearch: [ExhibitionModel] = []
    
    private var isSearchModeOn: Bool = false
    
    private var currentItem: Int = 0
    
    public func changedModeWith(isSearching: Bool) {
        isSearchModeOn = isSearching
    }
    
    //MARK: - CollectionView methods
    func collectionViewNumberOfRowInSection(section: Int) -> Int {
        return isSearchModeOn ? AlreadyFilter.allCases.count : FilterType.allCases.count
    }
    
    func collectionViewCellForRowAt(indexPath: IndexPath) -> (title: String, isSelected: Bool) {
        if isSearchModeOn {
            let isSelected = AlreadyFilter(rawValue: indexPath.row) == .init(rawValue: currentItem)
            return (AlreadyFilter.allCases[indexPath.row].text, isSelected)
        } else {
            let isSelected = FilterType(rawValue: indexPath.row) == .init(rawValue: currentItem)
            return (FilterType.allCases[indexPath.row].text, isSelected)
        }
    }
    
    func collectionViewDidSelectedRowAt(indexPath: IndexPath) {
        isSearchModeOn ? AlreadyFilter.allCases[indexPath.row].text : FilterType.allCases[indexPath.row].text
    }
    
    //MARK: - TableView methods
    func tableViewNumberOfRowInSection(isSearchModeOn: Bool ,section: Int) -> Int{
        
    }
    
    func tableViewCellForRowAt(isSearchModeOn: Bool ,indexPath: IndexPath) {
        
    }
    
    func tableViewDidSelectedRowAt(indexPath: IndexPath) {
        
    }
    
    
}
