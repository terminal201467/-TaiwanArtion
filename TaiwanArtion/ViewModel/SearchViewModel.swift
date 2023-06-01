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
    case result = 0, news, nearest
    var text: String {
        switch self {
        case .result: return "搜尋結果"
        case .news: return "藝文新聞"
        case .nearest: return "距離最近"
        }
    }
}


class SearchViewModel {
    
    //MARK: - data
    
    private var store: [ExhibitionModel] = []
    
    private var filterStore: [ExhibitionModel] = []
    
    private var hotSearch: [ExhibitionModel] = []
    
    var isInSearchMode: Bool = false
    
    //MARK: - CollectionView methods
//    func collectionViewNumberOfRowInSection(section: Int) -> Int{
//        
//    }
    
    func collectionViewCellForRowAt(indexPath: IndexPath) {
        
    }
    
    func collectionViewDidSelectedRowAt(indexPath: IndexPath) {
        
    }
    
    //MARK: - TableView methods
//    func tableViewNumberOfRowInSection(section: Int) -> Int{
//        
//    }
    
    func tableViewCellForRowAt(indexPath: IndexPath) {
        
    }
    
    func tableViewDidSelectedRowAt(indexPath: IndexPath) {
        
    }
    
    
}
