//
//  Cache.swift
//  LearningManagementSystem
//
//  Created by Rahman on 19/11/24.
//

import Factory
import Foundation

class Cache {
    @Injected(CommonContainer.userDefaults) private var userDefaults
    
    enum Key: String {
        case contentList = "contentlist"
    }
    
    func getString(_ key: Key, defaultValue: String = "") -> String {
        return userDefaults.value(forKey: key.rawValue) as? String ?? defaultValue
    }
    
    func setString(_ value: String, for key: Key) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func getData(_ key: Key) -> Data? {
        return userDefaults.value(forKey: key.rawValue) as? Data
    }
    
    func setData<T>(_ value: T, for key: Key) where T: Encodable {
        do {
            userDefaults.set(try PropertyListEncoder().encode(value), forKey: key.rawValue)
        } catch (_) {
            
        }
    }
    
    func removeData(_ key: Key) {
        return userDefaults.removeObject(forKey: key.rawValue)
    }
    
}

extension Cache {
    
    func setContentListCache(_ data: [ContentViewData]) {
        setData(data, for: .contentList)
    }
    
    func getContentListCache() -> [ContentViewData]? {
        if let data = getData(.contentList)  {
            let userData = try? PropertyListDecoder().decode([ContentViewData].self, from: data)
            return userData
        } else {
            return []
        }
    }
}
