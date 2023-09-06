//
//  ExhibitionCalendarViewModel.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/8/30.
//

import Foundation
import RxRelay


protocol ExhibitionCalendarInput {
    
    //輸入點擊Habby
    var inputHabby: BehaviorRelay<HabbyItem?> { get }
    
    //輸入取得時間
    var inputDate: BehaviorRelay<String> { get }
    
    //輸入展覽月曆、展覽清單點擊的Button
    var inputContentTypeItem: BehaviorRelay<Bool> { get }
    
}

protocol ExhibitionCalendarOutput {
    
    //輸出點擊的Item
    var outputContentTypeItem: BehaviorRelay<Bool> { get }
    
    //輸出點擊的Habby
    var outputHabby: BehaviorRelay<HabbyItem?> { get }
    
    //選擇的展覽
    var outputExhibitions: BehaviorRelay<[ExhibitionInfo]> { get }
    
    //輸出日期
    var outputDate: BehaviorRelay<String?> { get }
    
    var outputRecentValidExhibitionDate: BehaviorRelay<[ExhibitionInfo]> { get }
    
}

protocol ExhibitionCalendarTypeInputOutput {
    
    var input: ExhibitionCalendarInput { get }
    
    var output: ExhibitionCalendarOutput { get }
    
}


class ExhibitionCalendarViewModel: ExhibitionCalendarTypeInputOutput, ExhibitionCalendarInput, ExhibitionCalendarOutput {
    
    //MARK: - input
    var inputHabby: BehaviorRelay<HabbyItem?> = BehaviorRelay(value: nil)
    
    var inputDate: RxRelay.BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var inputContentTypeItem: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    //MARK: - output
    
    var outputContentTypeItem: RxRelay.BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    var outputHabby: BehaviorRelay<HabbyItem?> = BehaviorRelay(value: nil)
    
    var outputExhibitions: RxRelay.BehaviorRelay<[ExhibitionInfo]> = BehaviorRelay(value: [])
    
    var outputDate: RxRelay.BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    var outputRecentValidExhibitionDate: RxRelay.BehaviorRelay<[ExhibitionInfo]> = BehaviorRelay(value: [])
    
    //MARK: - input/output
    
    var input: ExhibitionCalendarInput { self }
    
    var output: ExhibitionCalendarOutput { self }
    
    //MARK: - Firebase
    
    private let firebase = FirebaseDatabase(collectionName: "exhibitions")
    
    //MARK: - Initialization
    init() {
        outputContentTypeItem = inputContentTypeItem
        
        outputHabby = inputHabby
        
        fetchDataHotExhibition(by: 10) { infos in
            self.outputExhibitions.accept(infos)
        }
    }
    
    func fetchDataHotExhibition(by count: Int, completion: @escaping (([ExhibitionInfo]) -> Void)) {
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
}
