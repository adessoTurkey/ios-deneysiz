//
//  BankAccountView.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 6.07.2021.
//

import SwiftUI

enum BankAccountType {
    
    case turkishLira
    case euro
    
    var imageName: String {
        switch self {
        case .turkishLira:
            return "turkishlira"
        case .euro:
            return "euro"
        }
    }
    
    var accountName: String {
        switch self {
        case .turkishLira:
            return "Deneye Hayır Derneği - TL"
        case .euro:
            return "Deneye Hayır Derneği - Euro"
        }
    }
    
    var branchName: String {
        switch self {
        case .turkishLira:
            return "Ziraat Bankası Fethiye/Muğla Şubesi"
        case .euro:
            return "Ziraat Bankası Fethiye/Muğla Şubesi"
        }
    }
    
    var IBAN: String {
        switch self {
        case .turkishLira:
            return "TR71 0001 0002 0391 0906 4650 02"
        case .euro:
            return "TR 7100 0100 0203 9109 0646 5002"
        }
    }
}

struct BankAccountView: View {
    
    var account: BankAccountType
    var hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        
        VStack {
            HStack {
                Image(account.imageName).padding()
                VStack(alignment: .leading, spacing: nil, content: {
                    Text(account.accountName)
                        .font(Font.customFont(size: 17, type: .fontRegular))
                        .foregroundColor(Color("donateText"))
                    Text(account.branchName)
                        .font(Font.customFont(size: 12, type: .fontRegular))
                        .foregroundColor(Color("gray"))
                })
                Spacer()
            }
            Button(action: {
                UIPasteboard.general.string = account.IBAN
                hapticImpact.impactOccurred()
            }, label: {
                HStack {
                    Text(account.IBAN)
                        .font(Font.customFont(size: 14, type: .fontRegular))
                        .foregroundColor(Color("ibanText"))
                        .padding()
                    Spacer()
                    Image("copy")
                        .padding()
                }
            })

            .background(Color("ibanFieldBlue"))
            .cornerRadius(4)
            .padding(.horizontal)
        }
        .foregroundColor(Color.black)
        .background(Color("backgroundWhite"))
        .cornerRadius(8)
        .shadow(color: Color("button_shadow"), radius: 10, y: 3)
        .padding(.horizontal)
    }
}
