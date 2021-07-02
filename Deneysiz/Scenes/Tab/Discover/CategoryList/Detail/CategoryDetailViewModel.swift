//
//  CategoryDetailViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Foundation

final class CategoryDetailViewModel: BaseViewModel, ObservableObject {
    
    private let tracker = InstanceTracker()

    @Published var brands: [Brand] = []
    @Published var isLoading = true
    
    let brandService: BrandAPI
    let categoryEnum: CategoryEnum
    
    init(categoryEnum: CategoryEnum, brandService: BrandAPI) {
        self.categoryEnum = categoryEnum
        self.brandService = brandService
        super.init()
        getBrands()
    }
    
    func getBrands() {
        Logger.shared.log("\(categoryEnum.rawValue)")
        brandService.getBrandsByCategory(category: categoryEnum)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] in
                    Logger.shared.log("receiveValue")
                    self?.brands = $0
                    self?.isLoading = false
                })
            .store(in: &self.cancellables)
    }
}
