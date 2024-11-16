//
//  BaseViewModel.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//

import RxSwift

class BaseViewModel {
    private var _disposeBag: DisposeBag?
    
    var disposeBag: DisposeBag {
        get {
            if let d = self._disposeBag {
                return d
            } else {
                self._disposeBag = DisposeBag()
                return self._disposeBag!
            }
        }
    }
    
    lazy var _liveError = { PublishSubject<String>() }()
    var liveError: Observable<String> {
        _liveError.asObservable()
    }
    
    lazy var _liveConnectionError = { PublishSubject<Bool>() }()
    var liveConnectionError: Observable<Bool> {
        _liveConnectionError.asObservable()
    }
    
    lazy var _liveIsPastOperationalHoursError = { PublishSubject<String>() }()
    var liveIsPastOperationalHoursError: Observable<String> {
        _liveIsPastOperationalHoursError.asObservable()
    }
    
    private lazy var _liveUnAuthorizeToken = { PublishSubject<Bool>() }()
    var liveUnAuthorizeToken: Observable<Bool> {
        _liveUnAuthorizeToken.asObservable()
    }
    
    func defaultErrorHandler(_ response: ApiErrorDto) {
        if response.status == ApiErrorDto.unAuthorizedError.status || response.status == ApiErrorDto.forbiddenError.status {
            self._liveUnAuthorizeToken.onNext(true)
        } else if response.status == ApiErrorDto.connectionTimeout.status {
            self._liveConnectionError.onNext(true)
        } else if response.status == ApiErrorDto.connectionError.status {
            self._liveConnectionError.onNext(true)
        } else {
            self._liveError.onNext(response.details?.first?.defaultMessage ?? "")
        }
    }
}

