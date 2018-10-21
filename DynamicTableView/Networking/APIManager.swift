//
//  APIManager.swift
//  DynamicTableView
//
//  Created by SHEHAN on 10/20/18.
//  Copyright © 2018 Shehan Gunarathne. All rights reserved.
//

import UIKit
import Alamofire

class APIManager: NSObject {
    let baseURL = "https://gist.githubusercontent.com/ashwini9241/6e0f26312ddc1e502e9d280806eed8bc/raw/7fab0cf3177f17ec4acd6a2092fc7c0f6bba9e1f/saltside-json-data"
    
    static let sharedInstance = APIManager()
    
    func getData(onSuccess:@escaping([Item]) -> Void, onFailure:@escaping(String) -> Void){
        let url = baseURL
        Alamofire.request(url,
                          method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    if let error = response.result.error {
                        onFailure("Something went wrong, Error: \(error.localizedDescription)") //For testing purpose
                        return
                    } else {
                        onFailure("Oops! Something went wrong!")
                        return
                    }
                }
                
                guard let itemArray = response.result.value as? [[String:String]] else {
                    print("Data error")
                    onFailure("Oops! Something wrong with our data, please try again!")
                    return
                }
                
                let items = itemArray.compactMap { itemDict in return Item(JSONData: itemDict) }
                onSuccess(items)
                
        }
    }

}
