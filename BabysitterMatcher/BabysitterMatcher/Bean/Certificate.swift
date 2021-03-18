//
//  Certificate.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/16.
//

import Foundation

class Certificate: Codable {
    var id: Int?
    var expiration_date: Date?
    var status: Int?
    var last_update_datetime: Date?
    var last_update_member_id: Int?
    var member_id: Int?
    
    public init(_ id: Int, _ expiration_date: Date, _ status: Int, _ last_update_datetime: Date, _ last_update_member_id: Int, _ member_id: Int) {
        self.id = id
        self.expiration_date = expiration_date
        self.status = status
        self.last_update_datetime = last_update_datetime
        self.last_update_member_id = last_update_member_id
        self.member_id = member_id
    }
    
    var expirationDateStr: String {
        if expiration_date != nil {
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd"
            return format.string(from: last_update_datetime!)
        } else {
            return ""
        }
    }
    
    var lastUpdateDatetimeStr: String {
        if last_update_datetime != nil {
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd"
            return format.string(from: last_update_datetime!)
        } else {
            return ""
        }
    }
    
}
