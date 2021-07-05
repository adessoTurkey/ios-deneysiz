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
                    Text("who_are_we-title")
                        .font(.title)
                        .bold()
                },
                right: {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("dismiss")
                    }
                })
                .padding()
            ScrollView(.vertical, showsIndicators: false) {
                
                Text("who_are_we-info_text")
                    .font(Font.customFont(size: 14, type: .fontRegular))
                    .foregroundColor(Color("donateText"))
                    .padding()
                BankAccountView(account: .turkishLira)
                    .padding(.vertical)
                BankAccountView(account: .euro)
                    .padding(.vertical)
                
            }.navigationBarHidden(true)
            
        }
    }
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}

enum BankAccountType {
    
    case turkishLira
    case euro
    
    var imageName: String {
        switch self {
        case .turkishLira:
            return "turkishLira"
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
            return "TR 9800 0100 0203 9109 0646 5001"
        case .euro:
            return "TR 7100 0100 0203 9109 0646 5002"
        }
    }
}

struct BankAccountView: View {
    
    var account: BankAccountType
    var hapticImpact = UIImpactFeedbackGenerator(style: .soft)
    
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
            }) {
                HStack {
                    Text(account.IBAN)
                        .font(Font.customFont(size: 14, type: .fontRegular))
                        .foregroundColor(Color("ibanText"))
                        .padding()
                    Spacer()
                    Image("copy")
                        .padding()
                }
            }

            .background(Color("ibanFieldBlue"))
            .cornerRadius(4)
            .padding(.horizontal)
            Spacer()
        }
        .foregroundColor(Color.black)
        .background(Color("backgroundWhite"))
        .cornerRadius(8)
        .shadow(color: Color("button_shadow"), radius: 10, y: 3)
        .padding(.horizontal)
    }
}
