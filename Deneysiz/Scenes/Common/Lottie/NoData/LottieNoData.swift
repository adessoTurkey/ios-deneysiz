//
//  LottieNoData.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 21.09.2021.
//

import SwiftUI

struct LottieNoData: View, Alertable {
    var onDismiss: (() -> Void)?

    var body: some View {
        LottieView(name: "noData", loopMode: .loop)
            .frame(width: 175, height: 175)
    }
}

struct LottieNoData_Previews: PreviewProvider {
    static var previews: some View {
        LottieNoData()
    }
}
