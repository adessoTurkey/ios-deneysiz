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
    
    func makeCategoryDetailViewModel(categoryEnum: CategoryEnum) -> CategoryDetailViewModel {
        return CategoryDetailViewModel(categoryEnum: categoryEnum)
    }
    
    func makeBrandListViewModel(categoryEnum: CategoryEnum) -> BrandListViewModel {
        let fakeService = FakeBrandService()
        return BrandListViewModel(categoryEnum: categoryEnum, brandService: fakeService)
    }
}
