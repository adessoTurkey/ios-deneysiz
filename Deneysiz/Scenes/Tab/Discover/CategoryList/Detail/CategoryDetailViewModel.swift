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
    @Published var isLoading: Bool = false
    @Published var showOrderSheet = false
    @Published var showPointsPopUp = false
    @Published var showNoDataLottie = false

    var savedPointPopUpConfig: PointDetailAlert.Config = .dummy
    var errorType: CustomErrorAlert.Config  = .operationFail

    let brandService: BrandAPI
    let categoryEnum: CategoryEnum
    
    var currentConfig: OrderConfig = .point(.desc)

    init(categoryEnum: CategoryEnum, brandService: BrandAPI) {
        self.categoryEnum = categoryEnum
        self.brandService = brandService
        super.init()
    }
    
    func getBrands() {
        isLoading = true
        brandService.getBrandsByCategory(payload: .init(categoryId: "\(categoryEnum.rawValue)"))
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    let error = error as NSError
                    if error.code == -1009 {
                        self?.errorType = .noInternet
                    } else {
                        self?.errorType = .operationFail
                    }
                    self?.onError = true
                default:
                    break
                }
            } receiveValue: { [weak self] brands in
                self?.showNoDataLottie = brands.isEmpty
                self?.brands = brands.sorted(by: { $0.score > $1.score })
            }
        .store(in: &self.cancellables)
    }
    
    func orderButtonTapped() {
        withAnimation {
            showOrderSheet = true
        }
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

    func createPointAlertConfig(brand: Brand?) {
        self.savedPointPopUpConfig = .init(
            overlayImage: "points",
            description: "brand-detail-points-alert-description",
            point: brand?.score ?? 0,
            details: PointDetailPopUpLogic.makePointDetailUIModel(for: brand)
        )
        self.showPointsPopUp = true
    }
}
