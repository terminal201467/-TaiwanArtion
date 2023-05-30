//
//  Model.swift
//  TaiwanArtion
//
//  Created by Jhen Mu on 2023/5/18.
//

import Foundation

struct ExhibitionModel {
    
    var title: String
    var location: String
    var date: String
    var image: String
    
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

//所有評論

//分別評論

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
