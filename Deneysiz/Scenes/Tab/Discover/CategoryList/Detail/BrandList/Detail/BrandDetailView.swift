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
    @State private var showPopUp = false
    @State private var installMailApp = false
    @State private var showingOptions = false

    var body: some View {
        VStack(spacing: 0) {
            NavBar
                .padding(.bottom, 24)
                .padding(.top)
            
            if #available(iOS 15.0, *) {
                ScrollRefreshable(localizedKey: "refresh", tintColor: .purple, content: {
                    BrandDetailScrollView
                }) {
                    await Task.sleep(1_000_000_000)
                    viewModel.getBrandDetail()
                }
            } else {
                BrandDetailScrollView
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .navigationBarHidden(true)
        .modifier(
            PopUpHelper(
                popUpView: LottieLoading(),
                isPresented: viewModel.isLoading)
        )
        .modifier(
            PopUpHelper(
                popUpView: PointDetailAlert(onDismiss: {
                    showPopUp = false
                }, config: viewModel.createPointAlertConfig()),
                isPresented: showPopUp,
                config: .init(backgroundOpacitiy: 0.45)
            )
        )
        .modifier(
            PopUpHelper(
                popUpView: CustomErrorAlert(
                    config: .noInternet,
                    onDismiss: {
                        withAnimation {
                            viewModel.onError = false
                        }
                    },
                    onButtonClick: {
                        viewModel.onError = false
                        viewModel.isLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            viewModel.getBrandDetail()
                        }
                    }),
                isPresented: viewModel.onError)
        )
        .alert(isPresented: $installMailApp, content: {
            .init(title: Text("common-installMailApp"))
        })
        .actionSheet(isPresented: $showingOptions) {
                        ActionSheet(
                            title: Text(""),
                            buttons: [
                                .default(Text("brand-detail-inform-feedback")) {
                                    EmailService.shared.sendEmail(subject: "hello", body: "this is body", mailTo: "installMailApp", completion: { installMailApp = !$0 })
                                },
                                .default(Text("cancel")) {
                                    showingOptions = false
                                }
                            ]
                        )
                    }
    }
    
    private var NavBar: some View {
        CustomNavBar(
            left: {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("back")
                }
            },
            center: {
                NavBarCenter
                    .padding(.top, 42)
            },
            right: {
                Button {
                    self.showingOptions = true
                } label: {
                    Image(systemName: "exclamationmark.circle")
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(.deneysizTextColor)
                }
            },
            config: .init(isCenterMultiline: true, alignment: .top)
        )
            .foregroundColor(.deneysizTextColor)
    }
    
    private var NavBarCenter: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Text(viewModel.brandDetailUIModel.name)
                    .font(.customFont(size: 28, type: .fontBold))
                    .foregroundColor(.deneysizTextColor)
                
                Text(viewModel.brandDetailUIModel.parentCompanyName)
                    .font(.customFont(size: 20, type: .fontBold))
                    .foregroundColor(.deneysizText2Color)
                
            }
            
            HStack {
                Text(viewModel.brandDetailUIModel.point)
                    .font(.customFont(size: 17))
                    .foregroundColor(.white)
                Image("info")
            }
            .frame(width: 75)
            .padding(8)
            .background(viewModel.brandDetailUIModel.scoreColor.cornerRadius(8))
            .onTapGesture {
                showPopUp.toggle()
            }
        }
    }
    
    private var Certificates: some View {
        HStack {
            ForEach(viewModel.brandDetailUIModel.certificates) { cert in
                NavigationLink(
                    destination: CertificateView(viewModel: .init(certificate: cert)),
                    label: {
                        FixedImage(imageName: cert.name)
                            .frame(maxWidth: 75, maxHeight: 75)
                            .shadow(color: .certificateShadow, radius: 10, x: 0, y: 3)
                            .opacity(cert.valid == true ? 1 : 0.3)
                    })
                if viewModel.brandDetailUIModel.certificates.last != cert {
                    Spacer(minLength: 9)
                }
            }
        }
    }
    
    private var Details: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.detail) { detail in
                HStack(spacing: 16) {
                    Image(detail.image)
                    Text(LocalizedStringKey(detail.title))
                        .font(Font.customFont(size: 16, type: .fontRegular))
                    Spacer()
                    Image("arrowRight")
                }
                .padding()
                .foregroundColor(Color.black)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color("button_shadow"), radius: 10, y: 3)
            }
        }
    }
    
    private var BrandDetailScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Certificates
                    .padding(.vertical, 8)
                    .padding(.horizontal, 4)
                
                Details
                    .padding(.top)
                    .padding(.horizontal, 4)

                TextInfo
                    .padding(.top, 16)
                
                LastUpdateText
                    .padding(.top, 10)
            }
        }
    }
    
    private var TextInfo: some View {
        Text(viewModel.brandDetailUIModel.description)
            .font(.customFont(size: 17))
            .foregroundColor(.deneysizTextColor)
    }
    
    private var LastUpdateText: some View {
        Text(String(format: NSLocalizedString("update-date", comment: ""), viewModel.brandDetailUIModel.createDate))
            .font(.customFont(size: 14))
            .foregroundColor(.deneysizTextColor)
    }
}

#if DEBUG
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
#endif

/*
 // MARK: Todo

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
 
  //    var Shops: some View {
 //        Section(
 //            header: Text("brand-detail-shop")
 //                .padding(.top, 32)
 //        ) {
 //            VStack {
 //                ForEach(viewModel.brand.shopPalettes.chunked(into: 3), id: \.self) { row in
 //                HStack(spacing: 16) {
 //                        ForEach(row) { palette in
 //                        Text(palette.name)
 //                            .font(.customFont(size: 16, type: .fontMedium))
 //                            .foregroundColor(palette.textColor)
 //                            .padding(.vertical, 16)
 //                            .padding(.horizontal, 8)
 //                            .frame(width: 98, height: 52)
 //                            .background(
 //                                palette.backgroundColor
 //                                    .cornerRadius(8)
 //                            )
 //                    }
 //                    }
 //                }
 //                .padding(.top, 8)
 //            }
 //        }
 //    }
 
 
 
 */
