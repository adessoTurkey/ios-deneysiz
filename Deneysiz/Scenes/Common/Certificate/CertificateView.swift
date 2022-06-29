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
                .padding(.top)
            
        } content: {
            VStack(alignment: .leading, spacing: 16) {
                Text(viewModel.description)
                    .font(.customFont(size: 14, type: .fontRegular))
                    .foregroundColor(.deneysizTextColor)

                Text(viewModel.websiteUrl)
                    .font(.customFont(size: 14, type: .fontMedium))
                    .foregroundColor(.deneysizOrange)
                
                if case let .peta(petacerts) = viewModel.viewType {
                    Text(viewModel.description)
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(.deneysizTextColor)
                    
                    Text(viewModel.description)
                        .font(.customFont(size: 14, type: .fontRegular))
                        .foregroundColor(.deneysizTextColor)
                    
                    HStack {
                        ForEach(petacerts, id: \.self) {
                            Image($0)
                                .frame(minWidth: 60, minHeight: 60)
                        }
                        
                    }
                }
            }
            .alignment(.leading)
            .spacing(20)
        }
        .padding(.horizontal, 24)
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
                    Image(viewModel.image)
                        
                    Text(viewModel.title)
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(.deneysizTextColor)
                }
                .offset(y: -16)
            },
            config: .init(alignment: .top)
        )
        .foregroundColor(.deneysizTextColor)
    }
}

struct CertificateView_Previews: PreviewProvider {
    static var previews: some View {
        CertificateView(viewModel: .init(certificate: .leapingBunny))
    }
}
