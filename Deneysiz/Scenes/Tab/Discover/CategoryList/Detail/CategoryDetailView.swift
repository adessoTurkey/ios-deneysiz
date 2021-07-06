//
//  CategoryDetailView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 30.06.2021.
//

import SwiftUI

struct CategoryDetailView: View {
    @EnvironmentObject var container: DiscoverDependencyContainer
    @StateObject var viewModel: CategoryDetailViewModel
    @Environment(\.presentationMode) var presentationMode

    let tracker = InstanceTracker("Categorydetailview")
    var body: some View {
        VStack {
            navBar
                .foregroundColor(.deneysizTextColor)
                .padding(.bottom, 24)
                .padding(.top)
                .padding(.horizontal, 26)
            
            BrandListView(viewModel: container.makeBrandListViewModel(categoryEnum: viewModel.categoryEnum))
            
            Spacer()
        }
        .padding(.top, 0)
        .navigationBarHidden(true)
    }
    
    var navBar: some View {
        CustomNavBar(
            left: {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
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
                Button(action: {
                }) {
                    Image("add")
                }
            },
            isCenterMultiline: true
            )
    }
}
