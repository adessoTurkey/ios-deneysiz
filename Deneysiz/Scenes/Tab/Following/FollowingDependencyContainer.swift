//
//  FollowingDependencyContainer.swift
//  Deneysiz
//
//  Created by ogulcan keskin on 23.08.2022.
//

import Foundation

final class FollowingDependencyContainer: ObservableObject {

    func makeFollowingViewModel() -> FollowingViewModel {
        return FollowingViewModel()
    }
    
    func makeBrandDetailViewModel(brandID: Int) -> BrandDetailViewModel {
        .init(brandID: brandID, service: BrandDetailService())
    }
}
