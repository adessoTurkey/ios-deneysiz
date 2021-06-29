//
//  WhoAreWeButton.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 27.06.2021.
//

import SwiftUI

enum WhoAreWeButtonType {
    
    case contactUs
    case beVolunteer
    case donate
    
    var imageName: String {
        switch self {
            case .contactUs:
                return "mail"
            case .beVolunteer:
                return "users"
            case .donate:
                return "heart"
        }
    }
    
    var text: String {
        switch self {
            case .contactUs:
                return "Bizimle İletişime Geç"
            case .beVolunteer:
                return "Gönüllümüz Ol!"
            case .donate:
                return "Bağış Yap"
        }
    }
    
    var action: () -> Void {
        switch self {
            case .contactUs:
                return {
                    print("open contactUs")
                }
            case .beVolunteer:
                return {
                    print("open beVolunteer")
                }
            case .donate:
                return {
                    print("open donate")
                }
        }
    }
}

struct WhoAreWeButton: View {
    
    var buttonType: WhoAreWeButtonType
    
    var body: some View {
        
        Button(action: buttonType.action) {
            HStack(spacing: 20) {
                Image(buttonType.imageName)
                Text(buttonType.text)
                    .font(AppFont.commonFont(fontSize: 16))
                Spacer()
            }
            .padding()
        }
        .foregroundColor(Color.black)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color("button_shadow"), radius: 8, y: 3)
        .padding(.horizontal)
    }
}
