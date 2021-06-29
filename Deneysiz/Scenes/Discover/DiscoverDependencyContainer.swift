//
//  DiscoverDependencyContainer.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import Foundation

final class DiscoverDependencyContainer: ObservableObject {
    
    func makeCategoryViewModel() -> CategoryListViewModel {
        let fakeService = FakeCategoryService()
        return CategoryListViewModel(categoryAPI: fakeService)
    }
}
