//
//  PostReviewVC.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/16.
//

import UIKit

class ForumVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbNickname: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var ivLike: UIImageView!
    @IBOutlet weak var lbLikeCount: UILabel!
    @IBOutlet weak var ivReply: UIImageView!
    @IBOutlet weak var lbReplyCount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let url_server = URL(string: common_url + "Homepage")
    var post: Post!
    var replyList = [Reply]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let status = post.status {
            if status == 1 {
                lbStatus.text = "正常"
                lbStatus.textColor = .blue
            } else {
                lbStatus.text = "隱藏"
                lbStatus.textColor = .red
            }
        }
        
        lbTitle.text = post.title
        lbType.text = post.type
        lbContent.text = post.content
        
        var requestParam = [String: Any]()
        requestParam["action"] = "getForumReplyCount"
        requestParam["postId"] = post.post_id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(Int.self, from: data!) {
                        print("resultReplyCount: \(result)")
                        DispatchQueue.main.async {
                            self.lbReplyCount.text = String(result)
                        }
                    }
                }
            }
        }
        
        requestParam["action"] = "getForumPostDate"
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultDate: \(result)")
                        DispatchQueue.main.async {
                            self.lbDate.text = result
                        }
                    }
                }
            }
        }
        
        requestParam["action"] = "getMemberNickname"
        requestParam["memberId"] = post.member_id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultNickname: \(result)")
                        DispatchQueue.main.async {
                            self.lbNickname.text = result
                        }
                    }
                }
            }
        }
        
        requestParam["action"] = "getAllForumReply"
        requestParam["postId"] = String(post.post_id!)
        executeTask(url_server!, requestParam) { (data, respond, error) in
            let decoder = JSONDecoder()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(format)
            if error == nil {
                if data != nil {
                    print("input \(String(data: data!, encoding: .utf8)!)")
                    
                    if let result = try? decoder.decode([Reply].self, from: data!) {
                        self.replyList = result
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "PostReviewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! PostReviewCell
        
        let reply = replyList[indexPath.row]
        
        var requestParam = [String: Any]()
        requestParam["action"] = "getPostReplyDate"
        requestParam["postReplyId"] = reply.reply_id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultPostReplyDate: \(result)")
                        DispatchQueue.main.async {
                            cell.lbDate.text = result
                        }
                    }
                }
            }
        }
        
        requestParam["action"] = "getMemberNickname"
        requestParam["memberId"] = reply.member_id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultMemberNickname: \(result)")
                        DispatchQueue.main.async {
                            cell.lbNickname.text = result
                        }
                    }
                }
            }
        }
        
        cell.lbContent.text = reply.content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replyList.count
    }
}
