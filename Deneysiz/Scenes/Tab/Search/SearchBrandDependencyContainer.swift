//
//  DiscoverDependencyContainer.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import Foundation

final class SearchBrandDependencyContainer: ObservableObject {
    
    func makeSearchViewModel() -> SearchBrandViewModel {
        let searchBrandService = BrandSearchService()
        let viewModel = SearchBrandViewModel(searchBrandService: searchBrandService)
        return viewModel
    }

    func makeBrandDetailViewModel(brandID: Int) -> BrandDetailViewModel {
        .init(brandID: brandID, service: BrandDetailService())
    }
}
