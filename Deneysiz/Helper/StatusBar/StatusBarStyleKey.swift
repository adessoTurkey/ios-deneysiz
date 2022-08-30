//
//  StatusBarPreference.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 30/08/2022.
//

import SwiftUI

struct StatusBarStyleKey: PreferenceKey {
    static var defaultValue: UIStatusBarStyle = .default

    static func reduce(value: inout UIStatusBarStyle, nextValue: () -> UIStatusBarStyle) {
        value = nextValue()
    }
}

extension View {
    func statusBar(style: UIStatusBarStyle) -> some View {
        preference(key: StatusBarStyleKey.self, value: style)
    }
}
