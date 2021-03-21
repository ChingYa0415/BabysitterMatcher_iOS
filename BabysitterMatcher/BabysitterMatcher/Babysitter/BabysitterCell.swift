//
//  BabysitterCell.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/21.
//

import UIKit

class BabysitterCell: UITableViewCell {

    @IBOutlet weak var lbBabysitterStatus: UILabel!
    @IBOutlet weak var ivBabysitter: UIImageView!
    @IBOutlet weak var lbBabysitterName: UILabel!
    @IBOutlet weak var lbBabysitterOccupied: UILabel!
    @IBOutlet weak var lbBabysitterLastUpdateTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
