//
//  ContentClient.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//

import Alamofire

extension ApiClient {

    func getListContent(completion: @escaping(ApiResult<[ContentListResponse]>) -> ()) {
        let _ = get(url: "\(baseUrl)/native-technical-exam/playlist.json", responseType: [ContentListResponse].self, onComplete: completion)
    }
}
