//
//  Member.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/19.
//

import Foundation

class Member: Codable {
    var id: Int?
    var account: String?
    var nickname: String?
    var status: Int?
    var register_datetime: String?
    var last_update_member_id: Int?
    
    public init (_ id: Int, _ account: String, nickname: String, _ status: Int, _ register_datetime: String, _ last_update_member_id: Int) {
        self.id = id
        self.account = account
        self.nickname = nickname
        self.status = status
        self.register_datetime = register_datetime
        self.last_update_member_id = last_update_member_id
    }
}
