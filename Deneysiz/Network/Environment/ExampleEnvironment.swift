//
//  ExampleEnvironment.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 23.06.2021.
//

import Foundation

final class ExampleEnvironment: EnvironmentProtocol {

    static let shared = ExampleEnvironment()

    var baseURL: URL
    var headers: Headers?
    
    private init() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { fatalError() }
        baseURL = url
        headers = [:]
    }
    
}
