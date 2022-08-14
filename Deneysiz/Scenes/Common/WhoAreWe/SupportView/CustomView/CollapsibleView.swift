//
//  CollapsibleView.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 7.07.2022.
//

import SwiftUI

struct CollapsibleView<Content: View>: View {
    @State var label: () -> Text
    @State var content: () -> Content
    
    @State private var collapsed: Bool = true
    
    var body: some View {
        VStack {
            Button(
                action: { self.collapsed.toggle() },
                label: {
                    HStack {
                        self.label()
                        Spacer()
                        Image(self.collapsed ? "collapseDown" : "collapseUp")
                    }
                    .padding(.bottom, 1)
                }
            )
            VStack {
                self.content()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
            .clipped()
            .animation(.easeOut)
            .transition(.slide)
        }.padding(16)
            .background(Color("textForegroundWhite"))
            .border(Color("border"), width: 2)
            .cornerRadius(8)
    }
}
