//
//  CategoryDetailViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Foundation

final class CategoryDetailViewModel: BaseViewModel, ObservableObject {
    
    enum OrderConfig: Equatable {
        case point(OrderType)
        case name(OrderType)
        
        enum OrderType: Equatable {
            case asc
            case desc
        }
    }
    
    @Published var brands: [Brand] = []
    @Published var isLoading = true
    @Published var showOrderSheet = false
    
    let brandService: BrandAPI
    let categoryEnum: CategoryEnum
    
    private var prevConfig: OrderConfig = .point(.desc)
    private let tracker = InstanceTracker()
    
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
                    self?.brands = $0.sorted(by: { $0.point > $1.point })
                    self?.isLoading = false
                })
            .store(in: &self.cancellables)
    }
    
    func orderButtonTapped() {
        showOrderSheet = true
    }
    
    func order(_ config: OrderConfig) {
        guard config != prevConfig else { return }
        defer {
            prevConfig = config
        }
        switch config {
        case let .point(order):
            switch order {
            case .asc:
                brands = brands.sorted(by: { $0.point < $1.point })
            case .desc:
                brands = brands.sorted(by: { $0.point > $1.point })
            }
        case let .name(order):
            switch order {
            case .asc:
                brands = brands.sorted(by: { $0.name ?? "" < $1.name ?? "" })
            case .desc:
                brands = brands.sorted(by: { $0.name ?? "" > $1.name ?? "" })
            }
        }
    }
}
