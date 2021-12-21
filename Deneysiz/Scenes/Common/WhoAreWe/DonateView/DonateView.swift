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
        VStack {
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
                .padding()
            ScrollView(.vertical, showsIndicators: false) {
                Text("how_to_donate-info_text")
                    .font(Font.customFont(size: 14, type: .fontRegular))
                    .foregroundColor(Color("donateText"))
                    .padding()
                BankAccountView(account: .turkishLira)
                    .padding(.vertical)
                Text("Ya da")
                    .font(Font.customFont(size: 14, type: .fontRegular))
                    .foregroundColor(Color("donateText"))
                        .padding(.vertical, 6)
                Button(action: {
                    OpenWebsite.shared.openURL(webURL: URL(string: "https://fonzip.com/dhd/bagis"))
                }, label: {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                        Spacer()
                        Text("Bağış Yap")
                            .font(Font.customFont(size: 14, type: .fontRegular))
                        Spacer()
                    }) 
                    .padding()
                })
                .background(Color("orange"))
                .foregroundColor(Color.white)
                .cornerRadius(8)
                .padding(.vertical)
                .padding(.horizontal)
            }.navigationBarHidden(true)
            
        }
    }
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}
