//
//  OpenWebsite.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 20.12.2021.
//

import Foundation
import SwiftUI

class OpenWebsite {
    public static let shared = OpenWebsite()
    
    func openURL(appURL: URL? = nil, webURL: URL? = nil) {
        
        if let url = appURL, UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else if let url = webURL {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

}
