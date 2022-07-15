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
                
                BrandListView(
                    brands: viewModel.brands,
                    onRefresh: viewModel.getBrands) { [viewModel] brand in
                        viewModel.createPointAlertConfig(brand: brand)
                    }
            }
            .navBarTopSpacing(40)
        }
        .modifier(
            PopUpHelper(
                popUpView: OrderPopUp(viewModel.currentConfig, onUpdate: viewModel.order(_:), onDismiss: {
                    withAnimation {
                        viewModel.showOrderSheet = false
                    }
                }),
                isPresented: $viewModel.showOrderSheet)
        )
        .modifier(
            PopUpHelper(
                popUpView: LottieLoading(),
                isPresented: $viewModel.isLoading,
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
                            viewModel.isLoading = true
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
        .modifier(
            ActionModifier(
                showingOptions: $showingOptions,
                installMailApp: $installMailApp
            )
        )
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
        .onAppear(perform: {
            viewModel.getBrands()
        })
        
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
            },
            config: .init(isCenterMultiline: true)
        )
            .foregroundColor(.deneysizTextColor)
    }
    
    var FilterOrder: some View {
        HStack {
            Button {
                viewModel.orderButtonTapped()
            }
        label: {
            HStack {
                Image("list")
                Text(viewModel.currentConfig.title)
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
                        EmailService.shared.sendEmail(subject: "category_detail.email_subject", completion: {
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
                            .default(Text("category_detail.suggest_new_brand")) {
                                EmailService.shared.sendEmail(subject: "category_detail.email_subject", completion: {
                                    installMailApp = !$0
                                })
                            }
                        ]
                    )
                }
        }
    }
}
