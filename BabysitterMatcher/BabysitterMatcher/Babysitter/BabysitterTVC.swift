//
//  BabysitterTVC.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/21.
//

import UIKit

class BabysitterTVC: UITableViewController {
    let url_server = URL(string: common_url + "Homepage")
    var babysitterList = [Babysitter]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var requestParam = [String: String]()
        requestParam["action"] = "getAllBabysitter"
        print("action getAllBabysitter")
        executeTask(url_server!, requestParam) { (data, respond, error) in
            let decoder = JSONDecoder()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(format)
            if error == nil {
                if data != nil {
                    print("inputAllBabysitter \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? decoder.decode([Babysitter].self, from: data!) {
                        print("resultAllBabysitter: \(result)")
                        self.babysitterList = result
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
        let cellId = "BabysitterCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! BabysitterCell
        
        let babysitter = babysitterList[indexPath.row]
        
        cell.lbBabysitterName.text = babysitter.name
        cell.lbBabysitterOccupied.text = String((babysitter.occupied)!)
        
        var requestParam = [String: Any]()

        if babysitter.status == 1 {
            cell.lbBabysitterStatus.text = "可收托"
            cell.lbBabysitterStatus.textColor = .blue
        } else if babysitter.status == 2 {
            cell.lbBabysitterStatus.text = "已額滿"
            cell.lbBabysitterStatus.textColor = .red
        } else if babysitter.status == 3 {
            cell.lbBabysitterStatus.text = "停止收托"
            cell.lbBabysitterStatus.textColor = .gray
        }
        
        requestParam["action"] = "getBabysitterMemberImage"
        requestParam["id"] = babysitter.id
        requestParam["imageSize"] = cell.ivBabysitter.frame.height
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
                    cell.ivBabysitter.image = image
                }
            } else {
                print(error!.localizedDescription)
            }
        }
        
        requestParam["action"] = "getBabysitterLastUpdateTime"
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultNickname: \(result)")
                        DispatchQueue.main.async {
                            cell.lbBabysitterLastUpdateTime.text = result
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
        return babysitterList.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BabysitterSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let babysitter = babysitterList[indexPath!.row]
            let BabysitterVC = segue.destination as! BabysitterVC
            BabysitterVC.babysitter = babysitter
        }
    }

}
