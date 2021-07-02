//
//  FirstView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 28.05.2021.
//

import SwiftUI

struct FirstView: View {
    @ObservedObject var firstViewModel: FirstViewModel
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
            ScrollView {
                VStack {
                    ForEach(firstViewModel.exampleModel, id: \.id) { each in
                        VStack {
                            Text(each.title)
                                .padding()
                            Divider()
                        }
                    }
                }
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FirstView(firstViewModel: FirstDependencyContainer().makeFirstViewModel())
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier: "tr"))
                .previewLayout(.fixed(width: 200, height: 200))
            FirstView(firstViewModel: FirstDependencyContainer().makeFirstViewModel())
                .preferredColorScheme(.light)
                .environment(\.locale, .init(identifier: "en"))
                .previewLayout(.fixed(width: 200, height: 200))
            FirstView(firstViewModel: FirstDependencyContainer().makeFirstViewModel())
                .colorScheme(.light)
                .environment(\.locale, .init(identifier: "en"))
                .previewLayout(.device)
        }
    }
}

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
