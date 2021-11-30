//
//  BaseResponse.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.12.2021.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let status: Int
    let data: T
    let message: String
}
