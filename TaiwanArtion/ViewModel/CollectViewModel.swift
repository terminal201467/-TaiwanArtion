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
    var currentCollectMenu: BehaviorRelay<Int> { get }
    
    //傳入現在正在的menu事件：全部展覽、今天開始、明天開始、本週開始
    var currentTimeMenu: BehaviorRelay<Int> { get }
    
    //進入搜尋狀態與否
    var isSearchMode: BehaviorRelay<Bool> { get }
    
    //輸入清除所有搜尋紀錄
    var removeAllSearchHistory: PublishRelay<Void> { get }
    
    //清除個別搜尋紀錄
    var removeSpecificSearchHistory: PublishRelay<Int> { get }
    
}

protocol CollectOutput {
    
    var currentSelectedCollectMenuIndex: Observable<Int> { get }
    
    var currentSelectedTimeMenu: Observable<Int> { get }
    
    //輸出所有收藏展覽的內容
    var currentExhibitionContent: BehaviorRelay<[ExhibitionInfo]> { get }
    
    //輸出曾經的搜尋紀錄
    var searchExhibitionContentHistory: BehaviorRelay<[String]> { get }
    
    //輸出收藏的展覽館
    var collectExhibitionHall: BehaviorRelay<[String]> { get }
    
    //輸出收藏的新聞
    var collectNews: BehaviorRelay<[News]> { get }
    
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
    
    var currentCollectMenu: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    var currentTimeMenu: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    var isSearchMode: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var removeAllSearchHistory: RxRelay.PublishRelay<Void> = PublishRelay()
    
    var removeSpecificSearchHistory: RxRelay.PublishRelay<Int> = PublishRelay()
    
    //MARK: - output
    
    var currentSelectedCollectMenuIndex: RxSwift.Observable<Int> {
        return currentSelectedTimeMenu.asObservable()
    }
    
    var currentSelectedTimeMenu: RxSwift.Observable<Int> {
        return currentTimeMenu.asObservable()
    }
    
    var currentExhibitionContent: RxRelay.BehaviorRelay<[ExhibitionInfo]> = BehaviorRelay(value: [])
    
    var searchExhibitionContentHistory: RxRelay.BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    var collectExhibitionHall: RxRelay.BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    var collectNews: RxRelay.BehaviorRelay<[News]> = BehaviorRelay(value: [])
    
    var collectNewsSearchHistory: RxRelay.BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    
    //MARK: -Firebase
    
    private let firebase = FirebaseDatabase(collectionName: "exhibitions")
    
    //MARK: -input、output
    var input: CollectInput { self }
    var output: CollectOutput { self }
    
    //MARK: -Initialization
    init() {
        
        fetchFirebaseCollectData(by: 10) { infos in
            print("info:\(infos)")
            self.currentExhibitionContent.accept(infos)
        }
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
    
    private func fetchFirebaseNewsData(by userID: String, completion: @escaping (([News]) -> Void)) {
        
    }
    
    private func fetchStore(currentMenuPage: Int) {
        
        
    }
    
}
