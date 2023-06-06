//
//  NotifyViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/31.
//

import Foundation

enum NotifyType : Int, CaseIterable {
    case exhibitionNotify = 0, systemNotify
    var title: String {
        switch self {
        case .exhibitionNotify: return "展覽通知"
        case .systemNotify: return "系統通知"
        }
    }
}

class NotifyViewModel {
    
    //MARK: - Singleton
    static let shared = NotifyViewModel()
    
    //MARK: - Properties
    private var isOpenNotified: Bool = false
    
    var currentNotifyPage: NotifyType = .exhibitionNotify
    
    private var exhibitions: [ExhibitionInfo] = [
        ExhibitionInfo(title: "賴威嚴油畫", image: "1881", tag: "油畫", dateString: "2023.03.21-04.20", time: "2023.03.21-04.20", agency: "", official: "", telephone: "", advanceTicketPrice: "", unanimousVotePrice: "", studentPrice: "", groupPrice: "", lovePrice: "", free: "", earlyBirdPrice: "", city: "", location: "台南市", address: "", latitude: "", longtitude: ""),
        ExhibitionInfo(title: "賴威嚴油畫", image: "1881", tag: "油畫", dateString: "2023.03.21-04.20", time: "2023.03.21-04.20", agency: "", official: "", telephone: "", advanceTicketPrice: "", unanimousVotePrice: "", studentPrice: "", groupPrice: "", lovePrice: "", free: "", earlyBirdPrice: "", city: "", location: "台南市", address: "", latitude: "", longtitude: ""),
        ExhibitionInfo(title: "賴威嚴油畫", image: "1881", tag: "油畫", dateString: "2023.03.21-04.20", time: "2023.03.21-04.20", agency: "", official: "", telephone: "", advanceTicketPrice: "", unanimousVotePrice: "", studentPrice: "", groupPrice: "", lovePrice: "", free: "", earlyBirdPrice: "", city: "", location: "台南市", address: "", latitude: "", longtitude: ""),
        ExhibitionInfo(title: "賴威嚴油畫", image: "1881", tag: "油畫", dateString: "2023.03.21-04.20", time: "2023.03.21-04.20", agency: "", official: "", telephone: "", advanceTicketPrice: "", unanimousVotePrice: "", studentPrice: "", groupPrice: "", lovePrice: "", free: "", earlyBirdPrice: "", city: "", location: "台南市", address: "", latitude: "", longtitude: ""),
        ExhibitionInfo(title: "賴威嚴油畫", image: "1881", tag: "油畫", dateString: "2023.03.21-04.20", time: "2023.03.21-04.20", agency: "", official: "", telephone: "", advanceTicketPrice: "", unanimousVotePrice: "", studentPrice: "", groupPrice: "", lovePrice: "", free: "", earlyBirdPrice: "", city: "", location: "台南市", address: "", latitude: "", longtitude: ""),
        ExhibitionInfo(title: "賴威嚴油畫", image: "1881", tag: "油畫", dateString: "2023.03.21-04.20", time: "2023.03.21-04.20", agency: "", official: "", telephone: "", advanceTicketPrice: "", unanimousVotePrice: "", studentPrice: "", groupPrice: "", lovePrice: "", free: "", earlyBirdPrice: "", city: "", location: "台南市", address: "", latitude: "", longtitude: ""),
        ExhibitionInfo(title: "賴威嚴油畫", image: "1881", tag: "油畫", dateString: "2023.03.21-04.20", time: "2023.03.21-04.20", agency: "", official: "", telephone: "", advanceTicketPrice: "", unanimousVotePrice: "", studentPrice: "", groupPrice: "", lovePrice: "", free: "", earlyBirdPrice: "", city: "", location: "台南市", address: "", latitude: "", longtitude: "")
    ]
    
    private var readExhibitions: Set<ExhibitionInfo> = Set<ExhibitionInfo>()
    
    private var systemNotifications: [NotifyModel] = [
        NotifyModel(title: "APP升級維護公告", description: "為提供您更好的服務及用戶體驗，我們將在2023.04.20  18:00-22:00進行系統升級與維護。", dateString: "2023-06-03"),
        NotifyModel(title: "APP升級維護公告", description: "為提供您更好的服務及用戶體驗，我們將在2023.04.20  18:00-22:00進行系統升級與維護。", dateString: "2023-06-03"),
        NotifyModel(title: "APP升級維護公告", description: "為提供您更好的服務及用戶體驗，我們將在2023.04.20  18:00-22:00進行系統升級與維護。", dateString: "2023-06-03"),
        NotifyModel(title: "APP升級維護公告", description: "為提供您更好的服務及用戶體驗，我們將在2023.04.20  18:00-22:00進行系統升級與維護。", dateString: "2023-06-03")
    ]
    
    private var unreadCount: Int {
        get {
            return exhibitions.count
        }
    }
    
    func setUnReadCount() -> Int {
        print("unreadCount:\(unreadCount)")
        return unreadCount
    }
    
    //MARK: -CollectionVeiw methods
    
    func notifyTypeNumberOfRowInSection(setion: Int) -> Int {
        return NotifyType.allCases.count
    }
    
    func notifyTypeCellForRowAt(indexPath: IndexPath) -> (type: NotifyType, isSelected: Bool) {
        let isSelected = currentNotifyPage == NotifyType(rawValue: indexPath.row)
        switch NotifyType(rawValue: indexPath.row) {
        case .exhibitionNotify:
            return (NotifyType.exhibitionNotify, isSelected)
        case .systemNotify:
            return (NotifyType.systemNotify, isSelected)
        case .none: return (NotifyType.exhibitionNotify, isSelected)
        }
    }
    
    func notifyTypeDidItemSelectedRowAt(indexPath: IndexPath) {
        switch NotifyType(rawValue: indexPath.row) {
        case .exhibitionNotify: currentNotifyPage = NotifyType(rawValue: indexPath.row)!
        case .systemNotify: currentNotifyPage = NotifyType(rawValue: indexPath.row)!
        case .none: print("none")
        }
    }
    
    //MARK: - TableView methods
    
    func numberOfRowInSection(section: Int) -> Int {
        switch currentNotifyPage {
        case .exhibitionNotify:
            return exhibitions.isEmpty ? 0 : exhibitions.count
        case .systemNotify:
            return systemNotifications.isEmpty ? 0 : systemNotifications.count
        }
    }
    
    func exhibitionsCellForRowAt(indexPath: IndexPath) -> ExhibitionInfo? {
        return exhibitions.isEmpty ? nil : exhibitions[indexPath.row]
    }
    
    func systemNotificationsCellForRowAt(indexPath: IndexPath) -> NotifyModel? {
        return systemNotifications.isEmpty ? nil : systemNotifications[indexPath.row]
    }
    
    func didSelectedRowAt(indexPath: IndexPath) {
        switch currentNotifyPage {
        case .exhibitionNotify:
            readExhibitions.insert(exhibitions[indexPath.row])
            print("readExhibitions:\(readExhibitions)")
            print("readExhibitions.count:\(readExhibitions.count)")
        case .systemNotify:
            print("systemNotification")
        }
    }
    
    func isReadCellAt(indexPath: IndexPath) -> Bool {
        return readExhibitions.contains(exhibitions[indexPath.row])
    }
    
    func toggleNotification(isOn: Bool) {
        isOpenNotified = isOn
    }
}
