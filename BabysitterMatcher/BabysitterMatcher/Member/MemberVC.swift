//
//  MemberVC.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/19.
//

import UIKit

class MemberVC: UIViewController {
    
    @IBOutlet weak var ivMember: UIImageView!
    @IBOutlet weak var lbMemberAccount: UILabel!
    @IBOutlet weak var lbMemberNickname: UILabel!
    @IBOutlet weak var lbMemberRegisterDate: UILabel!
    @IBOutlet weak var lbMemberForumCount: UILabel!
    @IBOutlet weak var lbMemberReplyCount: UILabel!
    @IBAction func btToNormal(_ sender: Any) {
        changeStatusToNormal()
    }
    @IBAction func btToSuspension(_ sender: Any) {
        changeStatusToSuspension()
    }
    @IBAction func change(_ sender: UISegmentedControl) {
        for containerView in MemberAndBabysitter {
              containerView.isHidden = true
           }
        MemberAndBabysitter[sender.selectedSegmentIndex].isHidden = false
    }
    @IBOutlet var MemberAndBabysitter: [UIView]!
    
    let url_server = URL(string: common_url + "Homepage")
    var member: Member!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MemberAndBabysitter[0].isHidden = false
        MemberAndBabysitter[1].isHidden = true
        
        var requestParam = [String: Any]()
        
        requestParam["action"] = "getMemberForumAndReplyCount"
        requestParam["memberId"] = member.id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode([String].self, from: data!) {
                        print("resultMemberForumAndReplyCount: \(result)")
                        DispatchQueue.main.async {
                            self.lbMemberForumCount.text = result[0]
                            self.lbMemberReplyCount.text = result[1]
                        }
                    }
                }
            }
        }
        
    }
    
    func changeStatusToNormal() {
        var requestParam = [String: Any]()
        
        requestParam["action"] = "setMemberToNormal"
        requestParam["memberId"] = member.id
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
    
    func changeStatusToSuspension() {
        var requestParam = [String: Any]()
        
        requestParam["action"] = "setMemberToSuspension"
        requestParam["memberId"] = member.id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultSetMemberToSuspension: \(result)")
                    }
                }
            }
        }
    }

    

}
