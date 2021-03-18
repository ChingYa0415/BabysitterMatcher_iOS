//
//  Babysitter.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/17.
//

import Foundation

class Babysitter: Codable {
    var id: Int?
    var name: String?
    var age: Int?
    var gender: Int?
    var cellphone: String?
    var seniority: Float?
    var city: String?
    var district: String?
    var address: String?
    var charge: String?
    var status: Int?
    var capacity: Int?
    var occupied: Int?
    var average_review_star: Float?
    var completed_order_count: Int?
    var self_introduction: String?
//    var last_update_datetime: Date?
    var last_update_member_id: Int?
    var member_id: Int?
    
//    output: {"id":20,"name":"王保母","age":42,"gender":0,"cellphone":"0980999999","seniority":0.0,"city":"基隆市","district":"(200)仁愛區","address":"台北市中山區南京東路三段219號5樓","charge":"日間托育：25000/月","status":1,"capacity":2,"occupied":0,"average_review_star":0.0,"completed_order_count":0,"self_introduction":"曾帶Peter從3個月直到成年，擁有30多年保姆經驗，每個被帶過長大不是律師就是醫生。","last_update_datetime":"2021-03-11 11:52:45","last_update_member_id":0,"member_id":50}

    
    public init(_ id: Int, _ name: String, _ age: Int, _ gender: Int, _ cellphone: String, _ seniority: Float, _ city: String, _ district: String, _ address: String, _ charge: String, _ status: Int, _ capacity: Int, _ occupied: Int, _ average_review_star: Float, _ completed_order_count: Int, _ self_introduction: String, _ last_update_member_id: Int, _ member_id: Int) {
        self.id = id
        self.name = name
        self.age = age
        self.gender = gender
        self.cellphone = cellphone
        self.seniority = seniority
        self.city = city
        self.district = district
        self.address = address
        self.charge = charge
        self.status = status
        self.capacity = capacity
        self.occupied = occupied
        self.average_review_star = average_review_star
        self.completed_order_count = completed_order_count
        self.self_introduction = self_introduction
//        self.last_update_datetime = last_update_datetime
        self.last_update_member_id = last_update_member_id
        self.member_id = member_id
    }
}
