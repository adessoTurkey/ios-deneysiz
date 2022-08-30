//
//  SwipeModifier.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 30/08/2022.
//

import Foundation
import SwiftUI
import SwipeCell

struct SwipeModifier<Label: View>: ViewModifier {
    let label: Label
    let tintColor: Color

    // iOS 14
    let slots: [Slot]

    init(@ViewBuilder label: @escaping () -> Label, tintColor: Color, slots: [Slot] = []) {
        self.label = label()
        self.tintColor = tintColor
        self.slots = slots
    }

    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .swipeActions {
                    label
                        .tint(tintColor)
                }
                .buttonStyle(PlainButtonStyle())
        } else {
            if slots.isEmpty {
                content
                    .buttonStyle(PlainButtonStyle())
            } else {
                content
                    .onSwipe(trailing: slots)
                    .buttonStyle(.automatic)
            }
        }
    }
}
