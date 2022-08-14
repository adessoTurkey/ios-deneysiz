//
//  View+Extensions.swift
//  OgiFlux
//
//  Created by ogulcan keskin on 7.12.2020.
//

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView { AnyView(self) }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder()
                .opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
