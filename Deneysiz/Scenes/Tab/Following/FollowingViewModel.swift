//
//  FollowingViewModel.swift
//  Deneysiz
//
//  Created by ogulcan keskin on 23.08.2022.
//

import Foundation

final class FollowingViewModel: BaseViewModel, ObservableObject {

    @Published var brands: [BrandDetail] = []
    @Published var showPointsPopUp = false

    var savedPointPopUpConfig: PointDetailAlert.Config = .dummy

    @UserDefaultWrapper(key: Constants.UserDefaults.followedItem, defaultValue: [])
    private var followedBrands: [BrandDetail]
    
    func refresh() {
        brands = followedBrands
    }
    
    func removeRows(at offsets: IndexSet) {
        followedBrands.remove(atOffsets: offsets)
        refresh()
    }

    func createPointAlertConfig(brandDetail: BrandDetail?) {
        self.savedPointPopUpConfig = .init(
            overlayImage: "points",
            description: "brand-detail-points-alert-description",
            point: brandDetail?.score ?? 0,
            details: PointDetailPopUpLogic.makePointDetailUIModel(detail: brandDetail)
        )
        self.showPointsPopUp = true
    }
}
