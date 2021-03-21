//
//  CertificateTVC.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/16.
//

import UIKit
import Foundation

class CertificateTVC: UITableViewController {
    let url_server = URL(string: common_url + "Homepage")
    var certificateList = [Certificate]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        var requestParam = [String: String]()
        requestParam["action"] =  "getAllCertificate"
        executeTask(url_server!, requestParam) { (data, respond, error) in
            let decoder = JSONDecoder()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(format)
            if error == nil {
                if data != nil {
                    print("input \(String(data: data!, encoding: .utf8)!)")

                    if let result = try? decoder.decode([Certificate].self, from: data!) {
                        self.certificateList = result
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
        requestParam["action"] =  "getAllCertificate"
        executeTask(url_server!, requestParam) { (data, respond, error) in
            let decoder = JSONDecoder()
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(format)
            if error == nil {
                if data != nil {
                    print("input \(String(data: data!, encoding: .utf8)!)")

                    if let result = try? decoder.decode([Certificate].self, from: data!) {
                        self.certificateList = result
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
        let cellId = "CertificateTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! CertificateCell
        
        let certificate = certificateList[indexPath.row]
        var requestParam = [String: Any]()
        
        requestParam["action"] = "getMemberStatus"
        requestParam["memberId"] = certificate.member_id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(Int.self, from: data!) {
                        print("resultMemberStatus: \(result)")
                                     
                        var status: String?
                        
                        if result == 1 {
                            status = "未啟用"
                        } else if result == 2 {
                            status = "一般會員"
                        } else if result == 3 {
                            status = "保母會員"
                        } else if result == 5 {
                            status = "停權"
                        } else if result == 6 {
                            status = "審核中保母"
                        }
                        
                        print("status: \(String(describing: status))")
                        
                        DispatchQueue.main.async {
                            cell.lbStatus.text = status!
                        }
                    }
                }
            }
        }
        
        requestParam["action"] = "getCertificateImage"
        requestParam["certificateId"] = certificate.id
        requestParam["imageSize"] = cell.ivCertificate.frame.height
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
                    cell.ivCertificate.image = image
                }
            } else {
                print(error!.localizedDescription)
            }
        }
        
        requestParam["action"] = "getMemberNickname"
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultMemberNickname: \(result)")
                        DispatchQueue.main.async {
                            cell.lbMemberNickname.text = result
                        }
                    }
                }
            }
        }

        requestParam["action"] = "getMemberBabysitterName"
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultMemberBabysitterName: \(result)")
                        DispatchQueue.main.async {
                            cell.lbBabysitterName.text = result
                        }
                    }
                }
            }
        }
        
        requestParam["action"] = "getCertificateUploadDate"
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(String.self, from: data!) {
                        print("resultCertificateUploadDate: \(result)")
                        DispatchQueue.main.async {
                            cell.lbRegisterDate.text = result
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
        return certificateList.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CertificateSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let certificate = certificateList[indexPath!.row]
            let certificateVC = segue.destination as! CertificateVC
            certificateVC.certificate = certificate
            print("certificateVC.certificate      \(String(describing: certificateVC.certificate))")
            print("certificateVC.certificate?.member_id     \(String(describing: certificateVC.certificate?.member_id))")
            
            
        }
    }
}
