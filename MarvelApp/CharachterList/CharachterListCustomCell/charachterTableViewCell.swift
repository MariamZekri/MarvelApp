//
//  charachterTableViewCell.swift
//  MarvelApp
//
//  Created by Mariam Abdelhamid on 10/18/20.
//  Copyright © 2020 Marvel. All rights reserved.
//

import UIKit

class charachterTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var heroImg: UIImageView!
    @IBOutlet weak var heroNameLbl: MyAppTitleLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
