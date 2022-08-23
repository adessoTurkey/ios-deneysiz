//
//  FollowingViewModel.swift
//  Deneysiz
//
//  Created by ogulcan keskin on 23.08.2022.
//

import Foundation

final class FollowingViewModel: BaseViewModel, ObservableObject {

    @Published var brands: [BrandDetail] = []
    
    @UserDefaultWrapper(key: Constants.UserDefaults.followedItem, defaultValue: [])
    private var followedBrands: [BrandDetail]
    
    func refresh() {
        brands = followedBrands
    }
    
    func removeRows(at offsets: IndexSet) {
        followedBrands.remove(atOffsets: offsets)
        refresh()
    }
}
