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
  
    @State var data: [ContentViewData] = []
    
    var body: some View {
        NavigationView {
            List(data, id: \.self) { item in
                NavigationLink(destination:ContentView(contentData: item)) {
                    ListContentCell(contentData: item).padding(.leading, 16)
                }.listRowSeparator(.hidden)
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
            onNext: { viewdata in
                self.data = viewdata
            }
        ).disposed(by: viewModel.disposeBag)
    }
    
    func loadData() {
        viewModel.getListContent()
    }
}

#Preview {
    ListContentView()
}
