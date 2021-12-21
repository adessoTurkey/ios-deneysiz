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
}

struct WhoAreWeButton: View {
    
    var buttonType: WhoAreWeButtonType
    @State private var isPresented = false
    @State private var showEmailProblemAlert = false

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
        })
        .alert(isPresented: $showEmailProblemAlert) {
            Alert(title: Text("who_are_we-email_problem_alert_title"),
                  message: Text("who_are_we-email_problem_alert_text"),
                  dismissButton: .default(Text("who_are_we-email_problem_alert_dismiss_text")))
        }
        .fullScreenCover(isPresented: $isPresented, content: DonateView.init)
        .foregroundColor(Color.black)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color("button_shadow"), radius: 10, y: 3)
        .padding(.horizontal)
    }
    
    func buttonAction(for buttonType: WhoAreWeButtonType, completion: @escaping (Bool) -> Void) {
        switch buttonType {
        case .beVolunteer:
            EmailService.shared.sendEmail(subject: "hello", body: "this is body", mailTo: "iletisim@deneyehayir.org", completion: completion)
        case .contactUs:
            EmailService.shared.sendEmail(subject: "hello", body: "this is body", mailTo: "iletisim@deneyehayir.org", completion: completion)
        case .donate:
            isPresented.toggle()
        }
    }
}
