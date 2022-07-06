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
    @Published var isLoading = true
    
    private let brand: Brand
    private let service: BrandDetailAPI
    private var brandDetail: BrandDetail?

    init(brand: Brand, service: BrandDetailAPI) {
        self.brand = brand
        self.service = service
        super.init()
        getBrandDetail()
        evaluateDetail()
    }
    
    func getBrandDetail() {
        service.getBrandDetail(payload: .init(id: "\(brand.id)"))
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    switch completion {
                    case .failure(_):
                        self?.onError = true
                    default:
                        break
                    }
                    
                }, receiveValue: { [weak self] details in
                    guard let first = details.first else { return }
                    self?.brandDetail = first
                    self?.brandDetailUIModel = BrandDetailUIModel(brandDetail: first)
                })
            .store(in: &self.cancellables)
    }
    
    func createPointAlertConfig() -> PointDetailAlert.Config {
        .init(
            overlayImage: "points",
            description: "",
            point: brandDetail?.score ?? 0,
            details: PointDetailPopUpLogic.makePointDetailUIModel(for: brandDetail)
        )
    }
    
    private func evaluateDetail() {
        func image(_ state: Bool) -> String {
            state == true ? "statusYes" : "statusNo"
        }
        
        let hasVeganProduct = Details(title: "brand-detail-hasVeganProduct", image: image(brand.veganProduct))
        
        let offerInChina = Details(title: "brand-detail-offerInChina", image: image(!brand.offerInChina))
        
        // cati firma null ise "Cati Firma Deneysiz" yesil tik goster.
        let parentCompanySafe = Details(title: "brand-detail-parentCompanySafe", image: image(brand.parentCompany?.safe ?? true))
        
        detail = [hasVeganProduct, offerInChina, parentCompanySafe]
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
    
    static func makePointDetailUIModel(for detail: BrandDetail?) -> [BrandPointDetailUIModel] {
        guard let detail = detail else {
            return []
        }

        let brandSafe = make(
            name: "brand-detail-safe",
            condition: detail.safe,
            point: ("4", "0"),
            pointSum: "4",
            title: ("Evet", "Hayır"),
            color: (.superHighPointGreen, .lowPointRed))
        
        let parentSafe = make(
            name: "brand-detail-parentCompanySafe",
            condition: detail.parentCompany?.safe,
            point: ("3", "0"),
            pointSum: "3",
            title: ("Evet", "Hayır"),
            color: (.superHighPointGreen, .lowPointRed))
        
        let offerChina = make(
            name: "brand-detail-offerInChina",
            condition: detail.offerInChina,
            point: ("0", "1"),
            pointSum: "1",
            title: ("Evet", "Hayır"),
            color: (.lowPointRed, .superHighPointGreen))
        
        let vegan = make(
            name: "brand-detail-vegan",
            condition: detail.vegan,
            point: ("1", "0"),
            pointSum: "1",
            title: ("Evet", "Hayır"),
            color: (.superHighPointGreen, .lowPointRed))
        
        let veganProduct = make(
            name: "brand-detail-hasVeganProduct",
            condition: detail.veganProduct,
            point: ("1", "0"),
            pointSum: "1",
            title: ("Evet", "Hayır"),
            color: (.superHighPointGreen, .lowPointRed))
       
        return [brandSafe, parentSafe, offerChina, vegan, veganProduct]
    }

}
