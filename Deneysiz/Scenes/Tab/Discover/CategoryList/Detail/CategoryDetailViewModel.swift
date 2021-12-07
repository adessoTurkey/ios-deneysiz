//
//  CategoryDetailViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Foundation
import SwiftUI

enum OrderConfig: Equatable, Identifiable {
    var id: String {
        UUID().uuidString
    }
    
    case point(OrderType)
    case name(OrderType)
    
    enum OrderType: Equatable {
        case asc
        case desc
    }
    
    var title: LocalizedStringKey {
        switch self {
        case .point(let orderType):
            switch orderType {
            case .asc:
                return "brand-detail-point-asc"
            case .desc:
                return "brand-detail-point-desc"
            }
        case .name(let orderType):
            switch orderType {
            case .asc:
                return "brand-detail-name-asc"
            case .desc:
                return "brand-detail-name-desc"
            }
        }
    }
}

final class CategoryDetailViewModel: BaseViewModel, ObservableObject {
    
    @Published var brands: [Brand] = []
    @Published var isLoading = true
    @Published var showOrderSheet = false
    
    let brandService: BrandAPI
    let categoryEnum: CategoryEnum
    
    var currentConfig: OrderConfig = .point(.desc)
    private let tracker = InstanceTracker()
    
    init(categoryEnum: CategoryEnum, brandService: BrandAPI) {
        self.categoryEnum = categoryEnum
        self.brandService = brandService
        super.init()
        getBrands()
    }
    
    func getBrands() {
        Logger.shared.log("\(categoryEnum.rawValue)")
        brandService.getBrandsByCategory(payload: .init(categoryId: "\(categoryEnum.rawValue)"))
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(_):
                    self?.onError = true
                default:
                    break
                }
            } receiveValue: { [weak self] in
                Logger.shared.log("receiveValue")
                self?.brands = $0.sorted(by: { $0.score > $1.score })
            }
        .store(in: &self.cancellables)
    }
    
    func orderButtonTapped() {
        showOrderSheet = true
    }
    
    func order(_ newConfig: OrderConfig) {
        guard newConfig != currentConfig else { return }
        defer {
            currentConfig = newConfig
        }
        switch newConfig {
        case let .point(order):
            switch order {
            case .asc:
                brands = brands.sorted(by: { $0.score < $1.score })
            case .desc:
                brands = brands.sorted(by: { $0.score > $1.score })
            }
        case let .name(order):
            switch order {
            case .asc:
                brands = brands.sorted(by: { $0.name < $1.name })
            case .desc:
                brands = brands.sorted(by: { $0.name > $1.name })
            }
        }
    }
}
