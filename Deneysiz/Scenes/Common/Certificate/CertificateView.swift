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
        CustomNavBarContainer {
            NavBar

        } content: {
            ScrollView(.vertical, showsIndicators: false) {
                Text(viewModel.description)
                    .font(.customFont(size: 14, type: .fontRegular))
                    .foregroundColor(.deneysizTextColor)
                    .padding(.horizontal)

                HStack {
                    if #available(iOS 15.0, *) {
                        Text(viewModel.websiteUrl)
                            .font(.customFont(size: 14, type: .fontMedium))
                            .tint(.deneysizOrange)
                            .padding(.top)
                    } else {
                        Text(viewModel.websiteUrl)
                            .font(.customFont(size: 14, type: .fontMedium))
                            .padding(.top)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                if case let .peta(petacerts) = viewModel.viewType {
                    HStack {
                        Text("beauty_without_bunnies.inner_title")
                            .font(.customFont(size: 20, type: .fontBold))
                            .foregroundColor(.deneysizTextColor)
                        Spacer()
                    }
                    .padding()

                    Text("beauty_without_bunnies.logos")
                        .font(.customFont(size: 14, type: .fontRegular))
                        .foregroundColor(.deneysizTextColor)
                    
                    HStack {
                        ForEach(petacerts, id: \.self) {
                            Image($0)
                                .frame(width: 60, height: 60)
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .navBarTopSpacing(16)
        }
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
                VStack(spacing: -8) {
                    HStack(alignment: .top) {
                        ForEach(viewModel.headerImage, id: \.self) { image in
                            Image(image)
                        }
                    }
                    Text(viewModel.title)
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(.deneysizTextColor)
                }
                .offset(y: -16)
            },
            config: .init(alignment: .top)
        )
        .foregroundColor(.deneysizTextColor)
        .padding(.horizontal)
        .padding(.top)
    }
}

struct CertificateView_Previews: PreviewProvider {
    static var previews: some View {
        CertificateView(viewModel: .init(certificate: .vlabelCert))
    }
}
