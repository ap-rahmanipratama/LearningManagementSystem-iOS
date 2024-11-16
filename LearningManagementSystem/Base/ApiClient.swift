//
//  HttpClient.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//

import Foundation
import Alamofire
import Factory

/// Base HTTP client. Use HttpClient.Builder().build() to create instance of this class
class ApiClient {
    @Injected(CommonContainer.apiErrorDtoParser) private var apiErrorDtoParser
    let baseUrl: String = {
        return "https://quipper.github.io"
    }()
    func get<T: Decodable>(url: String, responseType: T.Type, onComplete: @escaping (ApiResult<T>) -> (), timeout: Double = 60, encoding: ParameterEncoding = URLEncoding.queryString) -> DataRequest {
        
        return request(url: url, method: .get, param: nil, responseType: responseType, onComplete: onComplete, timeout: timeout, encoding: encoding)
    }
    
    func get<T: Decodable, U: Encodable>(url: String, param: U?, responseType: T.Type, onComplete: @escaping (ApiResult<T>) -> (), timeout: Double = 60, encoding: ParameterEncoding = URLEncoding.queryString) -> DataRequest {
        
        let param = objectToDict(data: param)
        return request(url: url, method: .get, param: param, responseType: responseType, onComplete: onComplete, timeout: timeout, encoding: encoding)
    }
    
    func get<T: Decodable>(url: String, param: [String:Any], responseType: T.Type, onComplete: @escaping (ApiResult<T>) -> (), timeout: Double = 60, encoding: ParameterEncoding = URLEncoding.queryString) -> DataRequest {
        return request(url: url, method: .get, param: param, responseType: responseType, onComplete: onComplete, encoding: encoding)
    }
    
    func request<T: Decodable>(url: String, method: HTTPMethod, param: [String:Any]?, responseType: T.Type, onComplete: @escaping (ApiResult<T>) -> (), timeout: Double = 60, encoding: ParameterEncoding = JSONEncoding.default) -> DataRequest {
        AF.sessionConfiguration.timeoutIntervalForRequest = timeout
        AF.sessionConfiguration.timeoutIntervalForResource = timeout
        let request = AF.request(url, method: method, parameters: param, encoding: encoding, headers: getDefaultHeaders())
            .validate(statusCode: 200...300)
            .responseDecodable(of: responseType) { dataResponse in
                Log.debug(dataResponse)
                if let result = self.responseDecodeableProcessor(data: dataResponse) {
                    onComplete(result)
                }
            }
        return request
    }
    
    private func responseDecodeableProcessor<T: Decodable>(data: DataResponse<T, AFError>) -> ApiResult<T>? {
        switch data.result {
            case .success(let result): return .success(result)
            case .failure(let afError): do {
                if afError.isSessionTaskError {
                    return .error(.connectionTimeout)
                } else if data.response?.statusCode == 401 {
                    return .error(.unAuthorizedError)
                }
                
                return .error(apiErrorDtoParser.parse(data.data))
            }
        }
    }
    
    private func objectToDict<T: Encodable>(data: T) -> [String:Any]? {
        do {
            let json = try JSONEncoder().encode(data)
            let dictResult = try JSONSerialization.jsonObject(with: json, options: []) as? [String:Any]
            return dictResult
        } catch {
            return nil
        }
    }
    
    private func getDefaultHeaders() -> HTTPHeaders {
        return [
           "Authorization": "Bearer ",
        ];
    }
    
    
}

class Log {
    static func print(_ msg: String) {
        #if DEBUG
            Swift.print(msg)
        #endif
    }
    
    static func debug(_ data: Any) {
        #if DEBUG
            debugPrint(data)
        #endif
    }
}
