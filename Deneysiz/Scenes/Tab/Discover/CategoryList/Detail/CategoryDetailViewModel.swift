//
//  CategoryDetailViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Foundation

final class CategoryDetailViewModel: BaseViewModel, ObservableObject {
    
    private let tracker = InstanceTracker()

    let categoryEnum: CategoryEnum
    
    init(categoryEnum: CategoryEnum) {
        self.categoryEnum = categoryEnum
        super.init()
    }
}
