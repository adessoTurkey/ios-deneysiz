//
//  UIApplication+Extension.swift
//  Deneysiz
//
//  Created by ogulcan keskin on 23.08.2022.
//

import UIKit

extension UIApplication {
    struct Constants {
        static let CFBundleShortVersionString = "CFBundleShortVersionString"
    }
    class func appVersion() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: Constants.CFBundleShortVersionString) as? String
    }
  
    class func appBuild() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
  
    class func versionBuild() -> String {
        if let version = appVersion(), let build = appBuild() {
            return version == build ? "v\(version)" : "v\(version)(\(build))"
        } else {
            return ""
        }
    }
}
