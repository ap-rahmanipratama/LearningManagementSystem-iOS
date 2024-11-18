//
//  CommonContainer.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//
import Factory
import Foundation

class CommonContainer: SharedContainer {
    static let apiErrorDtoParser = Factory(scope: .singleton) { ApiErrorDtoParser() }
    static let userDefaults = Factory(scope: .singleton) { UserDefaults.standard }
    static let cache = Factory(scope: .singleton) { Cache() }

}
