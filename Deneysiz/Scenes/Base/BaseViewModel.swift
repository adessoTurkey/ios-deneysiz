//
//  BaseViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 13.07.2021.
//

import Combine

class BaseViewModel {
    var cancellables = Set<AnyCancellable>()
    @Published var onError = false
    @Published var viewState: ViewState?
}

extension BaseViewModel {
    enum ViewState: Equatable {
        case loading
        case loaded
        case error
    }
}
