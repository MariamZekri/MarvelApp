//
//  AppDelegate.swift
//  MarvelApp
//
//  Created by Mariam Abdelhamid on 10/18/20.
//  Copyright © 2020 Marvel. All rights reserved.
//

import Foundation
import UIKit

//MARK:- UINavigationBar
extension UINavigationBar{
    
    class func setNavigationBar() {
        
        appearance().setBackgroundImage(UIImage(), for: .default)
        appearance().shadowImage = UIImage()
        appearance().barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.262745098, green: 0.2901960784, blue: 0.3294117647, alpha: 1), NSAttributedString.Key.font: MyAppFonts.BarTITLEFont!]
       }
}
