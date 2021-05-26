//
//  Routable.swift
//  CovidTracker
//
//  Created by U. on 29.04.2020.
//  Copyright © 2020 Adesso. All rights reserved.
//

import Foundation

typealias Headers = [String: String]

protocol EnvironmentProtocol {
    var baseURL: URL { get set }
    var headers: Headers? { get set }
}

