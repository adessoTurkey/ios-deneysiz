//
//  BrandListView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 6.07.2021.
//

import SwiftUI

//struct BrandListView: View {
//    @EnvironmentObject var container: DiscoverDependencyContainer
//    @Binding var brands: [Brand]
//    let onPointClick: (Brand?) -> Void
//    
//    // For fixing navigation link stuck error. add tag & selection
//    @State private var brandSelection: Int?
//    
//    var body: some View {
//
//    }
//    
//
//}

struct BrandCell: View {
    let brand: Brand
    let onPointClick: (Brand?) -> Void

    public var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(brand.name)
                        .font(.customFont(size: 20, type: .fontExtraBold))
                        .foregroundColor(.deneysizTextColor)
                    Text(brand.parentCompany?.name ?? "")
                        .font(.customFont(size: 17))
                        .foregroundColor(.deneysizText2Color)
                }
                
                Spacer()
                
                Text(brand.pointTitle)
                    .lineLimit(1)
                    .font(.customFont(size: 17))
                    .foregroundColor(.white)
                    .padding(8)
                    .frame(minWidth: 75)
                    .background(brand.color.cornerRadius(8))
                    .if(UIDevice.isIPhone == true, transform: { view in
                        view
                            .onTapGesture {
                                onPointClick(brand)
                            }
                    })
                        
            }
            .padding(16)
            
            Divider()
        }
    }
}

#if DEBUG
struct BrandListView_Previews: PreviewProvider {
    static var previews: some View {
            CategoryDetailView(viewModel: DiscoverDependencyContainer().makeCategoryDetailViewModel(categoryEnum: .haircare))
    }
}
#endif
