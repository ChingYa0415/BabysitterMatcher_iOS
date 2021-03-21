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
        changeStatus(type: 2)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btToSuspension(_ sender: Any) {
        changeStatus(type: 5)
        self.navigationController?.popViewController(animated: true)
    }
    
    let url_server = URL(string: common_url + "Homepage")
    var member: Member?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lbMemberAccount.text = member?.account
        self.lbMemberNickname.text = member?.nickname
        
        var requestParam = [String: Any]()
        
        requestParam["action"] = "getMemberImage"
        requestParam["imageSize"] = self.ivMember.frame.height
        requestParam["id"] = member?.id
        var image: UIImage?
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    image = UIImage(data: data!)
                }
                if image == nil {
                    image = UIImage(named: "noImage.jpg")
                }
                DispatchQueue.main.async {
                    self.ivMember.image = image
                }
            } else {
                print(error!.localizedDescription)
            }
        
        }
        
        requestParam["action"] = "getMemberRegisterDate"
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultMemberRegisterDate: \(result)")
                        DispatchQueue.main.async {
                            self.lbMemberRegisterDate.text = result
                        }
                    }
                }
            }
        }
        
        requestParam["action"] = "getMemberForumAndReplyCount"
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode([Int].self, from: data!) {
                        print("resultMemberForumAndReplyCount: \(result)")
                        DispatchQueue.main.async {
                            self.lbMemberForumCount.text = String(result[0])
                            self.lbMemberReplyCount.text = String(result[1])
                        }
                    }
                }
            }
        }
    }
    
    func changeStatus(type: Int) {
        var requestParam = [String: Any]()
        
        requestParam["action"] = "setMemberStatus"
        requestParam["memberId"] = member?.id
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
