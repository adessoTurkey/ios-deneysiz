//
//  CategoryViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import Combine

final class CategoryListViewModel: BaseViewModel, ObservableObject {
    
    let categoryAPI: CategoryAPI
    @Published var categories: [CategoryEnum] = []
    private let tracker = InstanceTracker()
    
    init(categoryAPI: CategoryAPI) {
        self.categoryAPI = categoryAPI
    }
    
    func getCategories() {
        categoryAPI.getCategories()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] in
                    self?.categories = $0
                })
            .store(in: &self.cancellables)
    }
}

class BaseViewModel {
    var cancellables = Set<AnyCancellable>()
}
