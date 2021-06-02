//
//  Request.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 26.05.2021.
//

import Foundation

struct Request {
    var method: HTTPMethod
    var path: String
    var payload: Data?
    
    init<C: Codable>(method: HTTPMethod = .POST, path: String, payload: C? = nil) {
        self.method = method
        self.path = path
        do {
            self.payload = try JSONEncoder().encode(payload)
        } catch {
            self.payload = nil
        }
    }
}
