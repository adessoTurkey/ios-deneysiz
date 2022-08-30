//
//  BrandDetailViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 13.07.2021.
//

import Foundation
import SwiftUI

final class BrandDetailViewModel: BaseViewModel, ObservableObject {
    
    struct Details: Identifiable {
        var title: String
        var image: String
        
        var id: String {
            title
        }
    }
    
    struct BrandDetailUIModel {
        let name: String
        let parentCompanyName: String
        let point: String
        let scoreColor: Color
        let certificates: [Certificate]
        let description: String
        let createDate: String
        
        init(brandDetail: BrandDetail) {
            self.name = brandDetail.name
            self.parentCompanyName = brandDetail.parentCompany?.name ?? ""
            self.point = brandDetail.pointTitle
            self.scoreColor = brandDetail.color
            self.certificates = brandDetail.certificates
            self.description = brandDetail.description
            self.createDate = brandDetail.createdAt
        }
        
        init(name: String, parentCompanyName: String, point: String, scoreColor: Color, certificates: [Certificate], description: String, createDate: String) {
            self.name = name
            self.parentCompanyName = parentCompanyName
            self.point = point
            self.scoreColor = scoreColor
            self.certificates = certificates
            self.createDate = createDate
            self.description = description
        }
        
        static let empty = BrandDetailUIModel(name: "", parentCompanyName: "", point: "", scoreColor: .clear, certificates: [], description: "", createDate: "")
    }
    
    @Published var brandDetailUIModel: BrandDetailUIModel = .empty
    @Published var detail: [Details] = []
    @Published var isFollowing: Bool = false
    
    @UserDefaultWrapper(key: Constants.UserDefaults.followedItem, defaultValue: [])
    private var followedBrands: [BrandDetail]

    private let brandID: Int
    private let service: BrandDetailAPI
    private var brandDetail: BrandDetail?

    init(brandID: Int, service: BrandDetailAPI) {
        self.brandID = brandID
        self.service = service
        super.init()
        getBrandDetail()
        evaluateDetail()
    }
    
    func getBrandDetail() {
        viewState = .loading
        service.getBrandDetail(payload: .init(id: "\(brandID)"))
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(_):
                        self?.viewState = .error
                        self?.onError = true
                    default:
                        break
                    }
                    
                }, receiveValue: { [weak self] details in
                    guard let first = details.first else { return }
                    self?.viewState = .loaded
                    self?.brandDetail = first
                    self?.brandDetailUIModel = BrandDetailUIModel(brandDetail: first)
                    self?.evaluateDetail()
                })
            .store(in: &self.cancellables)
    }
    
    func createPointAlertConfig() -> PointDetailAlert.Config {
        .init(
            overlayImage: "points",
            description: "brand-detail-points-alert-description",
            point: brandDetail?.score ?? 0,
            details: PointDetailPopUpLogic.makePointDetailUIModel(detail: brandDetail)
        )
    }
    
    func follow() {
        if let brandDetail = brandDetail {
            if !isFollowing {
                isFollowing = true
                followedBrands.append(brandDetail)
            } else {
                followedBrands.removeAll { brand in
                    brandDetail.id == brand.id
                }
                isFollowing = false
            }
        }
    }
    
    private func evaluateDetail() {
        func image(_ state: Bool) -> String {
            state == true ? "statusYes" : "statusNo"
        }

        guard let brandDetail = brandDetail else { return }

        let hasVeganProduct = Details(title: "brand-detail-hasVeganProduct", image: image(brandDetail.veganProduct))
        
        let offerInChina = Details(title: "brand-detail-offerInChina", image: image(!brandDetail.offerInChina))
        
        // cati firma null ise "Cati Firma Deneysiz" yesil tik goster.
        let parentCompanySafe = Details(title: "brand-detail-parentCompanySafe", image: image(brandDetail.parentCompany?.safe ?? true))
        
        detail = [hasVeganProduct, offerInChina, parentCompanySafe]
        
        self.isFollowing = self.followedBrands.contains { brandDetail in
            brandDetail.id == brandID
        }
    }
}

struct PointDetailPopUpLogic {

    private static func make(
        name: String,
        condition: Bool?,
        point: (String, String),
        pointSum: String,
        title: (String, String),
        color: (Color, Color)
    ) -> BrandPointDetailUIModel {
        guard let condition = condition else {
            return .init(name: "brand-detail-parentCompanySafe", point: "3/3", state: "Yok", color: .superHighPointGreen)
        }
        
        let point = "\(condition ? point.0 : point.1)/\(pointSum)"
        let state = condition ? title.0 : title.1
        let color = condition ? color.0 : color.1
        
        return .init(name: name, point: point, state: state, color: color)
    }
    
    static func makePointDetailUIModel(brand: Brand? = nil, detail: BrandDetail? = nil) -> [BrandPointDetailUIModel] {

        let isSafe: Bool
        let isParentSafe: Bool?
        let isOfferInChina: Bool
        let isVegan: Bool
        let isVeganProduct: Bool

        if let brand = brand {
            isSafe = brand.safe
            isParentSafe = brand.parentCompany?.safe
            isOfferInChina = brand.offerInChina
            isVegan = brand.vegan
            isVeganProduct = brand.veganProduct
        } else if let detail = detail {
            isSafe = detail.safe
            isParentSafe = detail.parentCompany?.safe
            isOfferInChina = detail.offerInChina
            isVegan = detail.vegan
            isVeganProduct = detail.veganProduct
        } else {
            return []
        }

        let brandSafe = make(
            name: "brand-detail-safe",
            condition: isSafe,
            point: ("4", "0"),
            pointSum: "4",
            title: ("Evet", "Hayır"),
            color: (.superHighPointGreen, .lowPointRed))
        
        let parentSafe = make(
            name: "brand-detail-parentCompanySafe",
            condition: isParentSafe,
            point: ("3", "0"),
            pointSum: "3",
            title: ("Evet", "Hayır"),
            color: (.superHighPointGreen, .lowPointRed))
        
        let offerChina = make(
            name: "brand-detail-offerInChina",
            condition: !isOfferInChina,
            point: ("1", "0"),
            pointSum: "1",
            title: ("Evet", "Hayır"),
            color: (.superHighPointGreen, .lowPointRed))
        
        let vegan = make(
            name: "brand-detail-vegan",
            condition: isVegan,
            point: ("1", "0"),
            pointSum: "1",
            title: ("Evet", "Hayır"),
            color: (.superHighPointGreen, .lowPointRed))
        
        let veganProduct = make(
            name: "brand-detail-hasVeganProduct",
            condition: isVeganProduct,
            point: ("1", "0"),
            pointSum: "1",
            title: ("Evet", "Hayır"),
            color: (.superHighPointGreen, .lowPointRed))
       
        return [brandSafe, parentSafe, offerChina, vegan, veganProduct]
    }
}
