//
//  FirstDependencyContainer.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 28.05.2021.
//

import Foundation

class FirstDependencyContainer: ObservableObject {
    
    init() { print("FirstDependencyContainer init") }
    
    func makeFirstViewModel() -> FirstViewModel {
        let service: AuthAPI
        #if DEBUG
            service = FakeAuthService()
        #else
            service = AuthService()
        #endif
        
        return FirstViewModel(firstService: service)
    }
}
