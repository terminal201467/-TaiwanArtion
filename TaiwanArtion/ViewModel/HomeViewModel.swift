//
//  HomeViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/18.
//

import Foundation
import FirebaseFirestore
import RxSwift
import RxCocoa
import RxRelay

enum HomeSections: Int, CaseIterable {
    case year = 0, hot, news, all
    var title: String {
        switch self {
        case .year: return ""
        case .hot: return "熱門展覽"
        case .news: return "藝文新聞"
        case .all: return "所有展覽"
        }
    }
}

public protocol HomeViewModelInput: AnyObject {
    var monthSelected: PublishSubject<IndexPath> { get }
    var habbySelected: PublishSubject<IndexPath> { get }
    var mainPhotoSelected: PublishSubject<IndexPath> { get }
    var hotExhibitionSelected: PublishSubject<IndexPath> { get }
    var newsExhibitionSelected: PublishSubject<IndexPath> { get }
    var allExhibitionSelected: PublishSubject<IndexPath> { get }
    var itemSelected: PublishSubject<IndexPath> { get }
}

public protocol HomeViewModelOutput: AnyObject {
    var months: Observable<Month> { get }
    var habbys: Observable<HabbyItem?> { get }
    var items: Observable<Items> { get }
    var hotExhibitionRelay: BehaviorRelay<[ExhibitionInfo]> { get }
    var mainPhotoRelay: BehaviorRelay<[ExhibitionInfo]> { get }
    var newsRelay: BehaviorRelay<[NewsModel]> { get }
    var allExhibitionRelay: BehaviorRelay<[ExhibitionInfo]> { get }
}

public protocol HomeViewModelType: AnyObject {
    var inputs: HomeViewModelInput { get }
    var outputs: HomeViewModelOutput { get }
}

class HomeViewModel: HomeViewModelType, HomeViewModelInput, HomeViewModelOutput {
    
    //Input
    var monthSelected: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    var habbySelected: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    var mainPhotoSelected: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    var hotExhibitionSelected: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    var newsExhibitionSelected: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    var allExhibitionSelected: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    var itemSelected: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    
    //Singleton
    static let shared = HomeViewModel()
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Input、Output
    var inputs: HomeViewModelInput { self }
    
    var outputs: HomeViewModelOutput { self }
    
    //MARK: - Store
    
    let hotExhibitionRelay = BehaviorRelay<[ExhibitionInfo]>(value: [])
    
    let mainPhotoRelay = BehaviorRelay<[ExhibitionInfo]>(value: [])
    
    let newsRelay = BehaviorRelay<[NewsModel]>(value: [])
    
    let allExhibitionRelay = BehaviorRelay<[ExhibitionInfo]>(value: [])
    
    //MARK: - CollectionViewSelectedRelay
    
    private let currentMonthsSubject = BehaviorSubject<Month>(value: .jan)
    
    private let currentHabbySubject = BehaviorSubject<HabbyItem?>(value: nil)
    
    private let currenItemSubject = BehaviorSubject<Items>(value: .highRank)
    
    var months: Observable<Month> { currentMonthsSubject.asObservable() }
    
    var habbys: Observable<HabbyItem?> { currentHabbySubject.asObservable() }
    
    var items: Observable<Items> { currenItemSubject.asObservable() }
    
    //MARK: - Intialization
    public init() {
        //input
        monthSelected
            .subscribe(onNext: { indexPath in
                self.currentMonthsSubject.onNext(Month(rawValue: indexPath.row)!)
                self.fetchDateKind(by: Month(rawValue: indexPath.row)!)
            })
            .disposed(by: disposeBag)
        
        habbySelected
            .subscribe(onNext: { indexPath in
                self.currentHabbySubject.onNext(HabbyItem(rawValue: indexPath.row))
                self.fetchDataKind(by: HabbyItem(rawValue: indexPath.row)!)
            })
            .disposed(by: disposeBag)
        
        itemSelected
            .subscribe(onNext: { indexPath in
                self.currenItemSubject.onNext(Items(rawValue: indexPath.row)!)
                self.fetchDataKind(by: Items(rawValue: indexPath.row)!)
            })
            .disposed(by: disposeBag)
        
        fetchDataRecentExhibition(by: 5)
        fetchDataHotExhibition(by: 5)
    }
    
    //MARK: - Firebase
    
    private let firebase = FirebaseDatabase(collectionName: "exhibitions")

    func fetchDateKind(by month: Month) {
        firebase.readDocument(month: month.numberText) { data, error in
            if let error = error {
                print("error: \(error)")
            } else if data != nil{
                print("data:\(data)")
            }
        }
    }
    
    func fetchDataKind(by item: Items) {
        firebase.readDocument(item: item.text) { data, error in
            if let error = error {
                print("error:\(error)")
            } else if data != nil {
                print("data:\(data)")
            }
        }
    }
    
    //目前這個function應該是沒有什麼用
    func fetchDataKind(by habby: HabbyItem) {
        firebase.readDocument(habby: habby.titleText) { data, error in
            if let error = error {
                print("error:\(error)")
            } else if data != nil {
                print("data:\(data)")
//                self.allExhibitionRelay.accept(   －)
            }
        }
    }
    
    //MARK: - Firebase fetch Method
    
    func fetchDataRecentExhibition(by count: Int) {
        firebase.getRandomDocuments(count: count) { data, error in
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
                    //這邊的image需要設計沒有相關圖片的圖
                    //分類的部分都會先給定一般
                    let exhibition = ExhibitionInfo(title: title, image: image == "" ? "noIdea" : "" , tag: "一般", dateString: dateString, time: time, agency: agency.map{$0}.joined(), official: official, telephone: "", advanceTicketPrice: price, unanimousVotePrice: price, studentPrice: price, groupPrice: price, lovePrice: price, free: "", earlyBirdPrice: "", city: String(location.prefix(3)), location: location, address: address, latitude: latitude, longtitude: longitude)
                    info.append(exhibition)
                }
                self.mainPhotoRelay.accept(info)
            }
        }
    }
    
    func fetchDataHotExhibition(by count: Int) {
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
                    let exhibition = ExhibitionInfo(title: title, image: image == "" ? "noIdea" : "" , tag: "一般", dateString: dateString, time: time, agency: agency.map{$0}.joined(), official: official, telephone: "", advanceTicketPrice: price, unanimousVotePrice: price, studentPrice: price, groupPrice: price, lovePrice: price, free: "", earlyBirdPrice: "", city: String(location.prefix(3)), location: location, address: address, latitude: latitude, longtitude: longitude)
                    info.append(exhibition)
                }
                self.hotExhibitionRelay.accept(info)
            }
        }
    }
    
    //新聞系統還沒建置好
    func fetchDataNewsExhibition() {
        
    }
    
    //
    func fetchRecentExhibition(count: Int) {
        firebase.getRecentDocuments(count: count) { data, error in
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
                    //這邊的image需要設計沒有相關圖片的圖
                    //分類的部分都會先給定一般
                    let exhibition = ExhibitionInfo(title: title, image: image == "" ? "noIdea" : "" , tag: "一般", dateString: dateString, time: time, agency: agency.map{$0}.joined(), official: official, telephone: "", advanceTicketPrice: price, unanimousVotePrice: price, studentPrice: price, groupPrice: price, lovePrice: price, free: "", earlyBirdPrice: "", city: String(location.prefix(3)), location: location, address: address, latitude: latitude, longtitude: longitude)
                    info.append(exhibition)
                }
                self.allExhibitionRelay.accept(info)
            }
        }
    }
    
    
//    func fetchAllExhibition(by item: Items) {
//        switch item {
//        case .newest:
//            <#code#>
//        case .popular:
//            //未有評價系統
//            firebase.getHotDocument(count: 10) { data, error in
//                <#code#>
//            }
//        case .highRank:
//
//        case .recent:
//            firebase.getRecentDocuments(count: 10) { data, error in
//                <#code#>
//            }
//        }
//    }
}
