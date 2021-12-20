//
//  Font+Extension.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 30.06.2021.
//

import SwiftUI

extension Font {
    
    private struct FontFamily {
        
        static let mulishRegular = "Mulish-Regular"
        static let mulishBold = "Mulish-Bold"
        static let mulishBoldItalic = "Mulish-BoldItalic"
        static let mulishSemiBold = "Mulish-SemiBold"
        static let mulishSemiBoldItalic = "Mulish-SemiBoldItalic"
        static let mulishLight = "Mulish-Light"
        static let mulishLightItalic = "Mulish-LightItalic"
        static let mulishBlack = "Mulish-Black"
        static let mulishBlackItalic = "Mulish-BlackItalic"
        static let mulishItalic = "Mulish-Italic"
        static let mulishMedium = "Mulish-Medium"

    }
    
    public enum FontType {
        case fontRegular
        case fontBold
        case fontBoldItalic
        case fontSemiBold
        case fontSemiBoldItalic
        case fontLight
        case fontLightItalic
        case fontBlack
        case fontBlackItalic
        case fontItalic
        case fontMedium
    }
    
    public static func customFont(size: CGFloat, type: FontType = .fontRegular) -> Font {

        switch type {
        case .fontRegular:
            return Font.custom(FontFamily.mulishRegular, size: size)
        case .fontBold:
            return Font.custom(FontFamily.mulishBold, size: size)
        case .fontBoldItalic:
            return Font.custom(FontFamily.mulishBoldItalic, size: size)
        case .fontSemiBold:
            return Font.custom(FontFamily.mulishSemiBold, size: size)
        case .fontSemiBoldItalic:
            return Font.custom(FontFamily.mulishSemiBoldItalic, size: size)
        case .fontLight:
            return Font.custom(FontFamily.mulishLight, size: size)
        case .fontLightItalic:
            return Font.custom(FontFamily.mulishLightItalic, size: size)
        case .fontBlack:
            return Font.custom(FontFamily.mulishBlack, size: size)
        case .fontBlackItalic:
            return Font.custom(FontFamily.mulishBlackItalic, size: size)
        case .fontItalic:
            return Font.custom(FontFamily.mulishItalic, size: size)
        case .fontMedium:
            return Font.custom(FontFamily.mulishMedium, size: size)

        }
        
    }
    
}
