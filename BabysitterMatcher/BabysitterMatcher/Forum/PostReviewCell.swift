//
//  PostReviewCell.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/15.
//

import UIKit

class PostReviewCell: UITableViewCell {

    @IBOutlet weak var lbNickname: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
