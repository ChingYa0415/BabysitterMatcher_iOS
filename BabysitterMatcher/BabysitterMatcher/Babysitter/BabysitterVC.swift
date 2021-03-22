//
//  BabysitterVC.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/21.
//

import UIKit

class BabysitterVC: UIViewController {

    @IBOutlet weak var lbBabysitterName: UILabel!
    @IBOutlet weak var lbBabysitterAge: UILabel!
    @IBOutlet weak var lbBabysitterGender: UILabel!
    @IBOutlet weak var lbBabysitterCellphone: UILabel!
    @IBOutlet weak var lbBabysitterSeniority: UILabel!
    @IBOutlet weak var lbBabysitterCity: UILabel!
    @IBOutlet weak var lbBabysitterDistrict: UILabel!
    @IBOutlet weak var lbBabysitterAddress: UILabel!
    @IBOutlet weak var lbBabysitterPlace: UILabel!
    @IBOutlet weak var lbBabysitterType: UILabel!
    @IBOutlet weak var lbBabysitterCharge: UILabel!
    @IBOutlet weak var lbBabysitterStatus: UILabel!
    @IBOutlet weak var lbBabysitterCapacity: UILabel!
    @IBOutlet weak var lbBabysitterOccupied: UILabel!
    @IBOutlet weak var lbBabysitterAverageReviewStar: UILabel!
    @IBOutlet weak var lbBabysitterCompletedOrderCount: UILabel!
    @IBOutlet weak var lbBabysitterSelfIntroduction: UILabel!
    @IBAction func btToBabysitter(_ sender: Any) {
        changeStatus(type: 3)
    }
    @IBAction func btToNormal(_ sender: Any) {
        changeStatus(type: 2)
    }
    
    let url_server = URL(string: common_url + "Homepage")
    var babysitter: Babysitter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lbBabysitterName.text = babysitter?.name
        self.lbBabysitterAge.text = String((babysitter!.age ?? 0))
        
        if babysitter?.gender == 1 {
            self.lbBabysitterGender.text = "男"
        } else if babysitter?.gender == 2 {
            self.lbBabysitterGender.text = "女"
        } else if babysitter?.gender == 3 {
            self.lbBabysitterGender.text = "其他"
        }
        
        self.lbBabysitterCellphone.text = babysitter?.cellphone
        
        if babysitter?.seniority == 1 {
            self.lbBabysitterSeniority.text = "5年以下"
        } else if babysitter?.seniority == 2 {
            self.lbBabysitterSeniority.text = "5~10年"
        } else if babysitter?.seniority == 3 {
            self.lbBabysitterSeniority.text = "10年以上"
        }
        
        self.lbBabysitterCity.text = babysitter?.city
        self.lbBabysitterDistrict.text = babysitter?.district
        self.lbBabysitterAddress.text = babysitter?.address
        self.lbBabysitterPlace.text = babysitter?.place
        self.lbBabysitterType.text = babysitter?.type
        self.lbBabysitterCharge.text = babysitter?.charge
        
        if babysitter?.status == 1 {
            self.lbBabysitterStatus.text = "可收托"
        } else if babysitter?.status == 2 {
            self.lbBabysitterStatus.text = "已額滿"
        } else if babysitter?.status == 3 {
            self.lbBabysitterStatus.text = "停止收托"
        }
        
        self.lbBabysitterCapacity.text = String((babysitter!.capacity ?? 0))
        self.lbBabysitterOccupied.text = String((babysitter!.occupied ?? 0))
        self.lbBabysitterAverageReviewStar.text = String((babysitter!.average_review_star ?? 0))
        self.lbBabysitterCompletedOrderCount.text = String((babysitter!.completed_order_count ?? 0))
        self.lbBabysitterSelfIntroduction.text = babysitter?.self_introduction
    }
    
    func changeStatus(type: Int) {
        var requestParam = [String: Any]()
        
        requestParam["action"] = "setMemberStatus"
        requestParam["memberId"] = babysitter?.member_id
        requestParam["type"] = type
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultSetMemberToNormal: \(result)")
                    }
                }
            }
        }
    }
}
