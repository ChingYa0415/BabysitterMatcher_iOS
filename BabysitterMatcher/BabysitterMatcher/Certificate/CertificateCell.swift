//
//  CertificateCell.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/16.
//

import UIKit

class CertificateCell: UITableViewCell {

    @IBOutlet weak var ivCertificate: UIImageView!
    @IBOutlet weak var lbMemberNickname: UILabel!
    @IBOutlet weak var lbBabysitterName: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
