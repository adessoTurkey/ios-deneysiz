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
        VStack {
            CustomNavBar(
                left: {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("back")
                    }
                },
                center: {
                    Text("who_are_we-title")
                        .font(.title)
                        .bold()
                },
                right: {
                })
                .padding()
            ScrollView(.vertical, showsIndicators: false) {
                
                Text("who_are_we-info_text")
                    .font(Font.customFont(size: 16, type: .fontRegular))
                    .padding(.horizontal)
                HStack {
                    Text("deneysiz.org")
                        .font(Font.customFont(size: 16, type: .fontRegular))
                        .foregroundColor(Color("orange"))
                        .font(.body)
                    Spacer()
                }.padding()
                Group {
                    WhoAreWeButton(buttonType: .contactUs)
                    WhoAreWeButton(buttonType: .beVolunteer)
                    WhoAreWeButton(buttonType: .donate)
                }
                HStack {
                    Text("who_are_we-title")
                        .font(Font.customFont(size: 16, type: .fontRegular))
                    Spacer()
                }.padding()
                HStack(spacing: 16) {
                    SocialMediaButton(socialMediaType: .twitter)
                    SocialMediaButton(socialMediaType: .instagram)
                    SocialMediaButton(socialMediaType: .youtube)
                    SocialMediaButton(socialMediaType: .facebook)

                }.padding(.horizontal)
                Spacer()
            }.navigationBarHidden(true)
            
        }
    }
}

struct WhoAreWeView_Previews: PreviewProvider {
    static var previews: some View {
        WhoAreWeView()
    }
}
