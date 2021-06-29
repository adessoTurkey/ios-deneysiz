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
    let category: CategoryEnum
    
    init(_ category: CategoryEnum) {
        self.category = category
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            category.image
                .resizable()
                .scaledToFit()
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .leading, endPoint: .trailing)
                        .opacity(0.1)
                        .cornerRadius(10)
                )
            
            Text(category.title)
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
