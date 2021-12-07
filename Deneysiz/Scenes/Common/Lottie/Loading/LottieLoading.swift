//
//  LottieRabbit.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 21.09.2021.
//

import Lottie
import SwiftUI

struct LottieLoading: View, Alertable {
    var onDismiss: (() -> Void)?
    
    var body: some View {
        ZStack {
            LottieView(name: "loading-lottie", loopMode: .loop)
                .frame(width: 135, height: 178)
        }
    }
}

struct LottieLoading_Previews: PreviewProvider {
    static var previews: some View {
        LottieLoading()
    }
}
