//
//  ContentService.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//

import Foundation
import Alamofire
import Factory

class ContentService {
    @Injected(ClientContainer.client) var repository
    
    func getListContent(completion: @escaping(_: ApiResult<[ContentListResponse]>) -> Void){
        repository.getListContent(completion: completion)
    }
}
