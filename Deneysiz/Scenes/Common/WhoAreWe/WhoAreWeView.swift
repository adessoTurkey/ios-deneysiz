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
                    .font(.customFont(size: 16, type: .fontRegular))
                    .padding(.horizontal)
                
                if let url = URL(string: "https://www.deneysiz.org/") {
                    HStack {
                        Link("deneysiz_app_website_link", destination: url)
                            .font(.customFont(size: 16, type: .fontRegular))
                            .foregroundColor(Color("orange"))
                            .font(.body)
                        Spacer()
                    }
                    .padding()
                }
                
                Group {
                    WhoAreWeButton(buttonType: .contactUs)
                    WhoAreWeButton(buttonType: .beVolunteer)
                    WhoAreWeButton(buttonType: .donate)
                }
                
                HStack {
                    Text("who_are_we-title")
                        .font(.customFont(size: 16, type: .fontRegular))
                    Spacer()
                }.padding()
                
                HStack(spacing: 16) {
                    SocialMediaButton(socialMedia: .twitter)
                    SocialMediaButton(socialMedia: .instagram)
                    SocialMediaButton(socialMedia: .youtube)
                    SocialMediaButton(socialMedia: .facebook)
                }
                .padding(.horizontal)
                Spacer()
            }
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
                Text("who_are_we-title")
                    .font(.title)
                    .bold()
            },
            right: {
            })
            .foregroundColor(.deneysizTextColor)
            .padding()
    }
}

struct WhoAreWeView_Previews: PreviewProvider {
    static var previews: some View {
        WhoAreWeView()
    }
}
