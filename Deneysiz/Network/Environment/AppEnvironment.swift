//
//  Environment.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 26.05.2021.
//

import Foundation

final class AppEnvironment: EnvironmentProtocol {

    static let shared = AppEnvironment()

    var baseURL: URL
    var headers: Headers?

    private init() {
        guard let url = URL(string: "https://google.com") else { fatalError() }
        baseURL = url
        headers = [:]
    }
}
