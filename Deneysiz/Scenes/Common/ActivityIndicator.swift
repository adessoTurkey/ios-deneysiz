//
//  ActivityIndicator.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 3.07.2021.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable, Alertable {
    var onDismiss: (() -> Void)?
    var isAnimating: Bool
    var configuration: ((UIView) -> Void)

    typealias UIView = UIActivityIndicatorView

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}

extension View where Self == ActivityIndicator {
    func configure(_ configuration: @escaping (Self.UIView) -> Void) -> Self {
        Self.init(isAnimating: self.isAnimating, configuration: configuration)
    }
}
