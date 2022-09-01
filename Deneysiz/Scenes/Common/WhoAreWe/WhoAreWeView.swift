//
//  WhoAreWeView.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 27.06.2021.
//

import SwiftUI

struct WhoAreWeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        CustomNavBarContainer {
            NavBar
        } content: {
            ScrollView(.vertical, showsIndicators: false) {
                Text("who_are_we-info_text")
                    .font(.customFont(size: 14, type: .fontRegular))
                    .foregroundColor(Color("donateText"))
                    .padding(.horizontal)
                
                if let url = URL(string: "https://www.deneyehayir.org/") {
                    HStack {
                        Link("deneysiz_app_website_link", destination: url)
                            .font(.customFont(size: 14, type: .fontRegular))
                            .foregroundColor(Color("orange"))
                        Spacer()
                    }
                    .padding()
                }
                
                Group {
                    WhoAreWeButton(buttonType: .contactUs)
                    WhoAreWeButton(buttonType: .support)
                    WhoAreWeButton(buttonType: .donate)
                }
                
                HStack {
                    Text("who_are_we-title")
                        .font(.customFont(size: 14, type: .fontRegular))
                    Spacer()
                }.padding()
                
                HStack(spacing: 16) {
                    SocialMediaButton(socialMedia: .twitter)
                    SocialMediaButton(socialMedia: .instagram)
                    SocialMediaButton(socialMedia: .youtube)
                    SocialMediaButton(socialMedia: .facebook)
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
            .navBarTopSpacing(16)
        }
    }
    
    private var NavBar: some View {
        CustomNavBar(
            left: {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("back")
                })
            },
            center: {
                VStack(spacing: 12) {
                    Image("deneysizLogo")
                    Text("who_are_we-title")
                        .font(.customFont(size: 24, type: .fontExtraBold))
                }
            },
            right: {
            },
            config: .init(alignment: .top)
        )
        .foregroundColor(.deneysizTextColor)
        .padding(.horizontal)
    }
}

struct WhoAreWeView_Previews: PreviewProvider {
    static var previews: some View {
        WhoAreWeView()
    }
}
