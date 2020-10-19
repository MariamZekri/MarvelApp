//
//  SearchTableViewCell.swift
//  MarvelApp
//
//  Created by Mariam Abdelhamid on 10/19/20.
//  Copyright © 2020 Marvel. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var heroImg: UIImageView!
    @IBOutlet weak var heroNameLbl: MyAppLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setSearchData(obj: Character){
        heroNameLbl.text = obj.name
        let imageUrl : String  = (obj.thumbnail?.path)!
        let imageExtension : String  = (obj.thumbnail?.thumbnailExtension)!
           
           let imageFullPath = imageUrl+"."+imageExtension
           heroImg.downloaded(from: imageFullPath)

       }
}
