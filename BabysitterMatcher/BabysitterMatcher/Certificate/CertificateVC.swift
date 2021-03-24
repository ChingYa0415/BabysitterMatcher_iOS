//
//  CertificateReviewVC.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/17.
//

import UIKit
import Foundation

class CertificateVC: UIViewController {
    
    @IBOutlet weak var ivMember: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var lbGender: UILabel!
    @IBOutlet weak var lbCellphone: UILabel!
    @IBOutlet weak var lbSeniority: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbDistrict: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var lbCharge: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbCapacity: UILabel!
    @IBOutlet weak var ivCertificate: UIImageView!
    @IBAction func byQualified(_ sender: Any) {
        setCertificateQualified()
        setBabysitter()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btUnqualified(_ sender: Any) {
        setCertificateUnqualified()
        setBabysitter()
        self.navigationController?.popViewController(animated: true)
    }
    
    let url_server = URL(string: common_url + "Homepage")
    var babysitter: Babysitter?
    var babysitterList = [Babysitter]()
    var certificate: Certificate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("self.certificate?.member_id \(String(describing: self.certificate?.member_id))")
        
        var requestParam = [String: Any]()
        requestParam["action"] = "getBabysitter"
        requestParam["memberId"] = self.certificate.member_id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    do {
                        let result = try JSONDecoder().decode(Babysitter.self, from: data!)
                        print("resultBabysitter: \(String(describing: result))")
                        self.babysitter = result
                        DispatchQueue.main.async {
                            self.lbName.text = self.babysitter?.name
                            self.lbAge.text = String((self.babysitter?.age)!)
                            self.lbGender.text = String((self.babysitter?.gender)!)
                            self.lbCellphone.text = self.babysitter?.cellphone
                            if self.babysitter?.seniority == 1 {
                                self.lbSeniority.text = "5年以下"
                            } else if self.babysitter?.seniority == 2 {
                                self.lbSeniority.text = "5~10年"
                            } else if self.babysitter?.seniority == 3 {
                                self.lbSeniority.text = "10年以上"
                            }
                            self.lbCity.text = self.babysitter?.city
                            self.lbDistrict.text = self.babysitter?.district
                            self.lbAddress.text = self.babysitter?.address
                            self.lbCharge.text = self.babysitter?.charge
                            self.lbCapacity.text = String((self.babysitter?.capacity)!)
                        }
                    } catch let err {
                        print("error \(err)")
                    }
                }
            }
        }
        
        requestParam["action"] = "getMemberStatus"
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(Int.self, from: data!) {
                        
                        DispatchQueue.main.async {
                            
                            print("resultName: \(result)")
                                         
                            var status: String?
                            if result == 1 {
                                status = "未啟用"
                                self.lbStatus.textColor = .gray
                            } else if result == 2 {
                                status = "一般會員"
                                self.lbStatus.textColor = .blue

                            } else if result == 3 {
                                status = "保母會員"
                                self.lbStatus.textColor = .blue

                            } else if result == 5 {
                                status = "停權"
                                self.lbStatus.textColor = .red

                            } else if result == 6 {
                                status = "審核中保母"
                                self.lbStatus.textColor = .blue

                            }
                            print("status: \(String(describing: status))")
                            
                            self.lbStatus.text = status!
                        }
                    }
                }
            }
        }
        
        requestParam["action"] = "getBabysitterMemberImage"
        requestParam["id"] = self.certificate.member_id
        requestParam["imageSize"] = self.ivMember.frame.height
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
        
        requestParam["action"] = "getCertificateImage"
        requestParam["certificateId"] = self.certificate.id
        requestParam["imageSize"] = self.ivCertificate.frame.height
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    image = UIImage(data: data!)
                }
                if image == nil {
                    image = UIImage(named: "noImage.jpg")
                }
                DispatchQueue.main.async {
                    self.ivCertificate.image = image
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func setBabysitter() {
        var requestParam = [String: Any]()
        requestParam["action"] = "getBabysitter"
        requestParam["memberId"] = self.certificate.member_id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    do {
                        let result = try JSONDecoder().decode(Babysitter.self, from: data!)
                        print("resultBabysitter: \(String(describing: result))")
                        self.babysitter = result
                        DispatchQueue.main.async {
                            var status: String?
                            
                            if self.babysitter?.status == 1 {
                                status = "未啟用"
                            } else if self.babysitter?.status == 2 {
                                status = "一般"
                            } else if self.babysitter?.status == 3 {
                                status = "保母"
                            } else if self.babysitter?.status == 4 {
                                status = "管理者"
                            } else if self.babysitter?.status == 5 {
                                status = "停權"
                            } else if self.babysitter?.status == 6 {
                                status = "審核中保母"
                            }
                            
                            self.lbStatus.text = status!
                            
                            self.lbName.text = self.babysitter?.name
                            self.lbAge.text = String((self.babysitter?.age)!)
                            self.lbGender.text = String((self.babysitter?.gender)!)
                            self.lbCellphone.text = self.babysitter?.cellphone
                            self.lbSeniority.text = String((self.babysitter?.seniority)!)
                            self.lbCity.text = self.babysitter?.city
                            self.lbDistrict.text = self.babysitter?.district
                            self.lbAddress.text = self.babysitter?.address
                            self.lbCharge.text = self.babysitter?.charge
                            self.lbCapacity.text = String((self.babysitter?.capacity)!)
                        }
                    } catch let err {
                        print("error \(err)")
                    }
                }
            }
        }
        
        requestParam["action"] = "getMemberStatus"
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(Int.self, from: data!) {
                        print("resultName: \(result)")
                                     
                        var status: String?
                        if result == 1 {
                            status = "未啟用"
                        } else if result == 2 {
                            status = "一般"
                        } else if result == 3 {
                            status = "保母"
                        } else if result == 4 {
                            status = "管理者"
                        } else if result == 5 {
                            status = "停權"
                        } else if result == 6 {
                            status = "審核中保母"
                        }
                        print("status: \(String(describing: status))")
                        
                        DispatchQueue.main.async {
                            self.lbStatus.text = status!
                        }
                    }
                }
            }
        }
    }
    
    func setCertificateQualified() {
        var requestParam = [String: Any]()
        requestParam["action"] = "setCertificateQualified"
        requestParam["memberId"] = self.certificate.member_id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(Int.self, from: data!) {
                        if result == 1 {
                            print("證照審核通過及發出通知！")
                        } else {
                            print("證照審核失敗且有通知！")
                        }
                    }
                }
            }
        }
    }
    
    func setCertificateUnqualified() {
        var requestParam = [String: Any]()
        requestParam["action"] = "setCertificateUnqualified"
        requestParam["memberId"] = self.certificate.member_id
        executeTask(url_server!, requestParam) { (data, response, error) in
            if error == nil {
                if data != nil {
                    print("input: \(String(data: data!, encoding: .utf8)!)")
                    if let result = try? JSONDecoder().decode(Int.self, from: data!) {
                        print("resultsetCertificateUnqualified: \(String(describing: result))")
                    }
                }
            }
        }
    }
}
