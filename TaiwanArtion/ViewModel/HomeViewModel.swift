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
//    var didSelectedMonthRow: PublishSubject<(Month, Bool)> { get }
//    var didSelectedHabbyRow: PublishSubject<(HabbyItem, Bool)> { get }
//    var didSelectedMainPhotoRow: PublishSubject<ExhibitionInfo> { get }
//    var didSelectedHotExhibitionRow: PublishSubject<ExhibitionInfo> { get }
//    var didSelectedNewsExhibitionRow: PublishSubject<NewsModel> { get }
//    var didSelectedAllExhibitionRow: PublishSubject<ExhibitionInfo> { get }
//    var didSelectedItemRow: PublishSubject<(Items, Bool)> { get }
    var months: Observable<Month> { get }
    var habbys: Observable<HabbyItem?> { get }
    var items: Observable<Items> { get }
    
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
    
    //Output
//    var didSelectedMonthRow: PublishSubject<(Month, Bool)> = PublishSubject<(Month, Bool)>()
//    var didSelectedHabbyRow: PublishSubject<(HabbyItem, Bool)> = PublishSubject<(HabbyItem, Bool)>()
//    var didSelectedMainPhotoRow: PublishSubject<ExhibitionInfo> = PublishSubject<ExhibitionInfo>()
//    var didSelectedHotExhibitionRow: PublishSubject<ExhibitionInfo> = PublishSubject<ExhibitionInfo>()
//    var didSelectedNewsExhibitionRow: PublishSubject<NewsModel> = PublishSubject<NewsModel>()
//    var didSelectedAllExhibitionRow: PublishSubject<ExhibitionInfo> = PublishSubject<ExhibitionInfo>()
//    var didSelectedItemRow: PublishSubject<(Items, Bool)> = PublishSubject<(Items, Bool)>()
    
    //Singleton
    static let shared = HomeViewModel()
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Input、Output
    var inputs: HomeViewModelInput { self }
    
    var outputs: HomeViewModelOutput { self }
    
    //MARK: - Store
    
    private let hotExhibitionRelay = BehaviorRelay<[ExhibitionInfo]>(value: [])
    
    private let mainPhotoRelay = BehaviorRelay<[ExhibitionInfo]>(value: [])
    
    private let newsRelay = BehaviorRelay<[NewsModel]>(value: [])
    
    private let allExhibitionRelay = BehaviorRelay<[ExhibitionInfo]>(value: [])
    
    var hotExhibitionObservable: Observable<[ExhibitionInfo]> {
        return hotExhibitionRelay.asObservable()
    }
    
    var mainPhotoObservable: Observable<[ExhibitionInfo]> {
        return mainPhotoRelay.asObservable()
    }
    
    var newsObservable: Observable<[NewsModel]> {
        return newsRelay.asObservable()
    }
    
    var allExhibitionObservable: Observable<[ExhibitionInfo]> {
        return allExhibitionRelay.asObservable()
    }
    
    //MARK: - CollectionViewSelectedRelay
    
    private let itemRelay = BehaviorRelay<(item: Items, isSelected: Bool)?>(value: nil)
    
    private let monthRelay = BehaviorRelay<(selectedMonth: Month, isSelected: Bool)?>(value: nil)
    
    private let habbyRelay = BehaviorRelay<(habby: HabbyItem, isSelected: Bool)?>(value: nil)
    
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
            })
            .disposed(by: disposeBag)
        
        itemSelected
            .subscribe(onNext: { indexPath in
                self.currenItemSubject.onNext(Items(rawValue: indexPath.row)!)
                //fetchData
            })
            .disposed(by: disposeBag)
        
        //output

    }
    
    //MARK: - Firebase
    
    private let firebase = FirebaseDatabase(collectionName: "exhibitions")

    
    func fetchDateKind(by month: Month) {
        firebase.readDocument(month: month.numberText) { data, error in
            print("data: \(data)")
            if let error = error {
                print("error: \(error)")
                // 处理错误情况，如果适用
            } else if let fetchedData = data as? [ExhibitionInfo] {
//                self.hotExhibitionRelay.accept(fetchedData)
//                self.mainPhotoRelay.accept(fetchedData)
                // 执行其他需要的操作，或者通知其他部分数据已更新
            }
        }
    }
    
    func fetchDateKind(by item: Items) {
        firebase.readDocument(item: item.text) { data, error in
            
        }
    }
    
    func fetchDataKind(by habby: HabbyItem) {
        firebase.readDocument(habby: habby.titleText) { data, error in
            
        }
    }
    
}
