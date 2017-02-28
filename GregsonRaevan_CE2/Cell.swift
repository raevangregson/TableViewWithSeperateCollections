//
//  Cell.swift
//  GregsonRaevan_CE2
//
//  Created by Raevan Gregson on 11/29/16.
//  Copyright © 2016 Raevan Gregson. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
