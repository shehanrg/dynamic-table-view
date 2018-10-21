//
//  Item.swift
//  DynamicTableView
//
//  Created by SHEHAN on 10/20/18.
//  Copyright © 2018 Shehan Gunarathne. All rights reserved.
//

import UIKit
import Foundation

struct Item{
    var title: String
    var description: String
    var image: URL
    
    init?(JSONData data:[String:String]) {
        guard let title = data["title"] else { return nil }
        self.title = title
        guard let description = data["description"] else { return nil }
        self.description = description
        guard let imageUrlString = data["image"] else { return nil }
        guard let imageUrl = URL(string: imageUrlString) else { return nil }
        self.image = imageUrl
    }
}
