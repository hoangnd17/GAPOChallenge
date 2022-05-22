//
//  NotificationItemCell.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/22/22.
//

import UIKit

class NotificationItemCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var timeStampLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ viewModel: NotificationItemViewModel) {
        messageLabel.text = viewModel.text
        timeStampLabel.text = viewModel.timestamp
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
