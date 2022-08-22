//
//  UIDevice+Extensions.swift
//  Deneysiz
//
//  Created by ogulcan keskin on 21.08.2022.
//

import UIKit

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
