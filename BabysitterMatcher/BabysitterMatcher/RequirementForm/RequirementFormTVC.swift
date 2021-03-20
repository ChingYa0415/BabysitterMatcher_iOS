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
    
    override func viewWillAppear(_ animated: Bool) {
        
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

    /*
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let hide = UIContextualAction(style: .normal, title: "隱藏") { (action, view, bool) in
            let requirementForm = self.requirementFormList[indexPath.row]
            let alert = UIAlertController(title: "隱藏此需求單", message: "確認將此需求單隱藏嗎？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let confirm = UIAlertAction(title: "確認", style: .default) { (alertAction) in
                if let requirementFormId = requirementForm.id {
                    var requestParam = [String: Any]()
                    requestParam["action"] = "hideRequirementFormStatus"
                    requestParam["requirementFormId"] = requirementFormId
                    executeTask(self.url_server!, requestParam) { (data, response, error) in
                        if error == nil {
                            if data != nil {
                                print("input: \(String(data: data!, encoding: .utf8)!)")
                                if let result = try? JSONDecoder().decode(Int.self, from: data!) {
                                    print("resultHideRequirementFormStatus: \(result)")
                                    requirementForm.status = result
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
            let requirement = self.requirementFormList[indexPath.row]
            let alert = UIAlertController(title: "顯示此需求單", message: "確認將此需求單顯示嗎？", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let confirm = UIAlertAction(title: "確認", style: .default) {(alertAction) in
                if let requirementFormId = requirement.id {
                    var requestParam = [String: Any]()
                    requestParam["action"] = "showRequirementFormStatus"
                    requestParam["requirementFormId"] = requirementFormId
                    executeTask(self.url_server!, requestParam) { (data, response, error) in
                        if error == nil {
                            if data != nil {
                                print("input: \(String(data: data!, encoding: .utf8)!)")
                                if let result = try? JSONDecoder().decode(Int.self, from: data!) {
                                    print("resultShowRequirementFormStatus: \(result)")
                                    requirement.status = result
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
    */
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "RequirementFormCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! RequirementFormCell
        
        let requirementForm = requirementFormList[indexPath.row]
    
        var requestParam = [String: Any]()
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
        
        if let status = requirementForm.visibility {
            if status == 1 {
                cell.lbVisibility.text = "正常"
            } else {
                cell.lbVisibility.text = "隱藏"
            }
        }
        
        cell.lbRequirementFormId.text = String(requirementForm.id!)
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
