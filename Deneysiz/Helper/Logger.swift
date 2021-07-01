//
//  Logger.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 1.07.2021.
//

import Foundation

class Logger {
    static var shared = Logger()
    
    func log(_ message: String = "", file: String = #fileID, function: String = #function) {
        let str = "\(message) called from \(function) \((file as NSString).lastPathComponent)"
        print(str)
    }
}
