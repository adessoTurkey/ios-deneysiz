//
//  LottieEmpty.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 21.09.2021.
//

import SwiftUI

struct LottieEmpty: View {
    var body: some View {
        LottieView(name: "empty", loopMode: .loop)
    }
}

struct LottieEmpty_Previews: PreviewProvider {
    static var previews: some View {
        LottieEmpty()
    }
}
