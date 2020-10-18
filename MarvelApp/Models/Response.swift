//
//  Response.swift
//  MarvelApp
//
//  Created by Mariam Abdelhamid on 10/18/20.
//  Copyright © 2020 Marvel. All rights reserved.
//

import Foundation

struct Response : Codable {
    let code : Int?
    let status : String?
    let copyright : String?
    let attributionText : String?
    let attributionHTML : String?
    let etag : String?
    let data : Data?
}
