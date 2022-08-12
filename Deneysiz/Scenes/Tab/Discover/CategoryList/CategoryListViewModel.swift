//
//  CategoryViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import Combine

final class CategoryListViewModel: BaseViewModel, ObservableObject {
    @Published var categories: [CategoryEnum] = []
    private let categoryAPI: CategoryAPI

    init(categoryAPI: CategoryAPI) {
        self.categoryAPI = categoryAPI
        super.init()
        self.getCategories()
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
