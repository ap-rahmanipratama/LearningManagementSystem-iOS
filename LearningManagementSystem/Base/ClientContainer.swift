//
//  ClientContainer.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//
import Factory

class ClientContainer: SharedContainer {
    static let client = Factory(scope: .singleton) { ApiClient() }
}
