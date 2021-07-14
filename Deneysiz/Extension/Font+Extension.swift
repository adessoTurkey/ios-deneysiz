//
//  Font+Extension.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 30.06.2021.
//

import SwiftUI

extension Font {
    
    private struct FontFamily {
        
        static let poppinsRegular = "Poppins-Regular"
        static let poppinsBold = "Poppins-Bold"
        static let poppinsBoldItalic = "Poppins-BoldItalic"
        static let poppinsSemiBold = "Poppins-SemiBold"
        static let poppinsSemiBoldItalic = "Poppins-SemiBoldItalic"
        static let poppinsLight = "Poppins-Light"
        static let poppinsLightItalic = "Poppins-LightItalic"
        static let poppinsBlack = "Poppins-Black"
        static let poppinsBlackItalic = "Poppins-BlackItalic"
        static let poppinsItalic = "Poppins-Italic"
        static let poppinsMedium = "Poppins-Medium"

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
            return Font.custom(FontFamily.poppinsRegular, size: size)
        case .fontBold:
            return Font.custom(FontFamily.poppinsBold, size: size)
        case .fontBoldItalic:
            return Font.custom(FontFamily.poppinsBoldItalic, size: size)
        case .fontSemiBold:
            return Font.custom(FontFamily.poppinsSemiBold, size: size)
        case .fontSemiBoldItalic:
            return Font.custom(FontFamily.poppinsSemiBoldItalic, size: size)
        case .fontLight:
            return Font.custom(FontFamily.poppinsLight, size: size)
        case .fontLightItalic:
            return Font.custom(FontFamily.poppinsLightItalic, size: size)
        case .fontBlack:
            return Font.custom(FontFamily.poppinsBlack, size: size)
        case .fontBlackItalic:
            return Font.custom(FontFamily.poppinsBlackItalic, size: size)
        case .fontItalic:
            return Font.custom(FontFamily.poppinsItalic, size: size)
        case .fontMedium:
            return Font.custom(FontFamily.poppinsMedium, size: size)

        }
        
    }
    
}
