//
//  PointDetailAlert.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 16.08.2021.
//

import SwiftUI

struct PointDetailAlert: Alertable {
    var onDismiss: (() -> Void)?
    let config: Config
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
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            onDismiss?()
                        }, label: {
                            Image("x")
                        })
                    }
                    .padding(.horizontal, 22)
                    createPointCapsule(config.point)
                    
                    Text(config.description)
                        .multilineTextAlignment(.center)
                        .font(.customFont(size: 14))
                        .foregroundColor(.deneysizTextColor)
                        .padding(.top, 8)
                    
                    ForEach(config.details) { detail in
                        VStack(alignment: .leading) {
                            Group {
                                HStack {
                                    Text(detail.name)
                                        .font(.customFont(size: 17))
                                        .foregroundColor(.deneysizTextColor)
                                    Spacer()
                                    createPointCapsule(detail.point)
                                }
                                Text(detail.state)
                                    .font(.customFont(size: 14))
                                    .foregroundColor(.deneysizText2Color)
                            }
                            .padding(.horizontal, 16)

                            Divider()
                        }
                        .padding(.top, 10)
                    }
                }
                .frame(width: geo.size.width - 96)
                .padding(.top, 22)
                .padding(.bottom, 24)
                .background(Color.white.cornerRadius(12))
            }
            .frame(width: geo.size.width,
                   height: geo.size.height,
                   alignment: .center)
        }
    }
    
    func createPointCapsule(_ point: String) -> some View {
        Text("\(point)/10")
            .font(.customFont(size: 14, type: .fontMedium))
            .foregroundColor(.white)
            .frame(width: 50)
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
            .background(Color.calculateColor(Int(point) ?? 0).cornerRadius(8))
    }
}

extension PointDetailAlert {
    struct Config {
        var overlayImage, point, description: String
        let details: [BrandPointDetail]
    }
}

extension PointDetailAlert.Config {
    static let dummy: PointDetailAlert.Config = .init(
        overlayImage: "points",
        point: "9",
        description: "lorem ipsum dior miorlorem ipsum dior miorlorem ipsum dior miorlorem ipsum dior miorlorem ipsum dior miorlorem ipsum dior mior",
        details: [
            .init(name: "Marka Deneysiz", point: "4", state: "Evet"),
            .init(name: "Çatı Marka Deneysiz", point: "3", state: "Hayir"),
            .init(name: "Marka Vegan", point: "3", state: "Hayir"),
            .init(name: "Çin’de Satış", point: "1", state: "Evet")
        ])
}

struct PointDetailAlert_Previews: PreviewProvider {
    static var previews: some View {
        PointDetailAlert(config: .dummy)
    }
}
