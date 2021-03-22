//
//  MemberTVC.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/19.
//

import UIKit

class MemberTVC: UITableViewController {
    let url_server = URL(string: common_url + "Homepage")
    var memberList = [Member]()
    var imageData: Data?
    
    override func viewWillAppear(_ animated: Bool) {
        var requestParam = [String: String]()
        requestParam["action"] = "getAllMembers"
        executeTask(url_server!, requestParam) { (data, respond, error) in
            let decoder = JSONDecoder()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(format)
            if error == nil {
                if data != nil {
                    print("input \(String(data: data!, encoding: .utf8)!)")
                    
                    if let result = try? decoder.decode([Member].self, from: data!) {
                        self.memberList = result
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
        requestParam["action"] = "getAllMembers"
        executeTask(url_server!, requestParam) { (data, respond, error) in
            let decoder = JSONDecoder()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(format)
            if error == nil {
                if data != nil {
                    print("input \(String(data: data!, encoding: .utf8)!)")
                    
                    if let result = try? decoder.decode([Member].self, from: data!) {
                        self.memberList = result
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "MemberCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemberCell
        
        let member = memberList[indexPath.row]
        
        var requestParam = [String: Any]()

        cell.lbAccount.text = member.account
        cell.lbNickname.text = member.nickname
        
        if member.status == 1 {
            cell.lbStatus.text = "未啟用"
            cell.lbStatus.textColor = .gray
        } else if member.status == 2 {
            cell.lbStatus.text = "一般會員"
            cell.lbStatus.textColor = .blue
        } else if member.status == 3 {
            cell.lbStatus.text = "保母會員"
            cell.lbStatus.textColor = .blue
        } else if member.status == 5 {
            cell.lbStatus.text = "停權"
            cell.lbStatus.textColor = .red
        } else if member.status == 6 {
            cell.lbStatus.text = "審核中保母"
            cell.lbStatus.textColor = .blue
        }
        
        requestParam["action"] = "getMemberRegisterDate"
        requestParam["id"] = member.id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultNickname: \(result)")
                        DispatchQueue.main.async {
                            cell.lbRegisterDate.text = result
                        }
                    }
                }
            }
        }
        
        requestParam["action"] = "getMemberImage"
        requestParam["imageSize"] = cell.ivMember.frame.height
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
                    cell.ivMember.image = image
                }
            } else {
                print(error!.localizedDescription)
            }
        
        }
        
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberList.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemberSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let member = memberList[indexPath!.row]
            let memberVC = segue.destination as! MemberVC
            memberVC.member = member
        }
    }

}
