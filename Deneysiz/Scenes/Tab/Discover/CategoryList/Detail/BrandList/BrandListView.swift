//
//  BrandListView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 6.07.2021.
//

import SwiftUI

struct BrandListView: View {
    @EnvironmentObject var container: DiscoverDependencyContainer
    let brands: [BrandDummy]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(String(format: NSLocalizedString("category-brand-found", comment: ""), brands.count))
                .padding(.horizontal, 16)
                .font(.customFont(size: 12, type: .fontRegular))
                .foregroundColor(.deneysizTextColor)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    ForEach(brands, id: \.name) { brand in
                        NavigationLink(
                            destination: BrandDetailView(viewModel: container.makeBrandDetailViewModel(brand: brand)),
                            label: {
                                BrandCell(brand: brand)
                                    // To get tap gesture event on Spacer
                                    .contentShape(Rectangle())
                            })
                            .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

private struct BrandCell: View {
    let brand: BrandDummy
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(brand.name ?? "")
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(.deneysizTextColor)
                    Text(brand.parentCompany ?? "")
                        .font(.customFont(size: 17))
                        .foregroundColor(.deneysizText2Color)
                }
                
                Spacer()
                
                Text(brand.pointTitle)
                    .font(.customFont(size: 17))
                    .foregroundColor(.white)
                    .frame(width: 50)
                    .padding(8)
                    .background(brand.color.cornerRadius(8))
            }
            .padding(16)
            
            Divider()
        }
    }
}

struct BrandListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryDetailView(viewModel: DiscoverDependencyContainer().makeCategoryDetailViewModel(categoryEnum: .hairDye))
            
            BrandListView(brands: BrandDummy.dummies)
        }
    }
}
