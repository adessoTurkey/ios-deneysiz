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
struct CustomNavBar<Left, Center, Right>: View where Left: View, Center: View, Right: View {
    let left: () -> Left
    let center: () -> Center
    let right: () -> Right
    let isCenterMultiline: Bool
    @State private var centerWidth: CGFloat = 0
    
    init(
        @ViewBuilder left: @escaping () -> Left,
        @ViewBuilder center: @escaping () -> Center,
        @ViewBuilder right: @escaping () -> Right,
        isCenterMultiline: Bool = true) {
        self.left = left
        self.center = center
        self.right = right
        self.isCenterMultiline = isCenterMultiline
    }
    
    var body: some View {
        if isCenterMultiline {
            calculated
        } else {
            normal
        }
    }
    
    var calculated: some View {
        var actualWidth: CGFloat = 0
        return ZStack {
            
            center()
                .modifier(FrameModifier(width: self.centerWidth))
                .multilineTextAlignment(.center)
            
            HStack {
                left()
                    .frame(minWidth: 8)
                    .overlay(
                        GeometryReader { left -> Color in
                            DispatchQueue.main.async {
                                actualWidth -= left.size.width
                            }
                            return Color.clear
                        }
                    )
                
                Spacer()
                
                right()
                    .frame(minWidth: 8)
                    .overlay(
                        GeometryReader { right -> Color in
                            DispatchQueue.main.async {
                                actualWidth -= right.size.width
                            }
                            return Color.clear
                        }
                    )
                
            }
        }
        .overlay(
            GeometryReader { geo -> Color in
                actualWidth += geo.size.width
                return .clear
            })
        .onAppear(perform: {
            if centerWidth == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    centerWidth = actualWidth - 8
                }
            }
        })
    }
    
    var normal: some View {
        ZStack {
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

/*struct CustomNavBar_Previews: PreviewProvider {

    static var previews: some View {
        CustomNavBar()
            .environment(\.locale, .init(identifier: "tr"))

    }
}*/
