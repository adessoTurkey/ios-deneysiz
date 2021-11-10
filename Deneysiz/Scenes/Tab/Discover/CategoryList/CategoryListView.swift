//
//  CategoryListView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import SwiftUI

struct CategoryListView: View {
    @EnvironmentObject var container: DiscoverDependencyContainer
    @ObservedObject var viewModel: CategoryListViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            NavigationLink(
                destination: Text("Destination"),
                label: {
                    CategoryCell(.allBrands)
                })
            
            ForEach(
                viewModel.categories.chunked(into: 2),
                id: \.self) { categoryChunk in
                HStack(spacing: 16) {
                    ForEach(
                        categoryChunk,
                        id: \.rawValue) { category in
                        NavigationLink(
                            destination: CategoryDetailView(
                                viewModel: container.makeCategoryDetailViewModel(categoryEnum: category)
                            )
                            .environmentObject(container),
                            label: {
                                CategoryCell(category)
                            })
                            .accentColor(.none)
                    }
                }
            }
        }
        .onAppear(perform: {
            viewModel.getCategories()
        })
    }
}

private struct CategoryCell: View {
    let categoryModel: CategoryEnum.CategoryUIModel
    
    init(_ categoryModel: CategoryEnum) {
        self.categoryModel = categoryModel.categoryModel
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            categoryModel.image
                .resizable()
                .scaledToFit()
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .leading, endPoint: .trailing)
                        .opacity(0.1)
                        .cornerRadius(10)
                )
            
            Text(categoryModel.title)
                .font(Font.customFont(size: 20, type: .fontBold))
                .foregroundColor(Color("textForegroundWhite"))
                .padding()
        }
        
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(viewModel: DiscoverDependencyContainer().makeCategoryViewModel())
            .padding(.horizontal, 23)
            .environmentObject(DiscoverDependencyContainer())
    }
}
