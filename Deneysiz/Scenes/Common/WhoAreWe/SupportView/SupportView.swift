//
//  SupportView.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 6.07.2022.
//

import SwiftUI

struct SupportView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        CustomNavBarContainer {
            NavBar
                .padding(.horizontal, 24)
            
        } content: {
            ScrollView(.vertical, showsIndicators: false) {
                Text("support.info_text")
                    .font(.customFont(size: 14, type: .fontRegular))
                    .foregroundColor(Color("donateText"))
                    .padding(.horizontal, 24)
                
                VStack(spacing: 16) {
                    
                    CollapsibleView (
                        label: { Text("support.share_title")
                                .font(.customFont(size: 16, type: .fontSemiBold))
                            .foregroundColor(Color("donateText")) },
                        content: {
                            VStack {
                                Text("support.share_description")
                                    .font(.customFont(size: 14, type: .fontRegular))
                                    .foregroundColor(Color("gray"))
                                    .padding(6)
                                
                                HStack(spacing: 16) {
                                    SocialMediaButton(socialMedia: .twitter)
                                    SocialMediaButton(socialMedia: .instagram)
                                    SocialMediaButton(socialMedia: .youtube)
                                    SocialMediaButton(socialMedia: .facebook)
                                }.padding(6)
                            }
                        }
                    )
                    
                    CollapsibleView (
                        label: { Text("support.donate_title")
                                .font(.customFont(size: 16, type: .fontSemiBold))
                            .foregroundColor(Color("donateText")) },
                        content: {
                            HStack {
                                Text("support.donate_description")
                                    .font(.customFont(size: 14, type: .fontRegular))
                                    .foregroundColor(Color("gray"))
                                    .padding(6)
                                Spacer()
                            }
                        }
                    )
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .spacing(20)
        }
    }
    
    private var NavBar: some View {
        CustomNavBar(
            left: {
            },
            center: {
                VStack {
                    Image("questionMark")
                    Text("support.title")
                        .font(.title)
                        .bold()
                }
            },
            right: {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("dismiss")
                })
            })
    }
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}
