//
//  FirstViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 28.05.2021.
//

import Foundation

class FirstViewModel: ObservableObject {
    
    let firstService: AuthAPI
    
    init(firstService: AuthAPI) {
        print("FirstViewModel init")
        self.firstService = firstService
    }
}
