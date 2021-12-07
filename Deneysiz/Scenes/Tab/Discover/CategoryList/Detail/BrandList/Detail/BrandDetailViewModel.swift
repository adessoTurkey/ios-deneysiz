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
        let createDate: String
        
        init(brandDetail: BrandDetail) {
            self.name = brandDetail.name
            self.parentCompanyName = brandDetail.parentCompany.name
            self.point = brandDetail.pointTitle
            self.scoreColor = brandDetail.color
            self.certificates = brandDetail.certificates
            self.createDate = brandDetail.createdAt
        }
        
        init(name: String, parentCompanyName: String, point: String, scoreColor: Color, certificates: [Certificate], createDate: String) {
            self.name = name
            self.parentCompanyName = parentCompanyName
            self.point = point
            self.scoreColor = scoreColor
            self.certificates = certificates
            self.createDate = createDate
        }
        
        static let empty = BrandDetailUIModel(name: "", parentCompanyName: "", point: "", scoreColor: .clear, certificates: [], createDate: "")
    }
    
    @Published var brandDetail: BrandDetailUIModel = .empty
    @Published var detail: [Details] = []
    @Published var isLoading = true
    
    private let brand: Brand
    private let service: BrandDetailAPI
    
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
                    self?.brandDetail = BrandDetailUIModel(brandDetail: first)
                })
            .store(in: &self.cancellables)
    }
    
    private func evaluateDetail() {
        func image(_ state: Bool) -> String {
            state == true ? "checked" : "none"
        }
        
        let hasVeganProduct = Details(title: "brand-detail-hasVeganProduct", image: image(brand.veganProduct))
        let offerInChina = Details(title: "brand-detail-offerInChina", image: image(brand.offerInChina))
        let parentCompanySafe = Details(title: "brand-detail-parentCompanySafe", image: image(brand.safe))
        
        detail = [hasVeganProduct, offerInChina, parentCompanySafe]
    }
    
}
