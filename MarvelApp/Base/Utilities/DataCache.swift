//
//  DataCache.swift
//  MarvelApp
//
//  Created by Mariam Abdelhamid on 10/20/20.
//  Copyright © 2020 Marvel. All rights reserved.
//

import Foundation
import Cache

class DataCache {
    static let shared = DataCache()
    let diskConfig = DiskConfig(
        // The name of disk storage, this will be used as folder name within directory
        name: "Heroes",
        // Expiry date that will be applied by default for every added object
        // if it's not overridden in the `setObject(forKey:expiry:)` method
        expiry: .never,
        // Maximum size of the disk cache storage (in bytes)
        maxSize: 50000,
        // Where to store the disk cache. If nil, it is placed in `cachesDirectory` directory.
        directory: try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                                appropriateFor: nil, create: true).appendingPathComponent("HeroesPreferences"),
        // Data protection is used to store files in an encrypted format on disk and to decrypt them on demand
        protectionType: .complete
    )
    private init() {}
    lazy var dataStorage = try! Storage (
        diskConfig: diskConfig,
        memoryConfig: MemoryConfig(),
        transformer: TransformerFactory.forData()
    )
    
}

extension DataCache {
    func setDataObject(_ data: Data, key: String, _expiry: TimeInterval) {
        try! dataStorage.setObject(data, forKey: key, expiry: .seconds(_expiry))
    }
    
    func getDataObject(key: String) -> Data? {
        return try? dataStorage.object(forKey: key)
    }
    
}
