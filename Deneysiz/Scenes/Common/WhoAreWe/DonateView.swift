//
//  DonateView.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 4.07.2021.
//

import SwiftUI

struct DonateView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Dismiss Modal") {
            presentationMode.wrappedValue.dismiss()
        }.background(Color.red)
    }
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}
