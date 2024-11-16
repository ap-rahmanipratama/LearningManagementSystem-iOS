//
//  ViewModelContainer.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//

import Factory

class ViewModelContainer: SharedContainer {
    static let listContentVm = Factory(scope: .singleton) { ListContentVm() }
}
