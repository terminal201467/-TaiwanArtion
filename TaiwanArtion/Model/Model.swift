//
//  Model.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/18.
//

import Foundation

struct ExhibitionModel: Hashable {
    
    var title: String
    var location: String
    var dateString: String
    var image: String
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString) ?? Date()
    }
    
    var dateBefore: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let pastDate = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            
            let currentDate = Date()
            let components = calendar.dateComponents([.day], from: pastDate, to: currentDate)
            if let days = components.day {
                return days
            }
        }
        return 0
    }
    
}


struct NewsModel {
    
    var title: String
    var date: String
    var author: String
    var image: String
    
}

struct ExhibitionInfo {
    
    var tag: String
    var date: String
    var time: String
    var agency: String
    var official: String
    var telephone: String
    
    //票價：
    var advanceTicketPrice: String
    var unanimousVotePrice: String
    var studentPrice: String
    var groupPrice: String
    var lovePrice: String
    var free: String
    var earlyBirdPrice: String
    
    var location: String
    var address: String
    
    var equipments: [String]
    
    var latitude: String
    var longtitude: String
}


struct EvaluationModel {
    
    var number: Int
    var allCommentCount: Int
    var allCommentStar: Int
    var allCommentRate: [CommentRate]
    var allCommentContents: [CommentContent]
    
    struct CommentContent {
        var userImage: String
        var userName: String
        var star: Int
        var commentDate: String
        var commentRate: [CommentRate]
    }
}

struct CommentRate {
    var contentRichness: Double
    var equipment: Double
    var geoLocation: Double
    var price: Double
    var service: Double
}
