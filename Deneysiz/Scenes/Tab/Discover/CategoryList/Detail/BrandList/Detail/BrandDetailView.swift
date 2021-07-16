//
//  BrandDetailView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 13.07.2021.
//

import SwiftUI

struct BrandDetailView: View {
    @StateObject var viewModel: BrandDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            NavBar
                .padding(.bottom, 24)
                .padding(.top)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    
                    Certificates
                    
                    Details
                        .padding(.top)
                    
                    TextInfo
                        .padding(.top, 16)
                    
                    HelperButton(image: Image("bookmark2"), title: .init("brand-detail-quitFollowing"), action: {})
                        .padding(.top, 24)
                    
                    HelperButton(image: Image("send"), title: .init("brand-detail-share"), action: {})
                        .padding(.top, 24)
                    
                    Shops
                    
                }
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
    }
    
    var NavBar: some View {
        CustomNavBar(
            left: {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("back")
                }
            },
            center: {
                NavBarCenter
                    .padding(.top, 42)
            },
            right: {
                Button(action: {
                }) {
                    Image("add")
                }
            },
            config: .init(isCenterMultiline: true, alignment: .top)
        )
        .foregroundColor(.deneysizTextColor)
    }
    
    var NavBarCenter: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Text(viewModel.brand.name ?? "")
                    .font(.customFont(size: 28, type: .fontBold))
                    .foregroundColor(.deneysizTextColor)
                
                Text(viewModel.brand.parentCompany ?? "")
                    .font(.customFont(size: 20, type: .fontBold))
                    .foregroundColor(.deneysizText2Color)
                
            }
            Text(viewModel.brand.pointTitle)
                .font(.customFont(size: 17))
                .foregroundColor(.white)
                .frame(width: 50)
                .padding(8)
                .background(viewModel.brand.color.cornerRadius(8))
        }
    }
    
    var Certificates: some View {
        HStack {
            ForEach(viewModel.brand.certificate) { cert in
                FixedImage(imageName: cert.name ?? "")
                    .frame(maxWidth: 75, maxHeight: 75)
                    .shadow(color: .certificateShadow, radius: 10, x: 0, y: 3)
                    .opacity(cert.valid == true ? 1 : 0.3)
                if viewModel.brand.certificate.last != cert {
                    Spacer(minLength: 9)
                }
            }
        }
    }
    
    var Details: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.detail) { detail in
                VStack(spacing: 8) {
                    HStack {
                        Text(LocalizedStringKey(detail.title))
                            .font(.customFont(size: 17))
                            .foregroundColor(.deneysizTextColor)
                        Spacer()
                        Image(detail.image)
                    }
                    Divider()
                }
            }
        }
    }
    
    var TextInfo: some View {
        Text("brand-detail-description")
            .font(.customFont(size: 17))
            .foregroundColor(.deneysizTextColor)
    }
    
    var Shops: some View {
        Section(
            header: Text("brand-detail-shop")
                .padding(.top, 32)
        ) {
            VStack {
                ForEach(viewModel.brand.shopPalettes.chunked(into: 3), id: \.self) { row in
                HStack(spacing: 16) {
                        ForEach(row) { palette in
                        Text(palette.name)
                            .font(.customFont(size: 16, type: .fontMedium))
                            .foregroundColor(palette.textColor)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 8)
                            .frame(width: 98, height: 52)
                            .background(
                                palette.backgroundColor
                                    .cornerRadius(8)
                            )
                    }
                    }
                }
                .padding(.top, 8)
            }
        }
    }
}

private struct HelperButton: View {
    let image: Image
    let title: Text
    let action: () -> Void
    
    var body: some View {
        Button {
            print("tapped")
        } label: {
            HStack {
                HStack {
                    image
                    title
                        .font(.customFont(size: 17))
                        .foregroundColor(.deneysizTextColor)
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 21)
                
                Spacer()
            }
            .frame(height: 58)
            .background(
                Color.white
                    .cornerRadius(8)
                    .shadow(color: .certificateShadow, radius: 10, x: 0, y: 3)
            )
        }
    }
    
}

struct BrandDetailView_Previews: PreviewProvider {
    static var previews: some View {
        guard let brand = Brand.dummies.first else {
            return EmptyView().eraseToAnyView()
        }
        return BrandDetailView(
            viewModel: DiscoverDependencyContainer()
                .makeBrandDetailViewModel(brand: brand)).eraseToAnyView()
        }
}
