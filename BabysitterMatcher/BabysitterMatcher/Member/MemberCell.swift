//
//  MemberCell.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/19.
//

import UIKit

class MemberCell: UITableViewCell {

    @IBOutlet weak var ivMember: UIImageView!
    @IBOutlet weak var lbAccount: UILabel!
    @IBOutlet weak var lbNickname: UILabel!
    @IBOutlet weak var lbRegisterDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
