//
//  CollectViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/7/27.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

protocol CollectInput {
    
    //傳入現在正在的頁籤事件：收藏展覽、收藏展覽館、收藏新聞
//    var currentCollectMenu: BehaviorRelay<Int> { get }
    
    //傳入現在正在的menu事件：全部展覽、今天開始、明天開始、本週開始
//    var currentContentMenu: BehaviorSubject<Int> { get }
    
    //進入搜尋狀態與否
    var isSearchMode: BehaviorRelay<Bool> { get }
    
    //輸入清除所有搜尋紀錄
    var removeAllSearchHistory: PublishRelay<Void> { get }
    
    //清除個別搜尋紀錄
    var removeSpecificSearchHistory: PublishRelay<Int> { get }
    
}

protocol CollectOutput {
    
//    var currentSelectedIndex: BehaviorRelay<Int> { get }
    
    //輸出所有收藏展覽的內容
    var currentExhibitionContent: BehaviorRelay<[ExhibitionInfo]> { get }
    
    //輸出曾經的搜尋紀錄
    var searchExhibitionContentHistory: BehaviorRelay<[String]> { get }
    
    //輸出收藏的展覽館
    var collectExhibitionHall: BehaviorRelay<[String]> { get }
    
    //輸出收藏的新聞
    var collectNews: BehaviorRelay<[NewsModel]> { get }
    
    //輸出新聞搜尋紀錄
    var collectNewsSearchHistory: BehaviorRelay<[String]> { get }
    
}

protocol CollectInputOutputType {
    
    var input: CollectInput { get }
    var output: CollectOutput { get }
    
}

class CollectViewModel: CollectInputOutputType, CollectInput, CollectOutput {
    
    private let disposeBag = DisposeBag()

    //MARK: - input
//    var currentCollectMenu: RxRelay.BehaviorRelay<Int> = BehaviorRelay(value: 0)
//
//    var currentContentMenu: BehaviorSubject<Int> = BehaviorSubject(value: 0)
    
    var isSearchMode: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var removeAllSearchHistory: RxRelay.PublishRelay<Void> = PublishRelay()
    
    var removeSpecificSearchHistory: RxRelay.PublishRelay<Int> = PublishRelay()
    
    //MARK: - output
//    var currentSelectedIndex: RxRelay.BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    var currentExhibitionContent: RxRelay.BehaviorRelay<[ExhibitionInfo]> = BehaviorRelay(value: [])
    
    var searchExhibitionContentHistory: RxRelay.BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    var collectExhibitionHall: RxRelay.BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    var collectNews: RxRelay.BehaviorRelay<[NewsModel]> = BehaviorRelay(value: [])
    
    var collectNewsSearchHistory: RxRelay.BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    //MARK: - Store
    
    var currentContentMenu: Int = 0
    
    private var exhibitions: [ExhibitionInfo] = []
    
    private var exhibitionHall: [String] = []
    
    private var news: [NewsModel] = []
    
    private var searchHistory: [String] = []
    
    private var exhibitionsObservable: Observable<[ExhibitionInfo]> {
        return Observable.just(exhibitions)
    }
    
    private var exhibitionHallObservable: Observable<[String]> {
        return Observable.just(exhibitionHall)
    }
    
    private var newsObservable: Observable<[NewsModel]> {
        return Observable.just(news)
    }
    
    //MARK: -Firebase
    
    private let firebase = FirebaseDatabase(collectionName: "exhibitions")
    
    //MARK: -input、output
    var input: CollectInput { self }
    var output: CollectOutput { self }
    
    //MARK: -Initialization
    init() {
//        currentCollectMenu.subscribe(onNext: { currentMenuPage in
//            self.currentSelectedIndex.accept(currentMenuPage)
//        })
//        .disposed(by: disposeBag)

//        currentContentMenu.subscribe(onNext: { contentSelectedMenu in
//            //fetchData
//            self.fetchFirebaseCollectData(by: 10) { info in
//                //output.accept
//                self.currentExhibitionContent.accept(info)
//            }
//        })
//        .disposed(by: disposeBag)
        
        //搜尋模式開始與否
        isSearchMode.subscribe(onNext: { isSearching in
            if isSearching {
                self.searchExhibitionContentHistory.accept(self.searchHistory)
            } else {
                self.searchHistory.removeAll()
                self.searchExhibitionContentHistory.accept(self.searchHistory)
            }
        })
        .disposed(by: disposeBag)
        
        removeAllSearchHistory.subscribe(onNext: {
            self.searchHistory.removeAll()
            self.searchExhibitionContentHistory.accept(self.searchHistory)
        })
        .disposed(by: disposeBag)
        
        removeSpecificSearchHistory.subscribe(onNext: { specificRow in
            self.searchHistory.remove(at: specificRow)
            self.searchExhibitionContentHistory.accept(self.searchHistory)
        })
        .disposed(by: disposeBag)
        
    }
    
    //向firebase拿資料，藉由全部展覽、今天開始、明天開始、本週開始等四個頁籤去filter要拿取的資料
    private func fetchFirebaseCollectData(by count: Int, completion: @escaping (([ExhibitionInfo]) -> Void)) {
        firebase.getHotDocument(count: count) { data, error in
            if let error = error {
                print("error:\(error)")
            } else if let data = data {
                var info: [ExhibitionInfo] = []
                data.map { detailData in
                    guard let title = detailData["title"] as? String,
                          let image = detailData["imageUrl"] as? String,
                          let dateString = detailData["startDate"] as? String,
                          let agency = detailData["subUnit"] as? [String],
                          let official = detailData["showUnit"] as? String,
                          let showInfo = detailData["showInfo"] as? [[String: Any]],
                          let price = showInfo.first?["price"] as? String,
                          let time = showInfo.first?["time"] as? String,
                          let latitude = showInfo.first?["latitude"] as? String,
                          let longitude = showInfo.first?["longitude"] as? String,
                          let location = showInfo.first?["locationName"] as? String,
                          let address = showInfo.first?["location"] as? String else { return }
                    let exhibition = ExhibitionInfo(title: title, image: image == "" ? "defaultExhibition" : image , tag: "一般", dateString: dateString, time: time, agency: agency.map{$0}.joined(), official: official, telephone: "", advanceTicketPrice: price, unanimousVotePrice: price, studentPrice: price, groupPrice: price, lovePrice: price, free: "", earlyBirdPrice: "", city: String(location.prefix(3)), location: location, address: address, latitude: latitude, longtitude: longitude)
                    info.append(exhibition)
                }
                completion(info)
            }
        }
    }
    
    //向firebase fetch最近的搜尋紀錄，CRUD?
    private func fetchFirebaseCollectSearchingData(by: Int, completion: @escaping (() -> Void)) {
        
    }
    
    private func fetchFirebaseNewsData(by userID: String, completion: @escaping (([NewsModel]) -> Void)) {
        
    }
    
    private func fetchStore(currentMenuPage: Int) {
        
        
    }
    
}
