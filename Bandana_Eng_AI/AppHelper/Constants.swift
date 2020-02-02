//
//  Constants.swift
//  Bandana_Eng_AI
//
//  Created by satish pullagura on 02/02/20.
//  Copyright © 2020 Bandana. All rights reserved.
//

import Foundation
let baseURL = "https://hn.algolia.com/api/v1/search_by_date?tags=story&page="

struct ServerKeys {
    static let keyTitle = "title"
    static let keyHits = "hits"
    static let keyTotalpage = "nbPages"
    static let keyCreateDate = "created_at"
}

enum ResponseStatus: Error {
    case success
    case failed
    case badResponse
}
enum Destination {
    case bottom
    case center
}
