//
//  MemeCell.swift
//  MemeForge
//
//  Created by APPLE on 9/24/19.
//  Copyright © 2019 Bong. All rights reserved.
//

import UIKit

class MemeCell: UITableViewCell {

    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
