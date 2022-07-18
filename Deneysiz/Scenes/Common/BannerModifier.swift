//
//  BannerModifier.swift
//  Deneysiz
//
//  Created by ogulcan keskin on 18.07.2022.
//

import SwiftUI

struct BannerModifier: ViewModifier {
    struct BannerData {
        let title: String
    }
    
    @Binding var data: BannerData
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                VStack {
                    Text(data.title)
                        .foregroundColor(.primary)
                        .padding([.top, .bottom], 16)
                        .padding([.leading, .trailing], 40)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(Capsule())
                    
                    Spacer()
                }
                .animation(.easeInOut)
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isPresented = false
                        }
                    }
                })
            }
        }
    }
}

extension View {
    func banner(data: Binding<BannerModifier.BannerData>, isPresented: Binding<Bool>) -> some View {
        self.modifier(BannerModifier(data: data, isPresented: isPresented))
    }
}

struct BannerModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello")
        }
        .banner(data: .constant(.init(title: "ASFASFASF")), isPresented: .constant(true))
    }
}
