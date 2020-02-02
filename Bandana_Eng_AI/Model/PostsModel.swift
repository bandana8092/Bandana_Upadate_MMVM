//
//  PostsModel.swift
//  Bandana_Eng_AI
//
//  Created by satish pullagura on 02/02/20.
//  Copyright © 2020 Bandana. All rights reserved.
//

import Foundation

class Posts {
    var name = ""
    var createdDate = ""
    var isOn = false
    init(dictionary: [String: Any]) {
        if let name = dictionary[ServerKeys.keyTitle] {
            self.name = name as? String ?? ""
        }
        if let date = dictionary[ServerKeys.keyCreateDate] {
            self.createdDate = date as? String ?? ""
        }
    }
    public class func modelFromDictionaryArray(array: [[String: Any]]) -> [Posts] {
        var items = [Posts]()
        for data in array {
            items.append(Posts.init(dictionary: data))
        }
        return items
    }
}
