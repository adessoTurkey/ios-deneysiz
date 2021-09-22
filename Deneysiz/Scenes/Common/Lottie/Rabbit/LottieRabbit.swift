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
        ZStack {
        
            Color.rabbitLottieBackground
                .ignoresSafeArea()
            
            LottieView(name: "rabbit", loopMode: .loop)
                .frame(width: 135, height: 178)
        }
    }
}

struct LottieRabbit_Previews: PreviewProvider {
    static var previews: some View {
        LottieRabbit()
    }
}
