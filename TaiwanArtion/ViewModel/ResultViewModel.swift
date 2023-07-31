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
    var currentPageRelay: BehaviorRelay<Int> { get }
}

protocol ResultOuput {
    
    //輸出現在的menu
    var outputCollectMenuRelay: BehaviorRelay<CollectMenu> { get }
    
    //輸出的收藏展覽紀錄
    var outputCollectExhibitionRecordsRelay: BehaviorRelay<String> { get }
    
    //輸出的收藏展覽館紀錄
    var outputCollectExhibitionHallRecordsRelay: BehaviorRelay<String> { get }
    
    //輸出收藏的新聞紀錄
    var outputCollectNesRecordsRelay: BehaviorRelay<String> { get }
    
    //輸出展覽資訊
    var outputExhibitionInfo: BehaviorRelay<ExhibitionInfo> { get }
    
    //輸出展覽館資訊
    var outExhibitionHall: BehaviorRelay<String> { get }
    
    //輸出新聞資訊
    var outputNewsInfo: BehaviorRelay<NewsModel> { get }
    
}

protocol ResultInputOutputType {
    
}

class ResultViewModel {
    
    private var currentMenu: CollectMenu = .collectExhibition
    
    var currentExhibitionPage: Observable<CollectMenu> {
        return Observable.just(currentMenu)
    }
    
    init() {
        
    }
    
    //Firebase歷史搜尋紀錄
    
    
    
    
    
}
