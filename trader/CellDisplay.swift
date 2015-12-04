//
//  CellDisplay.swift
//  trader
//
//  Created by Xi Zhang on 11/30/15.
//  Copyright © 2015 minor. All rights reserved.
//

import UIKit

class CellDisplay: UITableViewCell {
    
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemBuyoutPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
