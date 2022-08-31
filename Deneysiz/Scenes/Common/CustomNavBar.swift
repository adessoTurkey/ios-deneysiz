//
//  CustomNavBar.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 11.06.2021.
//

import SwiftUI

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
    @State private var centerPosition: Anchor<CGRect>?

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
                .multilineTextAlignment(.center)
                .opacity(0)

            HStack(spacing: 8) {
                left()
                    .frame(minWidth: 8)
                
                Color.clear
                    .frame(height: 10)
                    .anchorPreference(
                        key: BoundsPreferenceKey.self,
                        value: .bounds
                    ) { $0 }
                
                right()
                    .frame(minWidth: 8)
            }
        }
        .overlayPreferenceValue(BoundsPreferenceKey.self) { preferences in
                GeometryReader { geometry in
                    preferences.map { val in
                        // val: Anchor<CGRect>
                        center()                                            .multilineTextAlignment(.center)
                            .frame(width: geometry[val].width)
                            .offset(x: geometry[val].minX)
                    }
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
        @ViewBuilder right: @escaping () -> Right,
        config: Config = .init()
    ) {
        self.init(
            left: left,
            center: { EmptyView() },
            right: right,
            config: config
        )
    }
}

extension CustomNavBar where Right == EmptyView {
    init(
        @ViewBuilder left: @escaping () -> Left,
        @ViewBuilder center: @escaping () -> Center,
        config: Config = .init()
    ) {
        self.init(
            left: left,
            center: center,
            right: { EmptyView() },
            config: config
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
                    Text(LocalizedStringKey(InfoView.Detail.animalLab.title))
                        .font(.customFont(size: 24, type: .fontExtraBold))


                },
                config: .init(isCenterMultiline: true)
            )
            .foregroundColor(.deneysizTextColor)
            .padding(.bottom, 24)
            .padding(.top)
            .padding(.horizontal, 26)
            .environment(\.locale, .init(identifier: "en"))
            Spacer()
            
        }
    }
}

struct BoundsPreferenceKey: PreferenceKey {
    typealias Value = Anchor<CGRect>?

    static var defaultValue: Value = nil

    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value = nextValue()
    }
}
