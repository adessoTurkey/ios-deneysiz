//
//  InstanceTracker.swift
//  SwisscomAlarm
//
//  Created by Ogulcan Keskin on 31.05.2021.
//  Copyright © 2021 Adesso. All rights reserved.
//

import Foundation

class InstanceTracker {
    static var count: Int {
        counter += 1
        return counter
    }
    
    let instance = InstanceTracker.count
    let name: String
    private static var counter: Int = 0
    private static var indent: Int = 0

    init(_ file: String = #fileID) {
        self.name = (file as NSString).lastPathComponent
        self("\(name).init() #++\(instance)")
    }
    deinit {
        self("\(name).deinit() #--\(instance)")
    }

    func callAsFunction(_ string: String) {
        print(String(repeating: " ", count: Self.indent) + string)
    }
}
