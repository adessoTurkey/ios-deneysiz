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

struct FilterModel {
    
    var isVegan: Bool = false
    var isParentSafe: Bool = false
    var isOfferInChina: Bool = false
    var leapingBunnyCert: Bool = false
    var vlabelCert: Bool = false
    var beautyWithoutBunniesCert: Bool = false
    var veganSocietyCert: Bool = false
    
    init(isVegan: Bool = false,
         isParentSafe: Bool = false,
         isOfferInChina: Bool = false,
         leapingBunnyCert: Bool = false,
         vlabelCert: Bool = false,
         beautyWithoutBunniesCert: Bool = false,
         veganSocietyCert: Bool = false) {
        
        self.isVegan = isVegan
        self.isParentSafe = isParentSafe
        self.isOfferInChina = isOfferInChina
        self.leapingBunnyCert = leapingBunnyCert
        self.vlabelCert = vlabelCert
        self.beautyWithoutBunniesCert = beautyWithoutBunniesCert
        self.veganSocietyCert = veganSocietyCert
    }
}

final class CategoryDetailViewModel: BaseViewModel, ObservableObject {

    @Published var brands: [Brand] = []
    @Published var showOrderSheet = false
    @Published var showPointsPopUp = false
    @Published var showNoDataLottie = false
    @Published var showFilterScreen = false

    var savedPointPopUpConfig: PointDetailAlert.Config = .dummy
    var errorType: CustomErrorAlert.Config  = .operationFail

    let brandService: BrandAPI
    let categoryEnum: CategoryEnum
    
    var currentOrderConfig: OrderConfig = .point(.desc)
    var filterModel: FilterModel = FilterModel()
    var allBrands: [Brand] = []
    
    init(categoryEnum: CategoryEnum, brandService: BrandAPI) {
        self.categoryEnum = categoryEnum
        self.brandService = brandService
        super.init()
        self.getBrands()
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
                self?.viewState = .loaded
                self?.showNoDataLottie = brands.isEmpty
                self?.brands = brands.sorted(by: { $0.score > $1.score })
                self?.allBrands = brands
            }
        .store(in: &self.cancellables)
    }
    
    func orderButtonTapped() {
        withAnimation {
            showOrderSheet = true
        }
    }
    
    fileprivate func sortBrands(for newConfig: OrderConfig) {
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
    
    func order(_ newConfig: OrderConfig) {
        guard newConfig != currentOrderConfig else { return }
        defer {
            currentOrderConfig = newConfig
        }
        sortBrands(for: newConfig)
    }
    
    func filterButtonTapped() {
        withAnimation {
            showFilterScreen = true
        }
    }
    
    func filter(_ filterModel: FilterModel) {
        self.filterModel = filterModel
        print(filterModel)
        
        brands = allBrands.filter {
            (!filterModel.isVegan || $0.veganProduct == filterModel.isVegan) &&
            (!filterModel.isParentSafe || $0.parentCompany?.safe == filterModel.isParentSafe) &&
            (!filterModel.isOfferInChina || $0.offerInChina != filterModel.isOfferInChina) &&
            (!filterModel.leapingBunnyCert || $0.certificates.filter { $0.certType == .leapingBunny }.first?.valid == filterModel.leapingBunnyCert) &&
            (!filterModel.vlabelCert || $0.certificates.filter { $0.certType == .vlabel }.first?.valid == filterModel.vlabelCert) &&
            (!filterModel.beautyWithoutBunniesCert || $0.certificates.filter { $0.certType == .beautyWithoutBunnies }.first?.valid == filterModel.beautyWithoutBunniesCert) &&
            (!filterModel.veganSocietyCert || $0.certificates.filter { $0.certType == .veganSociety }.first?.valid == filterModel.veganSocietyCert)
        }
        sortBrands(for: currentOrderConfig)
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
}
