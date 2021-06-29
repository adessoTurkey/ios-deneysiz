//
//  CategoryListView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import SwiftUI

struct CategoryListView: View {
    @ObservedObject var viewModel: CategoryListViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            NavigationLink(
                destination: Text("Destination"),
                label: {
                    CategoryCell(CategoryEnum.allBrands.categoryModel)
                })
            
            ForEach(
                viewModel.categories.chunked(into: 2),
                id: \.self) { categoryChunk in
                HStack(spacing: 16) {
                    ForEach(
                        categoryChunk,
                        id: \.rawValue) { category in
                        NavigationLink(
                            destination: Text("Destination"),
                            label: {
                                CategoryCell(category.categoryModel)
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
    let categoryModel: CategoryEnum.CategoryModel
    
    init(_ categoryModel: CategoryEnum.CategoryModel) {
        self.categoryModel = categoryModel
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
                .font(.custom("Poppins-Bold", size: 20))
                .foregroundColor(Color.init(UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)))
                .padding()
        }
        
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(viewModel: DiscoverDependencyContainer().makeCategoryViewModel())
            .padding(.horizontal, 23)
    }
}
