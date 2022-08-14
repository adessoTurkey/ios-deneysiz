//
//  CustomNavBarContainer.swift
//  Deneysiz
//
//  Created by ogulcan keskin on 20.03.2022.
//

import SwiftUI

private struct SpacingSizeKey: FloatPreferenceKey {
    static var defaultValue: CGFloat {
        20
    }
}

private struct HorizontalAlignmentKey: HorizontalAlignmentPreferenceKey {
    static var defaultValue: HorizontalAlignment {
        .center
    }
}

struct CustomNavBarContainer<NavBar: View, Content: View>: View {
    @State private var spacing: CGFloat = 20
    @State private var horizontalAlignment: HorizontalAlignment = .center
    
    let navbar: NavBar
    let content: Content
    
    init (
        @ViewBuilder navbar: @escaping () -> NavBar,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.navbar = navbar()
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: horizontalAlignment, spacing: spacing) {
            navbar
            VStack(spacing: 0) {
                content
                    .navigationBarHidden(true)
                Spacer()
            }
        }
        .onPreferenceChange(SpacingSizeKey.self) {
            self.spacing = $0
        }
        .onPreferenceChange(HorizontalAlignmentKey.self) {
            self.horizontalAlignment = $0
        }
    }
}

struct CustomNavBarContainer_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarContainer {
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
                .padding(.horizontal, 24)
        } content: {
            Group {
                Text("Blop")
                    .foregroundColor(.black)
                Text("Blop")
                    .foregroundColor(.black)
            }
            .navBarTopSpacing(0)
        }
        
    }
}

// MARK: Add keys
extension View {
    func navBarTopSpacing(_ value: CGFloat) -> some View {
        preference(key: SpacingSizeKey.self, value: value)
    }
    
    func navBarAlignment(_ value: HorizontalAlignment) -> some View {
        preference(key: HorizontalAlignmentKey.self, value: value)
    }
}
