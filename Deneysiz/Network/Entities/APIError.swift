//
//  APIError.swift
//  CovidTracker
//
//  Created by U. on 29.04.2020.
//  Copyright © 2020 Adesso. All rights reserved.
//

import Foundation

enum APIError: Error {
    case decodingError(Error)
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
}
