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
    
    var hapticImpact = UIImpactFeedbackGenerator(style: .medium)

    // For fixing navigation link stuck error. add tag & selection
    @State private var certSelection: String?
    
    var body: some View {
        CustomNavBarContainer {
            NavBar
                .padding(.top)
            
        } content: {
                BrandDetailScrollView
                    .navBarTopSpacing(32)
                    .opacity(viewModel.viewState == .loaded ? 1 : 0)
        }
        .padding(.horizontal, 23)
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
                        withAnimation {
                            viewModel.onError = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            viewModel.getBrandDetail()
                        }
                    }),
                isPresented: $viewModel.onError)
        )
        .modifier(
            PopUpHelper(
                popUpView: PointDetailAlert(onDismiss: {
                    withAnimation {
                        showPopUp = false
                    }
                }, config: viewModel.createPointAlertConfig()),
                isPresented: $showPopUp,
                config: .init(backgroundOpacitiy: 0.45)
            )
        )
        .modifier(
            PopUpHelper(
                popUpView: LottieLoading(),
                isPresented: .constant(viewModel.viewState == .loading),
                config: .init(backgroundOpacitiy: 0)
            )
        )
        .alert(isPresented: $installMailApp, content: {
            Alert(title: Text("error"),
                  message: Text("common-installMailApp"),
                  dismissButton: .default(Text("OK")))
        })
        .if(UIDevice.isIPhone == true, transform: { view in
            view
                .modifier(
                    ActionModifier(
                        showingOptions: $showingOptions,
                        installMailApp: $installMailApp
                    )
                )
        })
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
                    Image("alert-circle")
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(.deneysizTextColor)
                }
                .if(UIDevice.isIPad == true, transform: { view in
                    view
                        .modifier(
                            ActionModifier(
                                showingOptions: $showingOptions,
                                installMailApp: $installMailApp
                            )
                        )
                })
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
                    .foregroundColor(.white)
            }
            .lineLimit(1)
            .padding(8)
            .frame(minWidth: 75)
            .background(viewModel.brandDetailUIModel.scoreColor.cornerRadius(8))
            .onTapGesture {
                withAnimation {
                    showPopUp.toggle()
                }
            }
        }
    }

    private var Certificates: some View {
        HStack {
            ForEach(viewModel.brandDetailUIModel.certificates) { cert in
                NavigationLink(
                    destination: CertificateView(viewModel: .init(certificate: cert)),
                    tag: cert.id,
                    selection: $certSelection,
                    label: {
                        FixedImage(imageName: cert.name)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .opacity(cert.valid ? 1 : 0.3)
                    }
                )
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
                }
                .padding(16)
                .foregroundColor(Color.black)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 4)
            }
        }
    }
    
    private var BrandDetailScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Certificates
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)

                Details
                    .padding(.top)

                TextInfo
                    .padding(.top, 16)
                
                HelperButton(
                    image: viewModel.isFollowing ? Image("following") : Image("notFollowing"),
                    title: Text("follow-button-title")
                ) {
                    viewModel.follow()
                    hapticImpact.impactOccurred()
                }
                
                LastUpdateText
                    .padding(.top, 10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .shadow(color: Color("button_shadow"), radius: 10, y: 3)

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
    
    private struct HelperButton: View {
        let image: Image
        let title: Text
        let action: (() -> Void)?
        
        var body: some View {
            Button {
                action?()
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
}

private struct ActionModifier: ViewModifier {
    @Binding var showingOptions: Bool
    @Binding var installMailApp: Bool
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .confirmationDialog("", isPresented: $showingOptions, titleVisibility: .hidden) {
                    Button("brand-detail-inform-feedback") {
                        EmailService.shared.sendEmail(subject: NSLocalizedString("brand_detail.email_subject", comment: ""), completion: {
                            installMailApp = !$0
                        })
                    }
                }
        } else {
            content
                .actionSheet(isPresented: $showingOptions) {
                    ActionSheet(
                        title: Text(""),
                        buttons: [
                            .cancel(Text("İptal")),
                            .default(Text("brand-detail-inform-feedback")) {
                                EmailService.shared.sendEmail(subject: NSLocalizedString("brand_detail.email_subject", comment: ""), completion: {
                                    installMailApp = !$0
                                })
                            }
                        ]
                    )
                }
        }
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
                .makeBrandDetailViewModel(brandID: brand.id)).eraseToAnyView()
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
