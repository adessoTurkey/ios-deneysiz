//
//  WhoAreWeButton.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 27.06.2021.
//

import SwiftUI

enum WhoAreWeButtonType {
    
    case contactUs
    case support
    case donate
    
    var imageName: String {
        switch self {
        case .contactUs:
            return "mail"
        case .support:
            return "users"
        case .donate:
            return "heart"
        }
    }
    
    var text: String {
        switch self {
        case .contactUs:
            return "Bizimle İletişime Geç"
        case .support:
            return "Destek Ol"
        case .donate:
            return "Bağış Yap"
        }
    }
}

struct WhoAreWeButton: View {
    
    var buttonType: WhoAreWeButtonType
    @State private var isDonateViewPresented = false
    @State private var showEmailProblemAlert = false
    @State private var isSupportViewPresented = false

    var body: some View {
        
        Button(action: {
            buttonAction(for: buttonType, completion: { isWorked in
                if !isWorked {
                    showEmailProblemAlert = true
                }
            })
        }, label: {
            HStack(spacing: 20) {
                Image(buttonType.imageName)
                Text(buttonType.text)
                    .font(Font.customFont(size: 16, type: .fontRegular))
                Spacer()
            }
            .padding()
            .foregroundColor(Color.black)
            .background(Color.white.cornerRadius(8))
            .shadow(color: Color("button_shadow"), radius: 10, y: 3)
            .padding(.horizontal)
        })
        .alert(isPresented: $showEmailProblemAlert) {
            Alert(title: Text("error"),
                  message: Text("common-installMailApp"),
                  dismissButton: .default(Text("OK")))
        }
        .fullScreenCover(isPresented: $isDonateViewPresented, content: DonateView.init)
        .fullScreenCover(isPresented: $isSupportViewPresented, content: SupportView.init)
    }
    
    func buttonAction(for buttonType: WhoAreWeButtonType, completion: @escaping (Bool) -> Void) {
        switch buttonType {
        case .support:
            isSupportViewPresented.toggle()
        case .contactUs:
            EmailService.shared.sendEmail(subject: NSLocalizedString("who_are_we.email_subject", comment: ""), completion: completion)
        case .donate:
            isDonateViewPresented.toggle()
        }
    }
}


struct WhoAreWeButton_Previews: PreviewProvider {
    static var previews: some View {
        WhoAreWeButton(buttonType: .contactUs)
    }
}
