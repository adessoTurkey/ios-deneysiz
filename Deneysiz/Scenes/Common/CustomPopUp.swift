//
//  CustomPopUp.swift
//  OKRSwiftUIPhase1
//
//  Created by Ogulcan Keskin on 21.06.2021.
//

import SwiftUI

protocol Alertable: View {
    var onDismiss: (() -> Void) { get }
}

struct PopUpHelper<T>: ViewModifier where T: Alertable {
    let popUpView: T
    let isPresented: Bool
    
    func body(content: Content) -> some View {
        if isPresented {
           return AnyView(content
                .overlay(
                    ZStack(alignment: .center) {
                        Color.red.opacity(0.69)
                            .ignoresSafeArea()
                        popUpView
                    }
                ))
        } else {
            return AnyView(content)
        }
    }
}
