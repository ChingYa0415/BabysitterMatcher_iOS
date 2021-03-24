//
//  RequirementFormTVC.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/18.
//

import UIKit

class RequirementFormTVC: UITableViewController {
    let url_server = URL(string: common_url + "Homepage")
    var requirementFormList = [RequirementForm]()
    
    override func viewDidAppear(_ animated: Bool) {
        
        var requestParam = [String: String]()
        requestParam["action"] =  "getAllRequirementForm"
        
        executeTask(url_server!, requestParam) { (data, respond, error) in
            let decoder = JSONDecoder()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(format)
            if error == nil {
                if data != nil {
                    print("input \(String(data: data!, encoding: .utf8)!)")
                    
                    if let result = try? decoder.decode([RequirementForm].self, from: data!) {
                        self.requirementFormList = result
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } else {
                print(error!.localizedDescription)
            }
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var requestParam = [String: String]()
        requestParam["action"] =  "getAllRequirementForm"
        
        executeTask(url_server!, requestParam) { (data, respond, error) in
            let decoder = JSONDecoder()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(format)
            if error == nil {
                if data != nil {
                    print("input \(String(data: data!, encoding: .utf8)!)")
                    
                    if let result = try? decoder.decode([RequirementForm].self, from: data!) {
                        self.requirementFormList = result
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
        let cellId = "RequirementFormCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! RequirementFormCell
        
        let requirementForm = requirementFormList[indexPath.row]
        
        if let visibility = requirementForm.visibility {
            if visibility == 1 {
                cell.lbVisibility.text = "正常"
                cell.lbVisibility.textColor = .blue
            } else {
                cell.lbVisibility.text = "隱藏"
                cell.lbVisibility.textColor = .red
            }
        }
        
        var requestParam = [String: Any]()
        requestParam["action"] = "getMemberImage"
        requestParam["imageSize"] = cell.ivMember.frame.height
        requestParam["id"] = requirementForm.member_id
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
        
        cell.lbRequirementFormId.text = String(requirementForm.id!)
        
        if let status = requirementForm.status {
            if status == 1 {
                cell.lbStatus.text = "未承接"
            } else if status == 2 {
                cell.lbStatus.text = "已承接"
            }
        }
        
        requestParam["action"] = "getMemberNickname"
        requestParam["memberId"] = requirementForm.member_id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultNickname: \(result)")
                        DispatchQueue.main.async {
                            cell.lbMemberNickname.text = result
                        }
                    }
                }
            }
        }
        return cell
    }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requirementFormList.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RequirementFormVCSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let requirementForm = requirementFormList[indexPath!.row]
            let requirementFormVC = segue.destination as! RequirementFormVC
            requirementFormVC.requirementForm = requirementForm
        }
    }
}
