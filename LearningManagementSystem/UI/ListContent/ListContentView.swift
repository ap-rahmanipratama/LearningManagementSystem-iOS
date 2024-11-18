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
    @Injected(CommonContainer.cache) var cache
  
    @State var data: [ContentViewData] = []
    
    var body: some View {
        NavigationView {
            List(data, id: \.self) { item in
                NavigationLink(destination:ContentView(contentData: item)) {
                    ListContentCell(contentData: item).padding(.leading, 16)
                }.listRowSeparator(.hidden)
            }.listStyle(.grouped)
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
        
        viewModel.liveError.subscribe(
            onNext: { error in
                self.data = cache.getContentListCache() ?? []
            }
        ).disposed(by: viewModel.disposeBag)
        
        viewModel.liveConnectionError.subscribe(
            onNext: { error in
                self.data = cache.getContentListCache() ?? []
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
