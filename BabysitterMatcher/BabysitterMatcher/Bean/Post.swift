//
//  Post.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/15.
//

import Foundation

class Post: Codable {
    var post_id: Int?
    var title: String?
    var content: String?
    var type: String?
    var status: Int?
    var dateTime: Date?
    var last_update_datetime: Date?
    var member_id: Int?
    var like_count: Int?
    
    public init(_ post_id: Int, _ title: String, _ content: String, _ type: String?, _ status: Int, _ dateTime: Date, _ last_update_datetime: Date, _ member_id: Int, _ like_count: Int){
        self.post_id = post_id
        self.title = title
        self.content = content
        self.type = type
        self.status = status
        self.dateTime = dateTime
        self.last_update_datetime = last_update_datetime
        self.member_id = member_id
        self.like_count = like_count
    }
    
    var dataStr: String {
        if dateTime != nil {
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd"
            return format.string(from: dateTime!)
        } else {
            return ""
        }
    }
}
