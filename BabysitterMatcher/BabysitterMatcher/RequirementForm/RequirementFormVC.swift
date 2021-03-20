//
//  RequirementFormVC.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/18.
//

import UIKit

class RequirementFormVC: UIViewController {

    
    @IBOutlet weak var lbVisibility: UILabel!
    @IBOutlet weak var lbRequirementFormId: UILabel!
    @IBOutlet weak var lbMembertNickname: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbDistrict: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbCharge: UILabel!
    @IBAction func btShow(_ sender: Any) {
        showRequirementFormStatus()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btHide(_ sender: Any) {
        hideRequirementFormStatus()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    let url_server = URL(string: common_url + "Homepage")
    var requirementForm: RequirementForm?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let status = requirementForm?.visibility{
            if status == 1 {
                self.lbVisibility.text = "正常"
            } else {
                self.lbVisibility.text = "隱藏"
            }
        }
        
        self.lbRequirementFormId.text = String((requirementForm!.id)!)
        self.lbCharge.text = String((requirementForm!.daily_charge)!)

        var requestParam = [String: Any]()
        
        requestParam["action"] = "getMemberNickname"
        requestParam["memberId"] = requirementForm?.member_id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultMemberNickname: \(result)")
                        DispatchQueue.main.async {
                            self.lbMembertNickname.text = result
                        }
                    }
                }
            }
        }
        
        let city = City()
        
        var cityCount = 0
        for city in city.arrayCity {
            if cityCount == self.requirementForm?.city {
                print(city)
                DispatchQueue.main.async {
                    self.lbCity.text = city
                }
            }
            cityCount += 1
            
        }
        
        var districtCount = 0
        for districts in city.arrayDistrict {
            for district in districts {
                if districtCount == self.requirementForm?.district {
                    print(district)
                    DispatchQueue.main.async {
                        self.lbDistrict.text = district
                        print("行政區 \(district)")
                    }
                }
                districtCount += 1
            }
        }
        
        requestParam["action"] = "getRequirementFormDateAndTime"
        requestParam["requirementFormId"] = requirementForm?.id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode([String].self, from: data!) {
                        print("resultRequirementFormDate: \(result)")
                        DispatchQueue.main.async {
                            self.lbDate.text = result[0]
                            self.lbTime.text = result[1]
                        }
                    }
                }
            }
        }
    }
    
    func hideRequirementFormStatus() {
        var requestParam = [String: Any]()
        requestParam["action"] = "hideRequirementFormStatus"
        requestParam["requirementFormId"] = self.requirementForm?.id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(Int.self, from: data!) {
                        print("resultHideRequirementFormStatus: \(String(describing: result))")
                        DispatchQueue.main.async {
                            self.lbVisibility.text = "隱藏"
                        }
                    }
                }
            }
        }
    }
    
    func showRequirementFormStatus() {
        var requestParam = [String: Any]()
        requestParam["action"] = "showRequirementFormStatus"
        requestParam["requirementFormId"] = self.requirementForm?.id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(Int.self, from: data!) {
                        print("resultShowRequirementFormStatus: \(String(describing: result))")
                        DispatchQueue.main.async {
                            self.lbVisibility.text = "正常"
                        }
                    }
                }
            }
        }
    }
    
}
