//
//  InfoView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 15.09.2021.
//

import SwiftUI

struct InfoView: View {
    
    private let details: [String] = [
        "Deneysiz Markalar",
        "Vegan Ürünler",
        "Çin’de Satış"
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavBar
                .padding(.top)
            
            TopInfo
                .padding(.top, 4)

            Certificates
                .padding(.top, 16)
            
            Curiosities
                .padding(.top, 32)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(details, id: \.self) {
                    getNavigationLink($0, Text($0).eraseToAnyView())
                }
                .font(.customFont(size: 17, type: .fontRegular))
                .foregroundColor(.deneysizTextColor)
                .padding(.top, 16)
            }

            Spacer()
        }
        .padding(.horizontal, 24)
        
    }
    
    var NavBar: some View {
        CustomNavBar(
            left: {
                Text("tab-info")
                    .font(.customFont(size: 24, type: .fontBold))
                    .foregroundColor(.deneysizTextColor)
            },
            right: {
                NavigationLink(
                    destination: WhoAreWeView(),
                    label: {
                        HStack(spacing: 4) {
                            Text("who-are-we")
                                .font(.customFont(size: 14, type: .fontMedium))
                                .foregroundColor(.deneysizBlueTextColor)
                            Image("Group")
                        }
                    })
            })
            .foregroundColor(.deneysizTextColor)
    }
    
    var TopInfo: some View {
        Text("Deutsches Ipsum Dolor quo lucilius Freude schöner Götterfunken at, adhuc laboramus")
            .font(.customFont(size: 14, type: .fontRegular))
            .foregroundColor(.deneysizTextColor)
    }
    
    var Certificates: some View {
        ForEach(Certificate.dummies.chunked(into: 2), id: \.self) { certs in
            HStack {
                ForEach(certs) { cert in
                    NavigationLink(
                        destination: CertificateView(viewModel: .init(certificate: cert)),
                        label: {
                            RoundedRectangle(cornerRadius: 8.0)
                                .foregroundColor(Color.certificateRectangleBackground)
                                .shadow(color: Color.certificateShadowTemp, radius: 10, y: 8)
                                .overlay(
                                    Image("\(cert.id)-rectangle")
                                )
                        })
                }
            }
            .frame(height: 100)
        }
    }
    
    var Curiosities: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("info-curious")
                .font(.customFont(size: 20, type: .fontBold))
                .foregroundColor(.deneysizTextColor)
            
            Text("Deutsches Ipsum Dolor quo lucilius Freude schöner Götterfunken at, adhuc laboramus sadipscing per")
                .font(.customFont(size: 14, type: .fontRegular))
                .foregroundColor(.deneysizTextColor)
        }
    }
        
    func getNavigationLink(_ text: String, _ destination: AnyView) -> AnyView {
        NavigationLink(
            destination: destination,
            label: {
                RoundedRectangle(cornerRadius: 8.0)
                    .foregroundColor(Color.certificateRectangleBackground)
                    .shadow(color: Color.certificateShadowTemp, radius: 10, y: 8)
                    .overlay(
                        HStack {
                            Text(text)
                            Spacer()
                            Image("arrowRight")
                        }
                        .padding(.horizontal, 16)
                    )
                    .frame(height: 58)
            })
            .eraseToAnyView()
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .environment(\.locale, .init(identifier: "tr"))
    }
}
