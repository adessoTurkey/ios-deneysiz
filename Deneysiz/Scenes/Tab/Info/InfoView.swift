//
//  InfoView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 15.09.2021.
//

import SwiftUI

struct InfoView: View {
    enum Detail: String, CaseIterable {
        case sellInChina
        case animalLab
        case veganProducts
        case pointInfo
        
        var title: String {
            "\(rawValue)-title"
        }
        
        var description: String {
            "\(rawValue)-description"
        }
    }
    
    var body: some View {
        CustomNavBarContainer {
            NavBar
                .padding(.top)
        } content: {
            Group {
                TopInfo
                    .padding(.top, 4)
                
                Certificates
                    .padding(.top, 16)
                
                Curiosities
                    .padding(.top, 32)
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(Detail.allCases, id: \.self) { enumCase in
                        NavigationLink(
                            destination: {
                                InfoDetailView(titleKey: enumCase.title, descriptionKey: enumCase.description)
                            },
                            label: {
                                RoundedRectangle(cornerRadius: 8.0)
                                    .foregroundColor(Color.certificateRectangleBackground)
                                    .shadow(color: Color.certificateShadowTemp, radius: 10, y: 8)
                                    .overlay(
                                        HStack {
                                            Text(LocalizedStringKey(enumCase.title))
                                            Spacer()
                                            Image("arrowRight")
                                        }
                                            .padding(.horizontal, 16)
                                    )
                                    .frame(height: 58)
                            })
                    }
                    .font(.customFont(size: 17, type: .fontRegular))
                    .foregroundColor(.deneysizTextColor)
                    .padding(.top, 16)
                }
            }
            .spacing(12)
        }
        .padding(.horizontal, 24)
    }
    
    var NavBar: some View {
        CustomNavBar(
            left: {
                Text("do_you_know.question_mark")
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
        Text("do_you_know.top_info")
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
        VStack(alignment: .leading, spacing: 12) {
            Text("info-curious")
                .font(.customFont(size: 20, type: .fontBold))
                .foregroundColor(.deneysizTextColor)
            
            Text("do_you_know.curiosities_description")
                .font(.customFont(size: 14, type: .fontRegular))
                .foregroundColor(.deneysizTextColor)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .environment(\.locale, .init(identifier: "tr"))
    }
}
