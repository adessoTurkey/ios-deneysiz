//
//  BrandListView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 6.07.2021.
//

import SwiftUI

struct BrandListView: View {
    @EnvironmentObject var container: DiscoverDependencyContainer
    @Binding var brands: [Brand]
    let onPointClick: (Brand?) -> Void
    
    // For fixing navigation link stuck error. add tag & selection
    @State private var brandSelection: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(String(format: NSLocalizedString("category-brand-found", comment: ""), brands.count))
                .padding(.horizontal, 16)
                .font(.customFont(size: 12, type: .fontRegular))
                .foregroundColor(.deneysizTextColor)
                .opacity(showBrandCount ? 1 : 0)
            
                BrandListScrollView
        }
    }
    
    private var BrandListScrollView: some View {
        ScrollViewReader { reader in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(brands, id: \.name) { brand in
                        NavigationLink(
                            destination: BrandDetailView(viewModel: container.makeBrandDetailViewModel(brand: brand)),
                            tag: brand.id,
                            selection: $brandSelection,
                            label: {
                                BrandCell(brand: brand, onPointClick: onPointClick)
                                // To get tap gesture event on Spacer
                                    .contentShape(Rectangle())
                            }
                        )
                    }
                }
            }
            .onChange(of: brands) { newValue in
                if let name = newValue.first?.name {
                    reader.scrollTo(name)
                }
            }
        }
    }
    
    private var showBrandCount: Bool {
        !brands.isEmpty
    }
}

private struct BrandCell: View {
    let brand: Brand
    let onPointClick: (Brand?) -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(brand.name)
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(.deneysizTextColor)
                    Text(brand.parentCompany?.name ?? "")
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
                    .onTapGesture {
                        onPointClick(brand)
                    }
            }
            .padding(16)
            
            Divider()
        }
    }
}

#if DEBUG
struct BrandListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryDetailView(viewModel: DiscoverDependencyContainer().makeCategoryDetailViewModel(categoryEnum: .haircare))
            
        }
    }
}
#endif
