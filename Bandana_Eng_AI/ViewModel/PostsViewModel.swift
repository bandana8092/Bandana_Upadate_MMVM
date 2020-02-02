//
//  PostssViewModel.swift
//  Bandana_Eng_AI
//
//  Created by satish pullagura on 02/02/20.
//  Copyright © 2020 Bandana. All rights reserved.
//

import Foundation

class PostsViewModel {
    var posts: [Posts] = [Posts]()
    var pageNo = 1
    var totalPageNo = 1
    var selectedPostsCount = 0
    func fetch(completion: @escaping () -> Void) {
        ServiceManager.shared.fetchPostssWith(pageNo: pageNo,
        totalPageNo: totalPageNo, compltionHandler: { (serverData, status) in
            switch status {
            case .success:
                let posts = serverData?[ServerKeys.keyHits] as? [Any]
                self.totalPageNo = serverData?[ServerKeys.keyTotalpage] as? Int ?? 0
                let initialPostss = Posts.modelFromDictionaryArray(array: posts as? [[String: Any]] ?? [["": ""]])
                self.posts = self.pageNo == 1 ? initialPostss : self.posts + initialPostss
            case .failed:
                print("display a failed alert")
            case .badResponse:
                print("display a bad response alert")
            }
            completion()
        })
    }
}
