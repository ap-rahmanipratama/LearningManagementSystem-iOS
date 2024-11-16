//
//  ServiceContainer.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//
import Factory

class ServiceContainer: SharedContainer {
    static let contentService = Factory(scope: .singleton) { ContentService() }
}
