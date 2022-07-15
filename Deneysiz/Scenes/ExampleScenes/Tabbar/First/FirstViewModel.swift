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
        self.firstService = firstService
        self.realService = realService
        super.init()
        startTest()
    }
    
    func startTest() {
        
        realService.realRequest()
            .sink(
                receiveCompletion: { err in
                },
                receiveValue: { bool in
                })
            .store(in: &self.cancellables)

//        realService.test()
//            .sink(
//                receiveCompletion: { err in
//                    switch err {
//                    case .failure(let err):
//                        if let err = err as? URLError, err.code == .notConnectedToInternet {
//                            print(err)
//                        }
//                    case .finished:
//                        print("finished")
//                    }
//                },
//                receiveValue: { [weak self] in
//                    self?.exampleModel = $0
//                })
//            .store(in: &self.cancellables)
//
        //        postTest()
    }
    
    func postTest() {
//        realService.postTest(param: ExampleModel(id: 101, userId: 1, title: "fooli", body: "phoeby"))
//            .sink { temp in
//                print(temp)
//            } receiveValue: { exampleModel in
//                if exampleModel.userId == 1 {
//                    print("Post Test Succeed")
//                }
//            }
//            .store(in: &self.cancellables)
    }
}
