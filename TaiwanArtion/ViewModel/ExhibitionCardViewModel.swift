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
    
//    func numberOfRowInSection(chooseItem: CardInfoItem, section: Int) -> Int {
//        switch chooseItem {
//        case .overview: return 1
//        case .introduce: return 1
//        case .ticketPrice: return 7
//        case .location:
//            switch section ==
//        case .evaluate: return
//        }
//    }

//    func cellForRowAt(chooseItem: CardInfoItem, indexPath: IndexPath) -> ExhibitionModel {
//
//    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        
    }
    
}
