//
//  ListContentVm.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//

import Foundation
import RxSwift
import Factory

class ListContentVm : BaseViewModel {
    
    @Injected(ServiceContainer.contentService) private var service
    
    private let _liveGetListContentSuccess = PublishSubject<[ContentViewData]>()
    var liveGetListContentSuccess: Observable<[ContentViewData]>{
        return _liveGetListContentSuccess
    }
    
    
    func getListContent(){
        service.getListContent { result in
            switch result {
            case .success(let result): do {
                let viewdata : [ContentViewData] = result.map{ it in
                    ContentViewData(image: it.thumbnailURL,
                                        author: it.presenterName,
                                        title: it.title,
                                        description: it.description,
                                        duration: self.formatDuration(it.videoDuration),
                                        videoURL: it.videoURL)
                }
                
                self._liveGetListContentSuccess.onNext(viewdata)
            }
            case .error(let error): do {
                self.defaultErrorHandler(error)
            }
            }
        }
    }
    
    func formatDuration(_ duration: Int) -> String {
        let minutes = duration / 1000 / 60
        let remainingSeconds = duration / 1000 % 60
        return String(format: "%d:%02d", minutes, remainingSeconds)
    }
    
}
