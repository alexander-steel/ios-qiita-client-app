//
//  QiitaItemTableViewCell.swift
//  ios-qiita-client-app
//
//  Created by steel on 2022/02/07.
//

import UIKit

class QiitaItemTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var idLabel: UILabel!

    @IBOutlet var thumbnail: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
