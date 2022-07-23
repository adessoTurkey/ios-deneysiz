//
//  CategoryListView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import SwiftUI

struct CategoryListView: View {
    @EnvironmentObject var container: DiscoverDependencyContainer
    @StateObject var viewModel: CategoryListViewModel
    
    // For fixing navigation link stuck error. add tag & selection
    @State private var categorySelection: Int?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            NavigationLink(
                destination:
                    CategoryDetailView(
                        viewModel: container.makeCategoryDetailViewModel(categoryEnum: .allBrands)
                    )
                    .environmentObject(container),
                tag: CategoryEnum.allBrands.rawValue,
                selection: $categorySelection,
                label: {
                    CategoryCell(.allBrands)
                }
            )
            
            ForEach(
                viewModel.categories.chunked(into: 2),
                id: \.self) { categoryChunk in
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(
                            categoryChunk,
                            id: \.rawValue) { category in
                                NavigationLink(
                                    destination: CategoryDetailView(
                                        viewModel: container.makeCategoryDetailViewModel(categoryEnum: category)
                                    )
                                    .environmentObject(container),
                                    tag: category.rawValue,
                                    selection: $categorySelection,
                                    label: {
                                        CategoryCell(category)
                                    })
                                .accentColor(.none)
                            }
                    }
                }
        }
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
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .black.opacity(0.7),
                            .black.opacity(0.3),
                            .gray.opacity(0.3)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .cornerRadius(10)
                )
            
            Text(categoryModel.title)
                .multilineTextAlignment(.leading)
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
