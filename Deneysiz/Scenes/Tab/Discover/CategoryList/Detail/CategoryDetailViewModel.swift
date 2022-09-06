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
    @Published var showOrderSheet = false
    @Published var showPointsPopUp = false
    @Published var showNoDataLottie = false
    @Published var followedBrandList: [BrandDetail] = []

    var savedPointPopUpConfig: PointDetailAlert.Config = .dummy
    var errorType: CustomErrorAlert.Config  = .operationFail

    let brandService: BrandAPI
    let categoryEnum: CategoryEnum
    
    var currentConfig: OrderConfig = .point(.desc)

    @UserDefaultWrapper(key: Constants.UserDefaults.followedItem, defaultValue: [])
    private var followedBrands: [BrandDetail]

    init(categoryEnum: CategoryEnum, brandService: BrandAPI) {
        self.categoryEnum = categoryEnum
        self.brandService = brandService
        super.init()
        self.getBrands()
    }

    func onAppear() {
        self.followedBrandList = self.followedBrands
    }
    
    func getBrands() {
        viewState = .loading
        brandService.getBrandsByCategory(payload: .init(categoryId: "\(categoryEnum.rawValue)"))
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.viewState = .error
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
                guard let self = self else { return }
                self.viewState = .loaded
                self.showNoDataLottie = brands.isEmpty
                self.brands = brands.sorted(by: { $0.score > $1.score })
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
            details: PointDetailPopUpLogic.makePointDetailUIModel(brand: brand)
        )
        self.showPointsPopUp = true
    }

    func followBrand(brand: Brand) {
        defer {
            followedBrandList = followedBrands
        }

        if followedBrands.contains(where: { brandDetail in
            brandDetail.id == brand.id
        }) {
            followedBrands.removeAll { followedBrand in
                brand.id == followedBrand.id
            }
        } else {
            followedBrands.append(BrandDetail(id: brand.id, name: brand.name, parentCompany: brand.parentCompany, offerInChina: brand.offerInChina, categoryId: brand.categoryId, certificates: brand.certificates, safe: brand.safe, vegan: brand.vegan, veganProduct: brand.veganProduct, score: brand.score, description: brand.description, createdAt: brand.createdAt))
        }
    }

    func isFollowed(id: Int) -> Bool {
        return self.followedBrandList.contains { brand in
            brand.id == id
        }
    }
}
