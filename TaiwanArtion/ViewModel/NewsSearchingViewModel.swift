//
//  NewsSearchingViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/28.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseFirestore

enum NewsFilterItem: Int, CaseIterable {
    case recentNews = 0, popularNews, recentDate
    var text: String {
        switch self {
        case .recentNews: return "最新新聞"
        case .popularNews: return "人氣新聞"
        case .recentDate: return "最近日期"
        }
    }
}

protocol NewsSearchingInput {
    
    //輸入月份
    var inputMonth: PublishRelay<Month> { get }
    
    //輸入選擇嗜好
    var inputSelectHabby: PublishRelay<HabbyItem> { get }
    
    //輸入藝文新聞欄位選擇篩選資料項目
    var inputNewsFilter: PublishRelay<NewsFilterItem> { get }
    
}

protocol NewsSearchingOutput {
    
    //輸出月份
    var outputMonth: BehaviorRelay<Month> { get }
    
    //輸出選擇嗜好
    var outputHabby: BehaviorRelay<HabbyItem> { get }
    
    //輸出選擇嗜好
    var outputNewsFilter: BehaviorRelay<NewsFilterItem> { get }
    
    //輸出藝文新聞篩選過的新聞
    var outputFilterNews: BehaviorRelay<[NewsModel]> { get }
    
    //輸出新聞搜尋紀錄
    var outputNewsSearchingHistory: BehaviorRelay<[String]> { get }
    
}

protocol NewsSearchingType {
    
    var input: NewsSearchingInput { get }
    
    var output: NewsSearchingOutput { get }
    
}

class NewsSearchingViewModel: NewsSearchingType, NewsSearchingInput, NewsSearchingOutput {
    
    private let disposeBag = DisposeBag()
    
    //MARK: -Input、Output
    var input: NewsSearchingInput { self }
    
    var output: NewsSearchingOutput { self }
    
    //MARK: -Input
    
    var inputMonth: PublishRelay<Month> = PublishRelay()
    
    var inputSelectHabby: PublishRelay<HabbyItem> = PublishRelay()
    
    var inputNewsFilter: PublishRelay<NewsFilterItem> = PublishRelay()
    
    //MARK: -Output
    
    var outputMonth: RxRelay.BehaviorRelay<Month> = BehaviorRelay(value: .jan)
    
    var outputHabby: RxRelay.BehaviorRelay<HabbyItem> = BehaviorRelay(value: .painting)
    
    var outputNewsFilter: RxRelay.BehaviorRelay<NewsFilterItem> = BehaviorRelay(value: .recentNews)
    
    var outputFilterNews: RxRelay.BehaviorRelay<[NewsModel]> = BehaviorRelay(value: [])
    
    var outputNewsSearchingHistory: RxRelay.BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    //MARK: -UserDefault
    
    private let userDefaultInterface = UserDefaultInterface.shared
    
    //MARK: -Firebase
    
    private let firebase = FirebaseDatabase(collectionName: "news")
    
    //MARK: - Initialization
    init() {
        //輸入月份
        inputMonth.asObservable()
            .bind(to: outputMonth)
            .disposed(by: disposeBag)
        
        //輸入嗜好
        inputSelectHabby.asObservable()
            .map({ habby in
                self.outputHabby.accept(habby)
                return self.getNewsByHabby(habby: habby)
            })
            .bind(to: outputFilterNews)
            .disposed(by: disposeBag)
        
        //輸入篩選條件
        inputNewsFilter.asObservable()
            .map({ filter in
                self.outputNewsFilter.accept(filter)
                return self.getNewsBySelected(selectedItem: filter)
            })
            .bind(to: outputFilterNews)
            .disposed(by: disposeBag)
        
        outputNewsSearchingHistory.accept(self.getSearchingHistoryFromUserDefault() ?? [])
        
    }
    
    private func getNewsByMonthFilter(month: Month) -> [NewsModel] {
        
        return []
    }
    
    private func getNewsByHabby(habby: HabbyItem) -> [NewsModel] {
        
        return []
    }
    
    private func getNewsBySelected(selectedItem: NewsFilterItem) -> [NewsModel]{
        
        return []
    }
    
    private func getSearchingHistoryFromUserDefault() -> [String]? {
        return userDefaultInterface.getStoreNewsSearchHistory()
    }
    
}
