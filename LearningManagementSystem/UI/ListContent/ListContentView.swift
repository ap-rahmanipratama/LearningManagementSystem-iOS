//
//  ListContentView.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//

import SwiftUI
import Factory
import RxSwift

struct ListContentView: BaseView {
    
    @Injected(ViewModelContainer.listContentVm) var viewModel
  
    @State var data: [ListContentViewData] = []
    
    var body: some View {
        NavigationView {
            List(data, id: \.self) { item in
                ListContentCell(contentData: item)
                .listRowSeparator(.hidden)
            }.contentMargins(.horizontal, 0)
            .navigationTitle("Courses")
        }
        .onAppear {
            self.initObserver()
            self.loadData()
        }
    }
    
    func initObserver() {
        viewModel.liveGetListContentSuccess.subscribe(
            onNext: {  viewdata in
                self.data = viewdata
            }
        )
    }
    
    func loadData() {
        viewModel.getListContent()
    }
}

#Preview {
    ListContentView()
}
