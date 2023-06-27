//
//  HomeViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/18.
//

import Foundation
import RxSwift
import RxCocoa

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
    var selectedMonth: PublishSubject<Month> { get }
    var selectedHabby: PublishSubject<HabbyItem> { get }
    var selectedMainPhoto: PublishSubject<ExhibitionInfo> { get }
    var selectedHotExhibition: PublishSubject<ExhibitionInfo> { get }
    var selectedNewsExhibition: PublishSubject<NewsModel> { get }
    var selectedAllExhibition: PublishSubject<ExhibitionInfo> { get }
    var selectedItem: PublishSubject<Items> { get }
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
    var selectedMonth: PublishSubject<Month> = PublishSubject<Month>()
    var selectedHabby: PublishSubject<HabbyItem> = PublishSubject<HabbyItem>()
    var selectedMainPhoto: PublishSubject<ExhibitionInfo> = PublishSubject<ExhibitionInfo>()
    var selectedHotExhibition: PublishSubject<ExhibitionInfo> = PublishSubject<ExhibitionInfo>()
    var selectedNewsExhibition: PublishSubject<NewsModel> = PublishSubject<NewsModel>()
    var selectedAllExhibition: PublishSubject<ExhibitionInfo> = PublishSubject<ExhibitionInfo>()
    var selectedItem: PublishSubject<Items> = PublishSubject<Items>()
    
    //Singleton
    static let shared = HomeViewModel()
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Input、Output
    var inputs: HomeViewModelInput { self }
    
    var outputs: HomeViewModelOutput { self }
    
    //MARK: -
    
    var hotExhibition: [ExhibitionInfo] = []
    
    var mainPhoto: [ExhibitionInfo] = []
    
    var news: [NewsModel] = []
    
    var allExhibition: [ExhibitionInfo] = []
    
    //MARK: - Firebase
    
    private let firebase = FirebaseDatabase(collectionName: "exhibitions")
    
    //MARK: - Intialization
    public init() {
        //input
        monthSelected
            .subscribe(onNext: { indexPath in
                self.currentMonth = Month(rawValue: indexPath.row)!
            })
            .disposed(by: disposeBag)
        
        habbySelected
            .subscribe(onNext: { indexPath in
                self.currentHabby = HabbyItem(rawValue: indexPath.row)!
            })
            .disposed(by: disposeBag)
        
        mainPhotoSelected
            .subscribe(onNext: { indexPath in
                
            })
            .disposed(by: disposeBag)
        
        hotExhibitionSelected
            .subscribe(onNext: { indexPath in
                
            })
            .disposed(by: disposeBag)
        
        newsExhibitionSelected
            .subscribe(onNext: { indexPath in
                
            })
            .disposed(by: disposeBag)
        
        allExhibitionSelected
            .subscribe(onNext: { indexPath in
                 
            })
            .disposed(by: disposeBag)
        
        itemSelected
            .subscribe(onNext: { indexPath in
                self.currentItem = Items(rawValue: indexPath.row)!
            })
            .disposed(by: disposeBag)
        
        //output
        selectedMonth
            .subscribe(onNext: { indexPath in
                
            })
            .disposed(by: disposeBag)
        
        selectedItem
            .subscribe(onNext: { indexPath in
                
            })
            .disposed(by: disposeBag)
            
        selectedHabby
            .subscribe(onNext: { indexPath in
                
            })
            .disposed(by: disposeBag)
        
        selectedMainPhoto
            .subscribe(onNext: { indexPath in
                
            })
            .disposed(by: disposeBag)
        
        selectedHotExhibition
            .subscribe(onNext: { indexPath in
                
            })
            .disposed(by: disposeBag)
        
        selectedAllExhibition
            .subscribe(onNext: { indexPath in
                
            })
            .disposed(by: disposeBag)
        
        selectedNewsExhibition
            .subscribe(onNext: { indexPath in
                
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: - MonthCollectionView
    private var currentMonth: Month = .jan
//
//    func didMonthSelectItemAt(indexPath: IndexPath) {
//        selectedMonth = Month(rawValue: indexPath.row)!
//        //打API要該月份的資料
//    }
//
//    func monthCellForRowAt(indexPath: IndexPath) -> (selectedMonth: Month, isSelected: Bool) {
//        let month = Month.allCases[indexPath.row]
//        let isSelected = Month(rawValue: indexPath.row) == selectedMonth
//        return (month, isSelected)
//    }
    
    //MARK: - HabbyCollectionView
    
    private var currentHabby: HabbyItem? = nil
//
//    func didSelectHabbyItemAt(indexPath: IndexPath) {
//        selectedHabby = HabbyItem(rawValue: indexPath.row)
//        //打API要Habby的資料
//        print("selectedHabby:\(HabbyItem(rawValue: indexPath.row)?.titleText)")
//    }
//
//    func habbyCellForRowAt(indexPath: IndexPath) -> (selectedHabby :HabbyItem, isSelected: Bool) {
//        let habby = HabbyItem.allCases[indexPath.row]
//        let isSelected = HabbyItem(rawValue: indexPath.row) == selectedHabby
//        return (habby, isSelected)
//    }
    
    //MARK: - MainPhoto
    
//    func mainPhotoDidSelectItemAt(indexPath: IndexPath, completion: @escaping ((ExhibitionInfo) ->Void)) {
//        completion(mainPhoto[indexPath.row])
//    }
//
//    //MARK: - HotTableView
//    func hotExhibitionNumberOfRowInSection(section: Int) -> Int {
//        return hotExhibition.count
//    }
//
//    func hotExhibitionCellForRowAt(indexPath: IndexPath) -> ExhibitionInfo {
//        return hotExhibition[indexPath.row]
//    }
//
//    func hotExhibitionDidSelectedRowAt(indexPath: IndexPath , completion: @escaping ((ExhibitionInfo) -> Void)) {
//        completion(hotExhibition[indexPath.row])
//    }
    
    //MARK: - NewsTableView
//    func newsExhibitionNumerOfRowInSection(section: Int) -> Int {
//        return news.count
//    }
//
//    func newsExhibitionCellForRowAt(indexPath: IndexPath) -> NewsModel {
//        return news[indexPath.row]
//    }
//
//    func newsExhibitionDidSelectedRowAt(indexPath: IndexPath, completion: @escaping((NewsModel) -> Void)) {
//        completion(news[indexPath.row])
//    }
//
//    //MARK: - AllExhibitionTableView
//    func allExhibitionNumerOfRowInSection(section: Int) -> Int {
//        return allExhibition.count
//    }
//
//    func allExhibitionCellForRowAt(indexPath: IndexPath) -> ExhibitionInfo {
//        return allExhibition[indexPath.row]
//    }
//
//    func allExhibitionDidSelectedRowAt(indexPath: IndexPath, completion: @escaping ((ExhibitionInfo) -> Void)) {
//        completion(allExhibition[indexPath.row])
//    }
    
    //MARK: -ItemsSelected
    
    var currentItem: Items = .newest
//
//    func itemCellForRowAt(indexPath: IndexPath) -> (item: Items, isSelected: Bool) {
//        let item = Items.allCases[indexPath.row]
//        let isSelected = Items(rawValue: indexPath.row) == selectItem
//        return (item, isSelected)
//    }
//
//    func itemDidSelectedRowAt(indexPath: IndexPath) {
//        selectItem = Items(rawValue: indexPath.row)!
//    }
    
}
