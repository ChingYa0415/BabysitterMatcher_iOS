//
//  RequirementFormCell.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/18.
//

import UIKit

class RequirementFormCell: UITableViewCell {

    @IBOutlet weak var lbVisibility: UILabel!
    @IBOutlet weak var ivMember: UIImageView!
    @IBOutlet weak var lbRequirementFormId: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbMemberNickname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
