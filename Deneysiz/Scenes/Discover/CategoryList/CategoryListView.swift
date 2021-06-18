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
                    CategoryCell(Category(name: "Bütün Markalar", image: ""))
                })
            
            ForEach(
                viewModel.categories.chunked(into: 2),
                id: \.self) { categoryChunk in
                HStack {
                    ForEach(
                        categoryChunk,
                        id: \.name) { category in
                        NavigationLink(
                            destination: Text("Destination"),
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
    let category: Category
    
    init(_ category: Category) {
        self.category = category
    }
    
    var body: some View {
        ZStack {
            Image(systemName: "gear")
                .resizable()
                .scaledToFit()
                .background(Color(UIColor.black.withAlphaComponent(0.3)))
            Text(category.name)
                .foregroundColor(Color(UIColor.systemBackground))
        }
        
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(viewModel: DiscoverDependencyContainer().makeCategoryViewModel())
    }
}
