//
//  apiErrorDtoParser.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//

import Alamofire
import Foundation

struct ApiErrorDtoParser {
    func parse(_ data: Data?) -> ApiErrorDto {
        if let dataError = data {
            do {
                return try JSONDecoder().decode(ApiErrorDto.self, from: dataError)
            } catch {
                return .responseParseError
            }
        }
        
        return .unhandledError
    }
}
