//
//  RequirementForm.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/18.
//

import Foundation

class RequirementForm: Codable {
    var id: Int?
    var city: Int?
    var district: Int?
    var daily_charge: Int?
    var status: Int?
    var visibility: Int?
    var member_id:Int?
    
    public init (_ id: Int, _ city: Int, _ district: Int, _ daily_charge: Int, _ status: Int, _ visibility: Int, _ member_id: Int) {
        self.id = id
        self.city = city
        self.district = district
        self.daily_charge = daily_charge
        self.status = status
        self.visibility = visibility
        self.member_id = member_id
    }
}

