//
//  ExhibitionCardViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/25.
//

import Foundation

enum CardInfoItem: Int, CaseIterable {
    case overview = 0, introduce, ticketPrice, location, evaluate
    var title: String {
        switch self {
        case .overview: return "總覽"
        case .introduce: return "簡介"
        case .ticketPrice: return "票價"
        case .location: return "地點"
        case .evaluate: return "評價"
        }
    }
}

class ExhibitionCardViewModel {
    
    //MARK: - Singleton
    
    static let shared = ExhibitionCardViewModel()
    
    //MARK: - Items
    var title: String = "未知的展覽"
    
    var exhibitionInfo: ExhibitionInfo = ExhibitionInfo(tag: "雕塑",
                                                        date: "2022.12.01(一）- 2022.12.01(一）",
                                                        time: "9:00a.m - 10:00p.m",
                                                        agency: "Queen女人迷俱樂部",
                                                        official: "Queen女人迷俱樂部",
                                                        telephone: "(02)-23530506",
                                                        advanceTicketPrice: "199",
                                                        unanimousVotePrice: "199",
                                                        studentPrice: "199",
                                                        groupPrice: "199",
                                                        lovePrice: "199",
                                                        free: "199",
                                                        earlyBirdPrice: "199",
                                                        location: "桃園市中壢區春德路101號",
                                                        address: "和逸飯店 桃園館",
                                                        equipments: ["停車場", "導覽機器", "導覽人員", "WIFI", "室內導覽", "AR/VR"],
                                                        latitude: "102022220",
                                                        longtitude: "393339393")
    //MARK: - ExhibitionCardItems
    var currentSelectedItem: CardInfoItem = .overview
    
    func numberOfRowInSection(section: Int) {
        
    }
    
    func cellForRowAt(indexPath: IndexPath) -> ExhibitionInfo {
        return exhibitionInfo
    }
    
    func didSelectedRowAt(indexPath: IndexPath) {
        
    }
    
    func numberOfSections(by chooseItem: CardInfoItem) -> Int {
        switch chooseItem {
        case .overview: return 1
        case .introduce: return 1
        case .ticketPrice: return 1
        case .location: return 2
        case .evaluate: return 1
        }
    }
    
    func numberOfRowInSection(chooseItem: CardInfoItem, section: Int) -> Int {
        switch chooseItem {
        case .overview:
            switch OverViewSection(rawValue: section) {
            case .overview: return OverViewContentCell.allCases.count
            case .none: return 1
            }
        case .introduce:
            switch IntroduceSection(rawValue: section) {
            case .intro: return IntroduceContentCell.allCases.count
            case .none: return 1
            }
        case .ticketPrice:
            switch TicketPriceSection(rawValue: section) {
            case .price: return TicketPriceContentCell.allCases.count
            case .none: return 1
            }
        case .location:
            switch LocationSection(rawValue: section) {
            case .location: return LocationContentCell.allCases.count
            case .equipment: return 1
            case .map: return 1
            case .route: return 1
            case .none: return 1
            }
        case .evaluate:
            switch EvaluationSection(rawValue: section) {
            case .allComment: return 1
            case .personComment: return evaluations[section].commentContents.count
            case .none: return 0
            }
        }
    }
    
    func heightForHeaderFooterInSection(chooseItem: CardInfoItem, section: Int) -> CGFloat? {
        switch chooseItem {
        case .overview: return OverViewSection(rawValue: section)!.height
        case .introduce: return IntroduceSection(rawValue: section)!.height
        case .ticketPrice: return TicketPriceSection(rawValue: section)!.height
        case .location: return LocationSection(rawValue: section)!.height
        case .evaluate: return EvaluationSection(rawValue: section)!.height
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        
    }
    
    //MARK: - Evaluation CollectionView
    var evaluationSelectedItem: EvaluationItems = .all
    
    func itemCollectionViewNumberOfRowInSection() -> Int {
        return EvaluationItems.allCases.count
    }
    
    func itemCollectionViewCellForRowAt(indexPath: IndexPath) -> (item: EvaluationItems, isSelected: Bool) {
        let item = EvaluationItems.allCases[indexPath.row]
        let isSelected = evaluationSelectedItem == item
        return (EvaluationItems.allCases[indexPath.row], isSelected)
    }
    
    func itemCollectionViewDidSelectedTRowAt(indexPath: IndexPath) {
        evaluationSelectedItem = EvaluationItems(rawValue: indexPath.row)!
    }
    
    //MARK: - EvaluationTableView
    var evaluations: [EvaluationModel] = [
        EvaluationModel(number: 4,
                        allCommentCount: 4,
                        allCommentStar: 4,
                        contentRichness: 4.6,
                        equipment: 4.6,
                        geoLocation: 4.6,
                        price: 4.6,
                        service: 4.6,
                        commentContents: [.init(userImage: "Cathy",
                                                userName: "Cathy",
                                                star: 4,
                                                commentDate: "2023-06-01",
                                                contentRichness: 4.6,
                                                equipment: 4.6,
                                                geoLocation: 4.6,
                                                price: 4.6,
                                                service: 4.7)
                                          ,.init(userImage: "Cathy",
                                                 userName: "Cathy",
                                                 star: 4,
                                                 commentDate: "2023-06-01",
                                                 contentRichness: 4.6,
                                                 equipment: 4.6,
                                                 geoLocation: 4.6,
                                                 price: 4.6,
                                                 service: 4.7)])
    ]
    
    func evaluationNumberOfRowInSection(section: Int) -> Int {
        switch EvaluationSection(rawValue: section) {
        case .allComment: return evaluations.count
        case .personComment: return evaluations[section].commentContents.count
        case .none: return 1
        }
    }
    
    func evaluationTableCellForRowAt(indexPath: IndexPath) -> EvaluationModel {
        switch EvaluationSection(rawValue: indexPath.section) {
        case .allComment: return evaluations[indexPath.row]
        case .personComment: return evaluations[indexPath.row]
        case .none: return EvaluationModel(number: 0, allCommentCount: 0, allCommentStar: 0, contentRichness: 0.0, equipment: 0.0, geoLocation: 0.0, price: 0.0, service: 0.0, commentContents: [])
        }
    }
    
    func evaluationTableDidSelectedRow() {
        
    }
    
}
