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
            return content
                .animation(isPresented ? .default : nil)
                .overlay(secretOverlay)
                .animation(.default)
                .eraseToAnyView()
    }

    @ViewBuilder private var secretOverlay: some View {
           if isPresented {
               ZStack(alignment: .center) {
                   Color.black.opacity(config.backgroundOpacitiy)
                       .ignoresSafeArea()
                       .onTapGesture(perform: {
                           popUpView.onDismiss?()
                       })
                   popUpView
               }
           }
       }
}

extension PopUpHelper {
    struct Configuration {
        var backgroundOpacitiy: Double = 0.45
    }
}
