//
//  PreferenceKeyBase.swift
//  Deneysiz
//
//  Created by ogulcan keskin on 21.03.2022.
//

import SwiftUI

public protocol LatestValuePreferenceKey: PreferenceKey {}

public extension LatestValuePreferenceKey {
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

public protocol SizePreferenceKey: LatestValuePreferenceKey {}

public extension SizePreferenceKey {
    static var defaultValue: CGSize {
        .zero
    }
}

// MARK: Horizontal Alignment
public protocol HorizontalAlignmentPreferenceKey: LatestValuePreferenceKey {}

public extension HorizontalAlignmentPreferenceKey {
    static var defaultValue: HorizontalAlignment {
        .center
    }
}

// MARK: Float
public protocol FloatPreferenceKey: LatestValuePreferenceKey {}

public extension FloatPreferenceKey {
    static var defaultValue: CGFloat {
        .zero
    }
}




