//
//  ResultViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/31.
//

import Foundation
import RxRelay
import RxSwift

protocol ResultInput {
    //輸入現在搜尋框的內容
    var textEditingRelay: BehaviorRelay<String> { get }
    
    //輸入現在的filterPage
    var currentMenuRelay: BehaviorRelay<CollectMenu> { get }
}

protocol ResultOutput {
    
    //menu觀察序列
    var currentExhibitionMenu: Observable<CollectMenu> { get }
    
    //歷史觀察序列
    var storeHistoryObservable: Observable<[ExhibitionInfo]> { get }
    
    //新聞觀察序列
    var storeNewsObservable: Observable<[NewsModel]> { get }
    
    //展覽館觀察序列
    var storeExhibitionHallObservable: Observable<[ExhibitionHallInfo]> { get }
    
}

protocol ResultInputOutputType {
    
    var input: ResultInput { get }
    var output: ResultOutput { get }
}

class ResultViewModel: ResultInputOutputType, ResultInput, ResultOutput {

    private let disposeBag = DisposeBag()
    
    //MARK: Stream
    var input: ResultInput { self }
    
    var output: ResultOutput { self }
    
    //MARK: -Input
    var textEditingRelay: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var currentMenuRelay: RxRelay.BehaviorRelay<CollectMenu> = BehaviorRelay(value: .collectExhibition)
    
    //MARK: -Output
    
    var currentExhibitionMenu: Observable<CollectMenu> {
        return Observable.just(currentMenu)
    }
    
    var storeHistoryObservable: Observable<[ExhibitionInfo]> {
        return Observable.just(storeSearchExhibitionHistorys)
    }
    
    var storeNewsObservable: Observable<[NewsModel]> {
        return Observable.just(storeSearchNews)
    }
    
    var storeExhibitionHallObservable: Observable<[ExhibitionHallInfo]> {
        return Observable.just(storeExhibitionHalls)
    }
    
    //MARK: -Firebase
    
    private let firebase = FirebaseDatabase(collectionName: "History")
    
    //MARK: -Store
    private var searchText: String = "" {
        didSet {
            self.setSearchFilterType(with: searchText)
        }
    }
    
    private var currentMenu: CollectMenu = .collectExhibition
    
    private var storeSearchExhibitionHistorys: [ExhibitionInfo] = []
    
    private var storeSearchNews: [NewsModel] = []
    
    private var storeExhibitionHalls: [ExhibitionHallInfo] = []
    
    init() {
        textEditingRelay.subscribe(onNext: { text in
            self.searchText = text
        })
        .disposed(by: disposeBag)
        
        currentMenuRelay.subscribe(onNext: { menu in
            self.currentMenu = menu
        })
        .disposed(by: disposeBag)
    }
    
    private func setSearchFilterType(with: String) {
        switch currentMenu {
        case .collectExhibition:
            let exhibitionInfo = filterSearchExhibitionHistory(searchText: searchText)
            storeSearchExhibitionHistorys = exhibitionInfo
        case .collectExhibitionHall:
            let hallInfo = filterSearchExhibitionHallHistory(searchText: searchText)
            storeExhibitionHalls = hallInfo
        case .collectNews:
            let newInfo = filterSearchNewsHistory(searchText: searchText)
            storeSearchNews = newInfo
        }
    }
    
    //MARK: - FilterMethod
    private func filterSearchExhibitionHistory(searchText: String) -> [ExhibitionInfo] {
        let searchResult = storeSearchExhibitionHistorys.filter { history in
            history.title.localizedStandardContains(searchText)
        }
        return searchResult
    }
    
    private func filterSearchExhibitionHallHistory(searchText: String) -> [ExhibitionHallInfo] {
        let searchResult = storeExhibitionHalls.filter { exhibitionHall in
            exhibitionHall.title.localizedStandardContains(searchText)
        }
        return searchResult
    }
    
    private func filterSearchNewsHistory(searchText: String) -> [NewsModel] {
        let searchResult = storeSearchNews.filter { news in
            news.title.localizedStandardContains(searchText)
        }
        return searchResult
    }
    
    //MARK: -Firebase歷史搜尋紀錄
    private func fetchExhibitionHistory() {
        
    }
    
    private func fetchExhibitionHall() {
        
    }
    
    private func fetchNewsHistory() {
        
        
    }
    
}
