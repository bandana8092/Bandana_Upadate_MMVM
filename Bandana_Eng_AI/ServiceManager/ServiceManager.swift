//
//  ServiceManager.swift
//  Bandana_Eng_AI
//
//  Created by satish pullagura on 02/02/20.
//  Copyright © 2020 Bandana. All rights reserved.
//

import UIKit

class ServiceManager: NSObject {
    static let shared = ServiceManager()
    func fetchPostssWith(pageNo: Int, totalPageNo: Int, compltionHandler: @escaping([String: Any]?,
        ResponseStatus) -> Void) {
        let url =  baseURL + "\(pageNo)"
        print(url)
        let task = URLSession.shared.dataTask(with: NSURL(string: baseURL + "\(pageNo)")! as URL,
            completionHandler: { (data, _, error) -> Void in
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data!,
                                options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                guard let itemsData = jsonResponse else {
                    compltionHandler(nil, .badResponse)
                    return
                }
                compltionHandler(itemsData, .success)
            } catch {
                print("json error: \(error)")
                compltionHandler(nil, .failed)
            }
        })
        task.resume()
    }
}
