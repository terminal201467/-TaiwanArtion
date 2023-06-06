//
//  HomeViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/18.
//

import Foundation

enum Month: Int, CaseIterable {
    case jan = 0, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec
    var numberText: String {
        switch self {
        case .jan: return "1"
        case .feb: return "2"
        case .mar: return "3"
        case .apr: return "4"
        case .may: return "5"
        case .jun: return "6"
        case .jul: return "7"
        case .aug: return "8"
        case .sep: return "9"
        case .oct: return "10"
        case .nov: return "11"
        case .dec: return "12"
        }
    }
    var englishText: String {
        switch self {
        case .jan: return "Jan"
        case .feb: return "Feb"
        case .mar: return "Mar"
        case .apr: return "Apr"
        case .may: return "May"
        case .jun: return "Jun"
        case .jul: return "Jul"
        case .aug: return "Aug"
        case .sep: return "Sep"
        case .oct: return "Oct"
        case .nov: return "Nov"
        case .dec: return "Dec"
        }
    }
}

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

class HomeViewModel {
    
    static let shared = HomeViewModel()
    
    var hotExhibition: [ExhibitionInfo] = [
        ExhibitionInfo(title: "未來身體-超自然雕塑", image: "futureBody", tag: "雕塑", dateString: "2023.05.18 - 05.20", time: "", agency: "", official: "", telephone: "00427022969", advanceTicketPrice: "199", unanimousVotePrice: "199", studentPrice: "199", groupPrice: "199", lovePrice: "199", free: "199", earlyBirdPrice: "199", city: "台南市", location: "台南市", address: "", equipments: ["","","",""], latitude: "", longtitude: "", evaluation: .init(number: 0, allCommentCount: 0, allCommentStar: 0, allCommentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)], allCommentContents: [.init(userImage: "", userName: "", star: 0, commentDate: "", commentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)])])),
        ExhibitionInfo(title: "未來身體-超自然雕塑", image: "futureBody", tag: "雕塑", dateString: "2023.05.18 - 05.20", time: "", agency: "", official: "", telephone: "00427022969", advanceTicketPrice: "199", unanimousVotePrice: "199", studentPrice: "199", groupPrice: "199", lovePrice: "199", free: "199", earlyBirdPrice: "199", city: "台南市", location: "台南市", address: "", equipments: ["","","",""], latitude: "", longtitude: "", evaluation: .init(number: 0, allCommentCount: 0, allCommentStar: 0, allCommentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)], allCommentContents: [.init(userImage: "", userName: "", star: 0, commentDate: "", commentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)])])),
        ExhibitionInfo(title: "未來身體-超自然雕塑", image: "futureBody", tag: "雕塑", dateString: "2023.05.18 - 05.20", time: "", agency: "", official: "", telephone: "00427022969", advanceTicketPrice: "199", unanimousVotePrice: "199", studentPrice: "199", groupPrice: "199", lovePrice: "199", free: "199", earlyBirdPrice: "199", city: "台南市", location: "台南市", address: "", equipments: ["","","",""], latitude: "", longtitude: "", evaluation: .init(number: 0, allCommentCount: 0, allCommentStar: 0, allCommentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)], allCommentContents: [.init(userImage: "", userName: "", star: 0, commentDate: "", commentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)])])),
        ExhibitionInfo(title: "未來身體-超自然雕塑", image: "futureBody", tag: "雕塑", dateString: "2023.05.18 - 05.20", time: "", agency: "", official: "", telephone: "00427022969", advanceTicketPrice: "199", unanimousVotePrice: "199", studentPrice: "199", groupPrice: "199", lovePrice: "199", free: "199", earlyBirdPrice: "199", city: "台南市", location: "台南市", address: "", equipments: ["","","",""], latitude: "", longtitude: "", evaluation: .init(number: 0, allCommentCount: 0, allCommentStar: 0, allCommentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)], allCommentContents: [.init(userImage: "", userName: "", star: 0, commentDate: "", commentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)])])),
        ExhibitionInfo(title: "未來身體-超自然雕塑", image: "futureBody", tag: "雕塑", dateString: "2023.05.18 - 05.20", time: "", agency: "", official: "", telephone: "00427022969", advanceTicketPrice: "199", unanimousVotePrice: "199", studentPrice: "199", groupPrice: "199", lovePrice: "199", free: "199", earlyBirdPrice: "199", city: "台南市", location: "台南市", address: "", equipments: ["","","",""], latitude: "", longtitude: "", evaluation: .init(number: 0, allCommentCount: 0, allCommentStar: 0, allCommentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)], allCommentContents: [.init(userImage: "", userName: "", star: 0, commentDate: "", commentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)])]))
    ]
    
    var mainPhoto: [ExhibitionInfo] = [
        ExhibitionInfo(title: "未來身體-超自然雕塑", image: "noIdea", tag: "雕塑", dateString: "2023.05.18 - 05.20", time: "", agency: "", official: "", telephone: "00427022969", advanceTicketPrice: "199", unanimousVotePrice: "199", studentPrice: "199", groupPrice: "199", lovePrice: "199", free: "199", earlyBirdPrice: "199", city: "台南市", location: "台南市", address: "", equipments: ["","","",""], latitude: "", longtitude: "", evaluation: .init(number: 0, allCommentCount: 0, allCommentStar: 0, allCommentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)], allCommentContents: [.init(userImage: "", userName: "", star: 0, commentDate: "", commentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)])])),
        ExhibitionInfo(title: "未來身體-超自然雕塑", image: "noIdea", tag: "雕塑", dateString: "2023.05.18 - 05.20", time: "", agency: "", official: "", telephone: "00427022969", advanceTicketPrice: "199", unanimousVotePrice: "199", studentPrice: "199", groupPrice: "199", lovePrice: "199", free: "199", earlyBirdPrice: "199", city: "台南市", location: "台南市", address: "", equipments: ["","","",""], latitude: "", longtitude: "", evaluation: .init(number: 0, allCommentCount: 0, allCommentStar: 0, allCommentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)], allCommentContents: [.init(userImage: "", userName: "", star: 0, commentDate: "", commentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)])])),
        ExhibitionInfo(title: "未來身體-超自然雕塑", image: "noIdea", tag: "雕塑", dateString: "2023.05.18 - 05.20", time: "", agency: "", official: "", telephone: "00427022969", advanceTicketPrice: "199", unanimousVotePrice: "199", studentPrice: "199", groupPrice: "199", lovePrice: "199", free: "199", earlyBirdPrice: "199", city: "台南市", location: "台南市", address: "", equipments: ["","","",""], latitude: "", longtitude: "", evaluation: .init(number: 0, allCommentCount: 0, allCommentStar: 0, allCommentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)], allCommentContents: [.init(userImage: "", userName: "", star: 0, commentDate: "", commentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)])]))
    ]
    
    var news: [NewsModel] = [
        NewsModel(title: "德國博物館483枚古金幣遭竊 損失數百萬歐元", date: "2022.12.01", author: "吳綺莉", image: "2049"),
        NewsModel(title: "德國博物館483枚古金幣遭竊 損失數百萬歐元", date: "2022.12.01", author: "吳綺莉", image: "2049"),
        NewsModel(title: "德國博物館483枚古金幣遭竊 損失數百萬歐元", date: "2022.12.01", author: "吳綺莉", image: "2049")
    ]
    
    var allExhibition: [ExhibitionInfo] = [
        ExhibitionInfo(title: "未來身體-超自然雕塑", image: "selfDemo", tag: "雕塑", dateString: "2023.05.18 - 05.20", time: "", agency: "", official: "", telephone: "00427022969", advanceTicketPrice: "199", unanimousVotePrice: "199", studentPrice: "199", groupPrice: "199", lovePrice: "199", free: "199", earlyBirdPrice: "199", city: "台南市", location: "台南市", address: "", equipments: ["","","",""], latitude: "", longtitude: "", evaluation: .init(number: 0, allCommentCount: 0, allCommentStar: 0, allCommentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)], allCommentContents: [.init(userImage: "", userName: "", star: 0, commentDate: "", commentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)])])),
        ExhibitionInfo(title: "未來身體-超自然雕塑", image: "selfDemo", tag: "雕塑", dateString: "2023.05.18 - 05.20", time: "", agency: "", official: "", telephone: "00427022969", advanceTicketPrice: "199", unanimousVotePrice: "199", studentPrice: "199", groupPrice: "199", lovePrice: "199", free: "199", earlyBirdPrice: "199", city: "台南市", location: "台南市", address: "", equipments: ["","","",""], latitude: "", longtitude: "", evaluation: .init(number: 0, allCommentCount: 0, allCommentStar: 0, allCommentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)], allCommentContents: [.init(userImage: "", userName: "", star: 0, commentDate: "", commentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)])])),
        ExhibitionInfo(title: "未來身體-超自然雕塑", image: "selfDemo", tag: "雕塑", dateString: "2023.05.18 - 05.20", time: "", agency: "", official: "", telephone: "00427022969", advanceTicketPrice: "199", unanimousVotePrice: "199", studentPrice: "199", groupPrice: "199", lovePrice: "199", free: "199", earlyBirdPrice: "199", city: "台南市", location: "台南市", address: "", equipments: ["","","",""], latitude: "", longtitude: "", evaluation: .init(number: 0, allCommentCount: 0, allCommentStar: 0, allCommentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)], allCommentContents: [.init(userImage: "", userName: "", star: 0, commentDate: "", commentRate: [.init(contentRichness: 0, equipment: 0, geoLocation: 0, price: 0, service: 0)])]))
    ]
    
    //MARK: - MonthCollectionView
    
    private var selectedMonth: Month = .jan
    
    func didMonthSelectItemAt(indexPath: IndexPath) {
        selectedMonth = Month(rawValue: indexPath.row)!
        //打API要該月份的資料
    }
    
    func monthCellForRowAt(indexPath: IndexPath) -> (selectedMonth: Month, isSelected: Bool) {
        let month = Month.allCases[indexPath.row]
        let isSelected = Month(rawValue: indexPath.row) == selectedMonth
        return (month, isSelected)
    }
    
    //MARK: - HabbyCollectionView
    
    private var selectedHabby: HabbyItem? = nil
    
    func didSelectHabbyItemAt(indexPath: IndexPath) {
        selectedHabby = HabbyItem(rawValue: indexPath.row)
        //打API要Habby的資料
        print("selectedHabby:\(HabbyItem(rawValue: indexPath.row)?.titleText)")
    }
    
    func habbyCellForRowAt(indexPath: IndexPath) -> (selectedHabby :HabbyItem, isSelected: Bool) {
        let habby = HabbyItem.allCases[indexPath.row]
        let isSelected = HabbyItem(rawValue: indexPath.row) == selectedHabby
        return (habby, isSelected)
    }
    
    //MARK: - MainPhoto
    
    func mainPhotoDidSelectItemAt(indexPath: IndexPath, completion: @escaping ((ExhibitionInfo) ->Void)) {
        completion(mainPhoto[indexPath.row])
    }
    
    //MARK: - HotTableView
    func hotExhibitionNumberOfRowInSection(section: Int) -> Int {
        return hotExhibition.count
    }
    
    func hotExhibitionCellForRowAt(indexPath: IndexPath) -> ExhibitionInfo {
        return hotExhibition[indexPath.row]
    }
    
    func hotExhibitionDidSelectedRowAt(indexPath: IndexPath , completion: @escaping ((ExhibitionInfo) -> Void)) {
        completion(hotExhibition[indexPath.row])
    }
    
    //MARK: - NewsTableView
    func newsExhibitionNumerOfRowInSection(section: Int) -> Int {
        return news.count
    }
    
    func newsExhibitionCellForRowAt(indexPath: IndexPath) -> NewsModel {
        return news[indexPath.row]
    }
    
    func newsExhibitionDidSelectedRowAt(indexPath: IndexPath, completion: @escaping((NewsModel) -> Void)) {
        completion(news[indexPath.row])
    }
    
    //MARK: - AllExhibitionTableView
    func allExhibitionNumerOfRowInSection(section: Int) -> Int {
        return allExhibition.count
    }
    
    func allExhibitionCellForRowAt(indexPath: IndexPath) -> ExhibitionInfo {
        return allExhibition[indexPath.row]
    }
    
    func allExhibitionDidSelectedRowAt(indexPath: IndexPath, completion: @escaping ((ExhibitionInfo) -> Void)) {
        completion(allExhibition[indexPath.row])
    }
    
    //MARK: -ItemsSelected
    
    var selectItem: Items = .newest
    
    func itemCellForRowAt(indexPath: IndexPath) -> (item: Items, isSelected: Bool) {
        let item = Items.allCases[indexPath.row]
        let isSelected = Items(rawValue: indexPath.row) == selectItem
        return (item, isSelected)
    }
    
    func itemDidSelectedRowAt(indexPath: IndexPath) {
        selectItem = Items(rawValue: indexPath.row)!
    }
    
}
