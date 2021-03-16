//
//  ForumTableViewCell.swift
//  BabysitterMatcher
//
//  Created by Angus on 2021/3/15.
//

import UIKit

class ForumCell: UITableViewCell {

    
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbNickname: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var ivLike: UIImageView!
    @IBOutlet weak var lbLikeCount: UILabel!
    @IBOutlet weak var ivReply: UIImageView!
    @IBOutlet weak var lbReplyCount: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
