//
//  GenericSerivce .swift
//  MarvelApp
//
//  Created by Mariam Abdelhamid on 10/18/20.
//  Copyright © 2020 Marvel. All rights reserved.
//

import Foundation

class GenericService {
    
    let apikey = "a4e90402bf004d35adce79816b39852f"
    let privateKey = "7ddf65fac4564eb1c1a26565f1feee77e98a33fe"
    let timeStamp = "1"
    var query: [String: String] = [String: String]()
    lazy var hash = (timeStamp+privateKey+apikey).md5()
    let identifierName = "heroesCharacter"
    let baseUrl = URL(string : "https://gateway.marvel.com:443/v1/public/characters?")!
    
    
    func fetchCharacteres(isCacheable: Cacheable =  .no
        ,limit: Int,offset: Int ,completionHandler: @escaping ([Character]?) -> Void){
        
        query = [
            "limit" : "\(limit)",
            "ts" : timeStamp,
            "offset" : "\(offset)",
            "apikey": apikey,
            "hash": hash
        ]
        
        switch isCacheable {
        case .yes(let timetoLive):
            let expiry = timetoLive.time
            /// Get Data from offline cash
            if let dataJson = DataCache.shared.getDataObject(key: identifierName) , identifierName != "" {
                self.jsonParsing(identifierName, data: dataJson, identifier: identifierName, expiry: 0.0, completion: completionHandler)
            } else {
                fetchHeroesCharacteres(isCacheable: isCacheable,identifier: identifierName,
                                       expiry: expiry, completionHandler: completionHandler)
            }
        case .no:
            fetchHeroesCharacteres(isCacheable: isCacheable, identifier: identifierName,
                                   expiry: 0.0,completionHandler: completionHandler)
        }
        
        
    }
    
    func fetchHeroesCharacteres(isCacheable: Cacheable,identifier: String,
                                expiry: TimeInterval,completionHandler: @escaping ([Character]?) -> Void){
        
        let fullUrl = baseUrl.withQueries(query)!
        URLSession.shared.dataTask(with: fullUrl) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let data = data else { print("Error, no data retrieved"); return }
            if expiry != 0.0 {
                DataCache.shared.setDataObject(data, key: identifier, _expiry: expiry)
            }
            guard let charactersResponse =
                try? decoder.decode(Response.self, from: data)
                else{
                    print("Error, could not parse data")
                    completionHandler(nil)
                    return
            }
            completionHandler(charactersResponse.data?.results)
        }.resume()
    }
    
    
    
    func jsonParsing(_ url: String,
                     data: Data,
                     identifier: String,
                     expiry: TimeInterval,
                     completion: ([Character]?)->Void) {
        
        do {
            let decoder = JSONDecoder()
            /// add cache
            if expiry != 0.0 {
                DataCache.shared.setDataObject(data, key: identifier, _expiry: expiry)
            }
            let model = try decoder.decode([Character].self, from: data)
            completion(model)
        } catch _ {
            // return decoding failed
            completion(nil)
            
        }
        
    }
}
