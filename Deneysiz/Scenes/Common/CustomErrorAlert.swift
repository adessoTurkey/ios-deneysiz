//
//  CustomErrorView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 16.08.2021.
//

import SwiftUI

struct CustomErrorAlert: Alertable {
    let config: Config
    var onDismiss: (() -> Void)?
    var onButtonClick: (() -> Void)?

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                
                ZStack {
                    Image("error-circle")
                        .resizable()
                        .frame(width: 96, height: 96)
                        .overlay(
                            Image(config.overlayImage)
                                .resizable()
                                .offset(y: -4)
                                .scaleEffect(0.5)
                        )
                }
                .offset(y: -(96 / 2))
                .zIndex(1.0)
                
                VStack(spacing: 0) {
                    Text(config.title)
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(.deneysizTextColor)
                    
                    Text(config.description)
                        .multilineTextAlignment(.center)
                        .font(.customFont(size: 14))
                        .foregroundColor(.deneysizTextColor)
                        .padding(.top, 4)

                    Button(action: { onButtonClick?() }, label: {
                        Text(config.buttonDescription)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: geo.size.width - 96, height: 42)
                            .background(Color.deneysizOrange.cornerRadius(8))
                    })
                    .padding(.top, 24)

                }
                .frame(width: geo.size.width - 96)
                .padding(.top, 56)
                .padding(.bottom, 24)
                .padding(.horizontal)
                .background(Color.white.cornerRadius(12))
            }
            .frame(width: geo.size.width,
                   height: geo.size.height,
               alignment: .center)
        }
    }
}

extension CustomErrorAlert {
    struct Config {
        var overlayImage, title, description, buttonDescription: String
    }
}

extension CustomErrorAlert.Config {
    static let noInternet: CustomErrorAlert.Config = .init(
        overlayImage: "wi-fi",
        title: "Internet Yok",
        description: "Şu anda internet bağlantınızla ilgili bir sorun yaşanıyor.",
        buttonDescription: "Tekrar Dene")
    
    static let operationFail: CustomErrorAlert.Config = .init(
        overlayImage: "smartphone",
        title: "İşlem Hatası",
        description: "Lütfen daha sonra tekrar deneyin.",
        buttonDescription: "Tekrar Dene")
}

struct CustomErrorView_Previews: PreviewProvider {
    static var previews: some View {
        CustomErrorAlert(config: .operationFail)
    }
}
