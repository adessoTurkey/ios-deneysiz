//
//  FirstViewModel.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 28.05.2021.
//

import Foundation

class FirstViewModel: BaseViewModel, ObservableObject {
    
    let firstService: AuthAPI
    let realService: ExampleAPI
    @Published var exampleModel: [ExampleModel] = []
    
    init(firstService: AuthAPI, realService: ExampleAPI) {
        print("FirstViewModel init")
        self.firstService = firstService
        self.realService = realService
        super.init()
        startTest()
    }
    
    func startTest() {
        realService.test()
            .sink(
                receiveCompletion: { err in
                    switch err {
                    case .failure(let err):
                        print(err)
                    case .finished:
                        print("finished")
                    }
                },
                receiveValue: { [weak self] in
                    self?.exampleModel = $0
                })
            .store(in: &self.cancellables)
    }
}
