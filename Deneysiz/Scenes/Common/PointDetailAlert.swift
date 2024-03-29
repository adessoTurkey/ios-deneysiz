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

    @State private var contentSize: CGSize = .zero

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                ZStack {
                    Image(config.overlayImage)
                        .resizable()
                        .frame(width: 96, height: 96)
                }
                .offset(y: -(96 / 2))
                .zIndex(1.0)
                
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {
                            onDismiss?()
                        }, label: {
                            Image("dismiss")
                        })
                    }
                    .padding(.horizontal, 22)
                    createPointCapsule(config.point)
                    
                    Text(LocalizedStringKey(config.description))
                        .multilineTextAlignment(.center)
                        .font(.customFont(size: 14))
                        .foregroundColor(.deneysizTextColor)
                        .padding(.top, 8)
                        .padding(.horizontal, 4)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(config.details) { detail in
                                VStack(alignment: .leading) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(detail.localizedKey)
                                                .lineLimit(nil)
                                                .font(.customFont(size: 17))
                                                .foregroundColor(.deneysizTextColor)
                                            Spacer()
                                            Text(detail.point)
                                                .lineLimit(1)
                                                .font(.customFont(size: 14, type: .fontMedium))
                                                .foregroundColor(.white)
                                                .padding(.vertical, 6)
                                                .padding(.horizontal, 8)
                                                .frame(minWidth: 75)
                                                .background(detail.color.cornerRadius(8))
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
                        .overlay(
                            GeometryReader { geo in
                                Color.clear
                                    .onAppear {
                                        contentSize = geo.size
                                    }
                            }
                        )
                    }
                    .frame(maxHeight: min(contentSize.height, geo.size.height))
                }
                .frame(width: geo.size.width - 96)
                .padding(.top, 22)
                .padding(.bottom, 24)
                .background(Color.white.cornerRadius(12))
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: geo.size.height, alignment: .center)
        }
    }
    
    func createPointCapsule(_ point: Int) -> some View {
        Text("\(point)/10")
            .lineLimit(1)
            .font(.customFont(size: 14, type: .fontMedium))
            .foregroundColor(.white)
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
            .frame(minWidth: 75)
            .background(Color.calculateColor(point).cornerRadius(8))
    }
}

extension PointDetailAlert {
    struct Config {
        let overlayImage, description: String
        let point: Int
        let details: [BrandPointDetailUIModel]
    }
}

extension PointDetailAlert.Config {
    static let dummy: PointDetailAlert.Config = .init(
        overlayImage: "points",
        description: "lorem ipsum dior miorlorem ipsum dior miorlorem ipsum dior miorlorem ipsum dior miorlorem ipsum dior miorlorem ipsum dior mior", point: 9,
        details: [
            .init(name: "Marka Deneysizasflkajwfklawnflkawfkalw;ngawklgnawklgnalkgnawkgjnawgkjanwgkagnwljga", point: "4", state: "Evet", color: .green),
            .init(name: "Çatı Marka Deneysiz", point: "3", state: "Hayır", color: .green),
            .init(name: "Marka Vegan", point: "3", state: "Hayır", color: .green),
            .init(name: "Çin’de Satış", point: "1", state: "Evet", color: .green)
        ])
}

struct PointDetailAlert_Previews: PreviewProvider {
    static var previews: some View {
        PointDetailAlert(config: .dummy)
    }
}
