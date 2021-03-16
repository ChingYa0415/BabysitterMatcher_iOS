//
//  Reply.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/16.
//

import Foundation

class Reply: Codable {
    var reply_id: Int?
    var content: String?
    var date_time: Date?
    var last_update_datetime: Date?
    var post_id: Int?
    var member_id: Int?
    var like_count: Int?
    
    public init (_ reply_id: Int, _ content: String, _ date_time: Date, _ last_update_datetime:Date, _ post_id: Int, _ member_id: Int, _ like_count: Int) {
        self.reply_id = reply_id
        self.content = content
        self.date_time = date_time
        self.last_update_datetime = last_update_datetime
        self.post_id = post_id
        self.member_id = member_id
        self.like_count = like_count
    }
    
    var dataStr: String {
        if last_update_datetime != nil {
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd"
            return format.string(from: last_update_datetime!)
        } else {
            return ""
        }
    }
}
