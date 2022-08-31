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
    // For fixing navigation link stuck error. add tag & selection
    @State private var infoViewNavigationSelection: String?
    
    var body: some View {
        CustomNavBarContainer {
            NavBar
                .padding(.horizontal, 24)
        } content: {
            VStack(alignment: .leading, spacing: 0) {
                TopInfo
                    .padding(.top, 4)
                    .padding(.horizontal, 24)

                Certificates
                    .padding(.top, 16)
                    .padding(.horizontal, 24)
                
                Curiosities
                    .padding(.top, 32)
                    .padding(.horizontal, 24)
                
                AdditionalInfos
                    .padding(.top, 16)
            }
            .navBarTopSpacing(12)
        }
    }
    
    var NavBar: some View {
        CustomNavBar(
            left: {
                Text("do_you_know.question_mark")
                    .font(.customFont(size: 24, type: .fontExtraBold))
                    .foregroundColor(.deneysizTextColor)
            },
            right: {
                NavigationLink(
                    destination: WhoAreWeView(),
                    tag: "who-are-we",
                    selection: $infoViewNavigationSelection,
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
                        tag: cert.id,
                        selection: $infoViewNavigationSelection,
                        label: {
                            RoundedRectangle(cornerRadius: 8.0)
                                .foregroundColor(Color.certificateRectangleBackground)
                                .shadow(color: Color.certificateShadowTemp, radius: 10, y: 8)
                                .overlay(
                                    Image("\(cert.name)-rectangle")
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
                .font(.customFont(size: 24, type: .fontExtraBold))
                .foregroundColor(.deneysizTextColor)
            
            Text("do_you_know.curiosities_description")
                .font(.customFont(size: 14, type: .fontRegular))
                .foregroundColor(.deneysizTextColor)
        }
    }
    
    var AdditionalInfos: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                ForEach(Detail.allCases, id: \.self) { enumCase in
                    NavigationLink(
                        destination:
                            InfoDetailView(titleKey: enumCase.title, descriptionKey: enumCase.description),
                        tag: enumCase.title,
                        selection: $infoViewNavigationSelection,
                        label: {
                            RoundedRectangle(cornerRadius: 8.0)
                                .foregroundColor(Color.certificateRectangleBackground)
                                .shadow(color: Color.certificateShadowTemp, radius: 10, y: 0)
                                .overlay(
                                    HStack {
                                        Text(LocalizedStringKey(enumCase.title))
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                        Image("arrowRight")
                                    }
                                        .padding(.horizontal, 16)
                                )
                                .frame(height: 58)
                        }
                    )
                    .padding(.horizontal, 24)
                }
                .font(.customFont(size: 17, type: .fontRegular))
                .foregroundColor(.deneysizTextColor)
            }
            .padding(.vertical, 4)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .environment(\.locale, .init(identifier: "tr"))
    }
}
