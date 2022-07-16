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
        guard let url = URL(string: "http://deneysiz-backend-prod.eu-central-1.elasticbeanstalk.com") else { fatalError() }
        baseURL = url
        headers = [
            "Content-type": "application/json; charset=UTF-8"
        ]
    }
}
