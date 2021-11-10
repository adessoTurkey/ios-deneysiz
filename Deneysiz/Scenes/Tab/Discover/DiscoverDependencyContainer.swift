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
        return .init(categoryAPI: fakeService)
    }
    
    func makeCategoryDetailViewModel(categoryEnum: CategoryEnum) -> CategoryDetailViewModel {
        let fakeService = FakeBrandService()
        return .init(categoryEnum: categoryEnum, brandService: fakeService)
    }
    
    func makeBrandDetailViewModel(brand: BrandDummy) -> BrandDetailViewModel {
        .init(brand: brand)
    }
}
