//
//  CustomNavBar.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 11.06.2021.
//

import SwiftUI

private struct FrameModifier: ViewModifier {
    let width: CGFloat
    
    func body(content: Content) -> some View {
        if width == 0 {
            return
                content
                .eraseToAnyView()
        } else {
            return
                content
                .frame(maxWidth: width)
                .eraseToAnyView()
        }
    }
}

extension CustomNavBar {
    struct Config {
        var isCenterMultiline: Bool = false
        var alignment: Alignment = .center
    }
}

struct CustomNavBar<Left, Center, Right>: View where Left: View, Center: View, Right: View {
    let left: () -> Left
    let center: () -> Center
    let right: () -> Right
    let config: Config
    
    @State private var centerWidth: CGFloat = 0
    
    init(
        @ViewBuilder left: @escaping () -> Left,
        @ViewBuilder center: @escaping () -> Center,
        @ViewBuilder right: @escaping () -> Right,
        config: Config = .init()) {
        self.left = left
        self.center = center
        self.right = right
        self.config = config
    }
    
    var body: some View {
        if self.config.isCenterMultiline {
            Calculated
        } else {
            Normal
        }
    }
    
    var Calculated: some View {
        ZStack(alignment: self.config.alignment) {
            center()
                .modifier(FrameModifier(width: self.centerWidth))
                .multilineTextAlignment(.center)
            
            HStack {
                
                left()
                    .frame(minWidth: 8)
                
                Spacer()
                    .overlay(
                        GeometryReader { middle -> Color in
                            DispatchQueue.main.async {
                                self.centerWidth = middle.size.width
                            }
                            return Color.clear
                        }
                    )
                
                right()
                    .frame(minWidth: 8)
            }
        }
    }
    
    var Normal: some View {
        ZStack(alignment: self.config.alignment) {
            HStack {
                left()
                Spacer()
            }
            center()
            HStack {
                Spacer()
                right()
            }
        }
    }
}

extension CustomNavBar where Center == EmptyView {
    init(
        @ViewBuilder left: @escaping () -> Left,
        @ViewBuilder right: @escaping () -> Right
    ) {
        self.init(
            left: left,
            center: { EmptyView() },
            right: right
        )
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            CustomNavBar(
                left: {
                    Button {
                    } label: {
                        Image("back")
                    }
                },
                center: {
                    Text("perfume")
                        .font(.title)
                        .bold()
                },
                right: {
                    Text("who-are-we")
                },
                config: .init(isCenterMultiline: true)
            )
            .foregroundColor(.deneysizTextColor)
            .padding(.bottom, 24)
            .padding(.top)
            .padding(.horizontal, 26)
            .environment(\.locale, .init(identifier: "tr"))
            Spacer()
            
        }
    }
}
