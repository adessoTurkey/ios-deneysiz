//
//  LottieRabbit.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 21.09.2021.
//

import Lottie
import SwiftUI

struct LottieRabbit: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color.rabbitLottieBackground
                .ignoresSafeArea()
            
            Image("Splash")
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0)
            
            VStack(spacing: 10) {
                LottieView(name: "rabbit", loopMode: .loop)
                    .offset(x: 5, y: -5)
                    .scaleEffect(1.1)
                
                Image("Deneysiz")
                    .frame(height: 45)
            }
            .frame(width: 135, height: 177)
        }
    }
}

struct LottieRabbit_Previews: PreviewProvider {
    static var previews: some View {
        LottieRabbit()
    }
}
