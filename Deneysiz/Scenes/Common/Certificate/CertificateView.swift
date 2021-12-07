//
//  CertificateView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 30.08.2021.
//

import SwiftUI

struct CertificateView: View {
    @StateObject var viewModel: CertificateViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            NavBar
                .padding(.top)
            
            Text(viewModel.description)
                .font(.customFont(size: 14, type: .fontRegular))
                .foregroundColor(.deneysizTextColor)

            Text("leapingbunny.org")
                .font(.customFont(size: 14, type: .fontMedium))
                .foregroundColor(.deneysizOrange)
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
    }
    
    var NavBar: some View {
        CustomNavBar(
            left: {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("back")
                }
            },
            center: {
                VStack(spacing: 0) {
                    Image(viewModel.image)
                        .offset(y: -16)
                    Text(viewModel.name)
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(.deneysizTextColor)
                }
            },
            config: .init(alignment: .top)
        )
        .foregroundColor(.deneysizTextColor)
    }
}

struct CertificateView_Previews: PreviewProvider {
    static var previews: some View {
        CertificateView(viewModel: .init(certificate: .beautyWithoutBunnies))
    }
}
