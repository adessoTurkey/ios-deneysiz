//
//  BrandDetailViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 13.07.2021.
//

import Foundation

final class BrandDetailViewModel: BaseViewModel, ObservableObject {
   
    struct BrandDetail: Identifiable {
        var title: String
        var image: String
        
        var id: String {
            title
        }
    }
    
    let brand: Brand
    @Published var detail: [BrandDetail] = []
    
    init(brand: Brand) {
        self.brand = brand
        super.init()
        evaluateDetail()
    }
    
    private func evaluateDetail() {
        func image(_ state: Bool?) -> String {
            state == true ? "checked" : "none"
        }
        
        let hasVeganProduct = BrandDetail(title: "brand-detail-hasVeganProduct", image: image(brand.veganProduct))
        let offerInChina = BrandDetail(title: "brand-detail-offerInChina", image: image(brand.offerInChina))
        let parentCompanySafe = BrandDetail(title: "brand-detail-parentCompanySafe", image: image(brand.safe))
        
        detail.append(contentsOf: [hasVeganProduct, offerInChina, parentCompanySafe])
    }
   
}
