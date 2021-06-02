//
//  RawRepresentable+Extension.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 2.06.2021.
//

import Foundation

extension RawRepresentable where RawValue == String {
    func callAsFunction() -> String {
        self.rawValue
    }
}
