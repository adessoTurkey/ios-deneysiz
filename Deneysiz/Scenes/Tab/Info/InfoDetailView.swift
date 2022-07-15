//
//  DetailView.swift
//  Deneysiz
//
//  Created by ogulcan keskin on 2.07.2022.
//

import SwiftUI

struct InfoDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let titleKey: String
    let descriptionKey: String
    
    var body: some View {
        CustomNavBarContainer {
            NavBar
        } content: {
            ScrollView(.vertical, showsIndicators: false) {
                if #available(iOS 15.0, *) {
                    Text(LocalizedStringKey(descriptionKey))
                        .font(.customFont(size: 14, type: .fontRegular))
                        .foregroundColor(.deneysizTextColor)
                        .padding(.horizontal)
                        .tint(.deneysizOrange)
                } else {
                    Text(LocalizedStringKey(descriptionKey))
                        .font(.customFont(size: 14, type: .fontRegular))
                        .foregroundColor(.deneysizTextColor)
                        .padding(.horizontal)
                }
            }
            .navBarTopSpacing(20)
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
                Text(LocalizedStringKey(titleKey))
                    .font(.title)
                    .bold()
            },
            config: .init(isCenterMultiline: true))
            .foregroundColor(.deneysizTextColor)
            .padding(.horizontal)
            .padding(.top)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        InfoDetailView(titleKey: InfoView.Detail.animalLab.title, descriptionKey: InfoView.Detail.sellInChina.description)
    }
}
