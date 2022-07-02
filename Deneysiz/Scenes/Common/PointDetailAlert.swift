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
                    
                    Text(config.description)
                        .multilineTextAlignment(.center)
                        .font(.customFont(size: 14))
                        .foregroundColor(.deneysizTextColor)
                        .padding(.top, 8)
                    
                    ForEach(config.details) { detail in
                        VStack(alignment: .leading) {
                            Group {
                                HStack {
                                    Text(detail.localizedKey)
                                        .lineLimit(nil)
                                        .font(.customFont(size: 17))
                                        .foregroundColor(.deneysizTextColor)
                                    Spacer()
                                    Text(detail.point)
                                        .font(.customFont(size: 14, type: .fontMedium))
                                        .foregroundColor(.white)
                                        .frame(width: 50)
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 8)
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
    
    func createPointCapsule(_ point: Int) -> some View {
        Text("\(point)/10")
            .font(.customFont(size: 14, type: .fontMedium))
            .foregroundColor(.white)
            .frame(width: 50)
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
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

#if DEBUG
extension PointDetailAlert.Config {
    static let dummy: PointDetailAlert.Config = .init(
        overlayImage: "points",
        description: "lorem ipsum dior miorlorem ipsum dior miorlorem ipsum dior miorlorem ipsum dior miorlorem ipsum dior miorlorem ipsum dior mior", point: 9,
        details: [
            .init(name: "Marka Deneysizasflkajwfklawnflkawfkalw;ngawklgnawklgnalkgnawkgjnawgkjanwgkagnwljga", point: "4", state: "Evet", color: .green),
            .init(name: "Çatı Marka Deneysiz", point: "3", state: "Hayir", color: .green),
            .init(name: "Marka Vegan", point: "3", state: "Hayir", color: .green),
            .init(name: "Çin’de Satış", point: "1", state: "Evet", color: .green)
        ])
}

struct PointDetailAlert_Previews: PreviewProvider {
    static var previews: some View {
        PointDetailAlert(config: .dummy)
    }
}
#endif
