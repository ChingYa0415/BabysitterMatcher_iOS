//
//  ForumTableViewController.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/15.
//

import UIKit

class ForumTVC: UITableViewController {
    let url_server = URL(string: common_url + "Homepage")
    var postList = [Post]()
    
    override func viewDidAppear(_ animated: Bool) {
        var requestParam = [String: String]()
        requestParam["action"] =  "getAllPost"
        
        executeTask(url_server!, requestParam) { (data, respond, error) in
            let decoder = JSONDecoder()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(format)
            if error == nil {
                if data != nil {
                    print("input \(String(data: data!, encoding: .utf8)!)")
                    
                    if let result = try? decoder.decode([Post].self, from: data!) {
                        print("resultAllPost \(result)")
                        self.postList = result
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var requestParam = [String: String]()
        requestParam["action"] =  "getAllPost"
        
        executeTask(url_server!, requestParam) { (data, respond, error) in
            let decoder = JSONDecoder()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(format)
            if error == nil {
                if data != nil {
                    print("input \(String(data: data!, encoding: .utf8)!)")
                    
                    if let result = try? decoder.decode([Post].self, from: data!) {
                        print("resultAllPost \(result)")
                        self.postList = result
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let hide = UIContextualAction(style: .normal, title: "隱藏") { (action, view, bool) in
            let post = self.postList[indexPath.row]
            let alert = UIAlertController(title: "隱藏此貼文", message: "確認將此貼文隱藏嗎？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let confirm = UIAlertAction(title: "確認", style: .default) { (alertAction) in
                if let postId = post.post_id {
                    var requestParam = [String: Any]()
                    requestParam["action"] = "hideForumStatus"
                    requestParam["postId"] = postId
                    executeTask(self.url_server!, requestParam) { (data, response, error) in
                        if error == nil {
                            if data != nil {
                                print("input: \(String(data: data!, encoding: .utf8)!)")
                                if let result = try? JSONDecoder().decode(Int.self, from: data!) {
                                    print("resultHideForumStatus: \(result)")
                                    post.status = result
                                    DispatchQueue.main.async {
                                        if let control = self.tableView.refreshControl {
                                            if control.isRefreshing {
                                                control.endRefreshing()
                                            }
                                        }
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            alert.addAction(cancel)
            alert.addAction(confirm)
            self.present(alert, animated: true, completion: nil)
        }
        
        hide.backgroundColor = .lightGray
        
        let show = UIContextualAction(style: .normal, title: "顯示") { (action, view, bool) in
            let post = self.postList[indexPath.row]
            let alert = UIAlertController(title: "顯示此貼文", message: "確認將此貼文顯示嗎？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let confirm = UIAlertAction(title: "確認", style: .default) {(alertAction) in
                if let postId = post.post_id {
                    var requestParam = [String: Any]()
                    requestParam["action"] = "showForumStatus"
                    requestParam["postId"] = postId
                    executeTask(self.url_server!, requestParam) { (data, response, error) in
                        if error == nil {
                            if data != nil {
                                print("input: \(String(data: data!, encoding: .utf8)!)")
                                if let result = try? JSONDecoder().decode(Int.self, from: data!) {
                                    print("resultShowForumStatus: \(result)")
                                    post.status = result
                                    DispatchQueue.main.async {
                                        if let control = self.tableView.refreshControl {
                                            if control.isRefreshing {
                                                control.endRefreshing()
                                            }
                                        }
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            alert.addAction(cancel)
            alert.addAction(confirm)
            self.present(alert, animated: true, completion: nil)
        }
        show.backgroundColor = .green
        
        let swipeActions = UISwipeActionsConfiguration(actions: [hide, show])
        
        swipeActions.performsFirstActionWithFullSwipe = false
        return swipeActions
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "ForumTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! ForumCell
        
        let post = postList[indexPath.row]
        
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
                            cell.lbReplyCount.text = String(result)
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
                            cell.lbDate.text = result
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
                            cell.lbNickname.text = result
                        }
                    }
                }
            }
        }
        
        if let status = post.status {
            if status == 0 {
                cell.lbStatus.text = "正常"
                cell.lbStatus.textColor = .blue
            } else {
                cell.lbStatus.text = "隱藏"
                cell.lbStatus.textColor = .red
            }
        }
        
        cell.lbTitle.text = post.title
        cell.lbType.text = post.type
        cell.lbDate.text = post.dataStr
        cell.lbContent.text = post.content
        cell.lbLikeCount.text = String(post.like_count!)
        return cell
    }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PostReviewSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let post = postList[indexPath!.row]
            let postViewVC = segue.destination as! ForumVC
            postViewVC.post = post
        }
    }
}
