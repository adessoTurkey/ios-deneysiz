//
//  SearchViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 12/08/2022.
//

import Foundation

final class SearchViewModel: BaseViewModel, ObservableObject {

    @Published var searchText = ""
    @Published var brands = [BrandSearch]()

    private let searchBrandService: BrandSearchAPI

    init(searchBrandService: BrandSearchAPI) {
        self.searchBrandService = searchBrandService
        super.init()
        bindSearch()
    }

    private func bindSearch() {
        $searchText
            .debounce(for: .milliseconds(600), scheduler: RunLoop.main) // debounces the string publisher, such that it delays the process of sending request to remote server.
            .removeDuplicates()
            .map { (string) -> String? in
                if string.count < 1 {
                    self.brands = []
                    return nil
                }
                return string
            }
            .compactMap{ $0 }
            .sink { [weak self] query in
                self?.searchBrands(query)
            }
            .store(in: &cancellables)
    }

    private func searchBrands(_ query: String) {
        searchBrandService.searchBrand(payload: SearchBrandPayload(query: query))
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] in
                    self?.brands = $0
                })
            .store(in: &self.cancellables)
    }
}
