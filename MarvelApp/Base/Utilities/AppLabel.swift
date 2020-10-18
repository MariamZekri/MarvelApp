//
//  AppLabel.swift
//  MarvelApp
//
//  Created by Mariam Abdelhamid on 10/18/20.
//  Copyright © 2020 Marvel. All rights reserved.
//

import Foundation

import Foundation
import UIKit

//TODO:- add any custome lbl here this class to give label font and size .

//MARK:- MyAppTitleLabel.
class MyAppTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpButton()
    }
    private func setUpButton(){
        font = MyAppFonts.TILELBLFont
        textColor = #colorLiteral(red: 0.262745098, green: 0.2901960784, blue: 0.3294117647, alpha: 1)
    }
}
