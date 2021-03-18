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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberList.count
    }

    

}
