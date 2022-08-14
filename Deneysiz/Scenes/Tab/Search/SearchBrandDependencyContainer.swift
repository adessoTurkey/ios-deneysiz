//
//  DiscoverDependencyContainer.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import Foundation

final class SearchDependencyContainer: ObservableObject {
    
    func makeSearchViewModel() -> SearchViewModel {
        let searchBrandService = BrandSearchService()
        let viewModel = SearchViewModel(searchBrandService: searchBrandService)
        return viewModel
    }
}
