//
//  Character.swift
//  MarvelApp
//
//  Created by Mariam Abdelhamid on 10/18/20.
//  Copyright © 2020 Marvel. All rights reserved.
//

import Foundation

struct Character : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let modified : String?
    let thumbnail : Thumbnail?
    let resourceURI : String?
    let comics : Comic?
//    let series : Serie?
//    let stories : Storie?
//    let events : Event?
    let urls : [Url]?
}

struct Comic : Codable {
    let available : Int?
    let collectionURI : String?
    let items : [Item]?
    let returned : Int?
}

struct Item : Codable {
    let resourceURI : String?
    let name : String?
}

struct Thumbnail : Codable {
let path : String?
let thumbnailExtension : String?

enum CodingKeys: String, CodingKey {

    case path = "path"
    case thumbnailExtension = "extension"
}
}

