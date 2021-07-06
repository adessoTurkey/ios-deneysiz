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
