//
//  FollowingView.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 20.08.2022.
//

import SwiftUI
import SwipeCell

struct FollowingView: View {
    @EnvironmentObject var container: FollowingDependencyContainer
    @StateObject var viewModel: FollowingViewModel
    
    // For fixing navigation link stuck error. add tag & selection
    @State private var brandSelection: Int?
    
    var body: some View {
        CustomNavBarContainer {
            NavBar
        } content: {
            if viewModel.brands.isEmpty {
                    LottieEmpty()
                        .frame(width: 150, height: 150)
                        .padding(.top, 60)
                        .padding(.bottom, 25)

                VStack(spacing: 8) {
                    Text("Hop, hop, hop...")
                        .font(.customFont(size: 20, type: .fontBold))
                        .multilineTextAlignment(.center)

                    Text("Görünüşe göre takip ettiğin bir marka yok, hemen keşfete zıpla ve takibe başla!")
                        .font(.customFont(size: 20, type: .fontRegular))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 24)

            } else {
                BrandListScrollView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
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
        .onAppear {
            viewModel.refresh()
        }
    }
    
    var NavBar: some View {
        CustomNavBar(
            left: {
                Text("following")
                    .font(.customFont(size: 24, type: .fontBold))
            },
            right: {
                
            })
        .foregroundColor(.deneysizTextColor)
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var BrandListScrollView: some View {
        VStack(alignment: .leading) {
                Text(String(format: NSLocalizedString("category-brand-found", comment: ""), viewModel.brands.count))
                    .padding(.horizontal, 16)
                    .font(.customFont(size: 12, type: .fontRegular))
                    .foregroundColor(.deneysizTextColor)
                
                List {
                    ForEach(viewModel.brands, id: \.name) { brandDetail in
                        Button {
                            brandSelection = brandDetail.id
                        } label: {
                            BrandFollowCell(brandDetail: brandDetail, onPointClick: { [viewModel] brandDetail in
                                viewModel.createPointAlertConfig(brandDetail: brandDetail)
                            })
                        }
                        .modifier(
                            SwipeModifier(
                                label: {
                                    Button { [viewModel] in
                                        viewModel.removeBrand(id: brandDetail.id)
                                    } label: {
                                        Label("", image: "delete")
                                    }
                                    .buttonStyle(.automatic)
                                },
                                tintColor: .red,
                                slots: [
                                    Slot(
                                        image: {
                                            Image("delete")
                                        },
                                        title: {
                                            EmptyView()
                                                .eraseToAnyView()
                                        },
                                        action: { [viewModel] in
                                            viewModel.removeBrand(id: brandDetail.id)
                                        },
                                        style: .init(background: .red)
                                    )

                                ]
                            )
                        )
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                        .background(NavigationLink(
                            destination: BrandDetailView(viewModel: container.makeBrandDetailViewModel(brandID: brandDetail.id)),
                            tag: brandDetail.id,
                            selection: $brandSelection,
                            label: {}
                        )
                            .opacity(0))
                    }
                }
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .listStyle(PlainListStyle())
            }
    }
}

private struct BrandFollowCell: View {
    let brandDetail: BrandDetail
    let onPointClick: (BrandDetail?) -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(brandDetail.name)
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(.deneysizTextColor)
                    Text(brandDetail.parentCompany?.name ?? "")
                        .font(.customFont(size: 17))
                        .foregroundColor(.deneysizText2Color)
                }
                
                Spacer()
                
                Text(brandDetail.pointTitle)
                    .lineLimit(1)
                    .font(.customFont(size: 17))
                    .foregroundColor(.white)
                    .padding(8)
                    .frame(minWidth: 75)
                    .background(brandDetail.color.cornerRadius(8))
                    .onTapGesture {
                        onPointClick(brandDetail)
                    }
            }
            .padding(16)
            
            Divider()
        }
    }
}

struct FollowingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FollowingContainerView()
                .environmentObject(FollowingDependencyContainer())
        }
    }
}
