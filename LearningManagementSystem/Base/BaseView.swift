//
//  BaseView.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//
import SwiftUI
import RxSwift
protocol BaseView: View {
    func initObserver()
    func loadData()
}

extension BaseView {

    func initEventListener() {
        
    }
    
    func initObserver() {
    }

    func loadData() {
    }
}
