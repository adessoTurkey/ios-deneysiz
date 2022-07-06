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
    
    let tracker = InstanceTracker("Categorydetailview")
    
    var body: some View {
        CustomNavBarContainer {
            NavBar
                .padding(.top)
                .padding(.horizontal, 24)
        } content: {
            Group {
                FilterOrder
                    .padding(.bottom, 16)
                
                BrandListView(brands: viewModel.brands, onRefresh: viewModel.getBrands)
            }
            .spacing(40)
        }
        .modifier(
            PopUpHelper(
                popUpView: OrderPopUp(viewModel.currentConfig, onUpdate: viewModel.order(_:), onDismiss: {
                    viewModel.showOrderSheet = false
                }),
                isPresented: viewModel.showOrderSheet)
        )
        .modifier(
            PopUpHelper(
                popUpView: LottieLoading(),
                isPresented: viewModel.isLoading)
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
                            viewModel.getBrands()
                        }
                    }),
                isPresented: viewModel.onError)
        )
        .alert(isPresented: $installMailApp, content: {
            .init(title: Text("common-installMailApp"))
        }).modifier(
            ActionModifier(
                showingOptions: $showingOptions,
                installMailApp: $installMailApp
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

    var completion: (() -> Void)?
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .confirmationDialog("", isPresented: $showingOptions, titleVisibility: .hidden) {
                    Button("category_detail.suggest_new_brand") {
                        // TODO: Update Email subject body mailto
                        EmailService.shared.sendEmail(subject: "hello", body: "this is body", mailTo: "installMailApp", completion: {
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
                                // TODO: Update Email subject body mailto
                                EmailService.shared.sendEmail(subject: "hello", body: "this is body", mailTo: "installMailApp", completion: {
                                    installMailApp = !$0
                                })
                            }
                        ]
                    )
                }
        }
    }
}
