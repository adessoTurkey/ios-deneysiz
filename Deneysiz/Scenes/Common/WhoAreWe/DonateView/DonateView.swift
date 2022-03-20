//
//  DonateView.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 4.07.2021.
//

import SwiftUI

struct DonateView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        CustomNavBarContainer {
            NavBar
                .padding(.horizontal, 24)
            
        } content: {
            ScrollView(.vertical, showsIndicators: false) {
                Text("how_to_donate-info_text")
                    .font(.customFont(size: 14, type: .fontRegular))
                    .foregroundColor(Color("donateText"))
                    .padding(.horizontal, 24)
                
                BankAccountView(account: .turkishLira)
                    .padding()
                
                Text("Ya da")
                    .font(.customFont(size: 14, type: .fontRegular))
                    .foregroundColor(Color("donateText"))
                    .padding(.vertical, 6)
                
                Button {
                    OpenWebsite.shared.openURL(webURL: URL(string: "https://fonzip.com/dhd/bagis"))
                } label: {
                    HStack {
                        Spacer()
                        Text("Bağış Yap")
                            .font(.customFont(size: 14, type: .fontRegular))
                        Spacer()
                    }
                    .padding()
                }
                .background(Color("orange"))
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.vertical)
                .padding(.horizontal)
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
                    Text("how_to_donate")
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


struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}
