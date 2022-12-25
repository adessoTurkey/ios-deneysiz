//
//  CategoryDetailView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 30.06.2021.
//

import SwiftUI

struct CategoryDetailView: View {
    @StateObject var viewModel: CategoryDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var installMailApp = false
    @State private var showingOptions = false
    @State private var isSupportViewPresented = false

    var body: some View {
        CustomNavBarContainer {
            NavBar
                .padding(.top)
                .padding(.horizontal, 24)
        } content: {
            Group {
                FilterOrder
                    .padding(.bottom, 16)
                    .disabled(viewModel.showNoDataLottie)
                    .onTapGesture {

                    }
                
                BrandListView(brands: $viewModel.brands) { [viewModel] brand in
                    viewModel.createPointAlertConfig(brand: brand)
                }
            }
            .navBarTopSpacing(40)
        }
        .modifier(
            PopUpHelper(
                popUpView: OrderPopUp(viewModel.currentOrderConfig, onUpdate: viewModel.order(_:), onDismiss: {
                    withAnimation {
                        viewModel.showOrderSheet = false
                    }
                }),
                isPresented: $viewModel.showOrderSheet)
        )
        .sheet(isPresented: $viewModel.showFilterScreen) {
            FilterView(viewModel.filterModel, onUpdate: viewModel.filter(_:), onDismiss: {
                withAnimation {
                    viewModel.showFilterScreen = false
                }
            })
        }
        .modifier(
            PopUpHelper(
                popUpView: LottieLoading(),
                isPresented: .constant(viewModel.viewState == .loading),
                config: .init(backgroundOpacitiy: 0)
            )
        )
        .modifier(
            PopUpHelper(
                popUpView: LottieNoData(),
                isPresented: $viewModel.showNoDataLottie,
                config: .init(backgroundOpacitiy: 0)
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
                        withAnimation {
                            viewModel.onError = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            viewModel.getBrands()
                        }
                    }),
                isPresented: $viewModel.onError)
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
        .modifier(
            PopUpHelper(
                popUpView: PointDetailAlert(onDismiss: {
                    withAnimation {
                        viewModel.showPointsPopUp = false
                    }
                }, config: viewModel.savedPointPopUpConfig),
                isPresented: $viewModel.showPointsPopUp,
                config: .init(backgroundOpacitiy: 0.45)
            )
        )
    }
    
    var NavBar: some View {
        CustomNavBar(
            left: {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("back")
                }
            },
            center: {
                Text(viewModel.categoryEnum.categoryModel.title)
                    .font(.customFont(size: 24, type: .fontBold))
                    .foregroundColor(.deneysizTextColor)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            },
            right: {
                Button {
                    self.showingOptions = true
                } label: {
                    Image("add")
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
            config: .init(isCenterMultiline: true)
        )
            .foregroundColor(.deneysizTextColor)
    }
    
    var FilterOrder: some View {
        HStack {
            HStack {
                Button {
                    viewModel.filterButtonTapped()
                }
            label: {
                HStack {
                    Image("filter")
                    Text("Filtre")
                        .font(.customFont(size: 17))
                        .foregroundColor(.orderFilterTextColor)
                    
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.orderFilterTextColor, lineWidth: 1)
                        .background(Color.orderFilterBackground)
                )
            }
            }
            HStack {
                Button {
                    viewModel.orderButtonTapped()
                }
            label: {
                HStack {
                    Image("list")
                    Text(viewModel.currentOrderConfig.title)
                        .font(.customFont(size: 17))
                        .foregroundColor(.orderFilterTextColor)
                    
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.orderFilterTextColor, lineWidth: 1)
                        .background(Color.orderFilterBackground)
                )
            }
            }}
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(viewModel: DiscoverDependencyContainer().makeCategoryDetailViewModel(categoryEnum: .haircare))
    }
}

private struct ActionModifier: ViewModifier {
    @Binding var showingOptions: Bool
    @Binding var installMailApp: Bool
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .confirmationDialog("", isPresented: $showingOptions, titleVisibility: .hidden) {
                    Button("category_detail.suggest_new_brand") {
                        EmailService.shared.sendEmail(subject: NSLocalizedString("category_detail.email_subject", comment: ""), completion: {
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
                            .default(Text("category_detail.suggest_new_brand")) {
                                EmailService.shared.sendEmail(subject: NSLocalizedString("category_detail.email_subject", comment: ""), completion: {
                                    installMailApp = !$0
                                })
                            }
                        ]
                    )
                }
        }
    }
}
