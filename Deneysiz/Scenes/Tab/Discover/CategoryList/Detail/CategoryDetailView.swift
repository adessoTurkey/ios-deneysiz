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
    
    let tracker = InstanceTracker("Categorydetailview")
    var body: some View {
        VStack {
            NavBar
                .padding(.bottom, 24)
                .padding(.top)
                .padding(.horizontal, 26)
            
            FilterOrder
                .padding(.bottom, 16)
            
            BrandListView(brands: viewModel.brands)
            
            Spacer()
        }
        .padding(.top, 0)
        .navigationBarHidden(true)
        .actionSheet(isPresented: $viewModel.showOrderSheet) {
            ActionSheet(title: Text("brand-detail-order-title"), message: Text("brand-detail-order-subTitle"), buttons: [
                .default(Text("brand-detail-point-asc")) { viewModel.order(.point(.asc)) },
                .default(Text("brand-detail-point-desc")) { viewModel.order(.point(.desc)) },
                .default(Text("brand-detail-name-asc")) { viewModel.order(.name(.asc)) },
                .default(Text("brand-detail-name-desc")) { viewModel.order(.name(.desc)) }
            ])
        }
        .modifier(
            PopUpHelper(
                popUpView:
                    ActivityIndicator(isAnimating: viewModel.isLoading) {
                        $0.color = .yellow
                        $0.hidesWhenStopped = false
                    },
                isPresented: viewModel.isLoading)
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
                    .font(.title)
                    .bold()
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            },
            right: {
                Button {
                    
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
                    Text("Sirala")
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
        CategoryDetailView(viewModel: DiscoverDependencyContainer().makeCategoryDetailViewModel(categoryEnum: .hairDye))
    }
}
