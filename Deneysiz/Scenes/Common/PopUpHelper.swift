//
//  CustomPopUp.swift
//  OKRSwiftUIPhase1
//
//  Created by Ogulcan Keskin on 21.06.2021.
//

import SwiftUI

protocol Alertable: View {
    var onDismiss: (() -> Void)? { get }
}

struct PopUpHelper<T>: ViewModifier where T: Alertable {
    let popUpView: T
    @Binding var isPresented: Bool
    var config: Self.Configuration = .init()
    
    func body(content: Content) -> some View {
        if isPresented {
            return content
                .overlay(
                    ZStack(alignment: .center) {
                        Color.black.opacity(config.backgroundOpacitiy)
                            .ignoresSafeArea()
                            .onTapGesture(perform: {
                                popUpView.onDismiss?()
                            })
                        popUpView
                    }
                )
                .animation(.default)
                .eraseToAnyView()
        } else {
            return content
                .eraseToAnyView()
        }
    }
}

extension PopUpHelper {
    struct Configuration {
        var backgroundOpacitiy: Double = 0.45
    }
}
