//
//  Array+Extension.swift
//  MindKit
//
//  Created by ogulcan keskin on 28.12.2020.
//  Copyright © 2020 Deep Work. All rights reserved.
//

import Foundation

extension Array {
    public func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            
            return Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
