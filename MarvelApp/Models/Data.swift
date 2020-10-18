//
//  Data.swift
//  MarvelApp
//
//  Created by Mariam Abdelhamid on 10/18/20.
//  Copyright © 2020 Marvel. All rights reserved.
//

import Foundation

struct Data : Codable {
    let offset : Int?
    let limit : Int?
    let total : Int?
    let count : Int?
    let results : [Character]?
}
