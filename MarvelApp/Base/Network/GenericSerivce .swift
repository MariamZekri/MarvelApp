//
//  GenericSerivce .swift
//  MarvelApp
//
//  Created by Mariam Abdelhamid on 10/18/20.
//  Copyright © 2020 Marvel. All rights reserved.
//

import Foundation

class RemoteRepository {
    
    let apikey = "a4e90402bf004d35adce79816b39852f"
    let privateKey = "7ddf65fac4564eb1c1a26565f1feee77e98a33fe"
    let timeStamp = "1"
    let limit = "100"
    lazy var hash = (timeStamp+privateKey+apikey).md5()
    lazy var query: [String: String] = [
        "limit" : limit,
        "ts" : timeStamp,
        "apikey": apikey,
        "hash": hash
    ]
    
    func fetchCharacteres(completionHandler: @escaping ([Character]?) -> Void){
        
        let baseUrl = URL(string : "https://gateway.marvel.com:443/v1/public/characters?")!
        
        let fullUrl = baseUrl.withQueries(query)!
        URLSession.shared.dataTask(with: fullUrl) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let data = data else { print("Error, no data retrieved"); return }
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
}
