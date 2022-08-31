//
//  CategoryDetailView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 30.06.2021.
//

import SwiftUI
import SwipeCell

struct CategoryDetailView: View {
    @EnvironmentObject var container: DiscoverDependencyContainer
    @Environment(\.presentationMode) var presentationMode

    @StateObject var viewModel: CategoryDetailViewModel

    @State private var installMailApp = false
    @State private var showingOptions = false

    // For fixing navigation link stuck error. add tag & selection
    @State private var brandSelection: Int?

    var hapticImpact = UIImpactFeedbackGenerator(style: .medium)

    var body: some View {
        CustomNavBarContainer {
            NavBar
                .padding(.horizontal, 24)
        } content: {
            Group {
                FilterOrder
                    .padding(.bottom, 16)
                    .disabled(viewModel.showNoDataLottie)
                
                BrandListScrollView
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
                    .font(.customFont(size: 24, type: .fontExtraBold))
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
            Button {
                viewModel.orderButtonTapped()
            } label: {
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

    private var BrandListScrollView: some View {
        VStack(alignment: .leading) {
            Text(String(format: NSLocalizedString("category-brand-found", comment: ""), viewModel.brands.count))
                .padding(.horizontal, 16)
                .font(.customFont(size: 12, type: .fontRegular))
                .foregroundColor(.deneysizTextColor)
                .opacity(showBrandCount ? 1 : 0)

            ScrollViewReader { reader in
                List {
                    ForEach(viewModel.brands, id: \.name) { brand in
                        Button {
                            brandSelection = brand.id
                        } label: {
                            BrandCell(brand: brand, onPointClick: {
                                [viewModel] brand in
                                viewModel.createPointAlertConfig(brand: brand)
                            })
                        }
                        .modifier(
                            SwipeModifier(
                                label: {
                                    Button {
                                        viewModel.followBrand(brand: brand)
                                        hapticImpact.impactOccurred()
                                    } label: {
                                        Image("notFollowing")
                                            .renderingMode(.template)
                                            .foregroundColor(.white)
                                    }
                                    .buttonStyle(.automatic)
                                },
                                tintColor: .followBackground,
                                slots: [
                                    Slot(
                                        image: {
                                            Image("notFollowing")
                                                .renderingMode(.template)
                                        },
                                        title: {
                                            EmptyView()
                                                .eraseToAnyView()
                                        },
                                        action: { [viewModel] in
                                            viewModel.followBrand(brand: brand)
                                            hapticImpact.impactOccurred()
                                        },
                                        style: .init(background: .followBackground)
                                    )

                                ]
                            )
                        )
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                        .background(
                            NavigationLink(
                                destination: BrandDetailView(viewModel: container.makeBrandDetailViewModel(brandID: brand.id)),
                                tag: brand.id,
                                selection: $brandSelection,
                                label: {}
                            )
                            .opacity(0)
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .listStyle(PlainListStyle())
                .onChange(of: viewModel.brands) { newValue in
                    if let name = newValue.first?.name {
                        reader.scrollTo(name)
                    }
                }
            }
        }
    }

    private var showBrandCount: Bool {
        !viewModel.brands.isEmpty
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
