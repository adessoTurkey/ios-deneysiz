//
//  FollowingView.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 20.08.2022.
//

import SwiftUI

struct FollowingView: View {
    @EnvironmentObject var container: FollowingDependencyContainer
    @StateObject var viewModel: FollowingViewModel
    
    // For fixing navigation link stuck error. add tag & selection
    @State private var brandSelection: Int?
    
    var body: some View {
        CustomNavBarContainer {
            NavBar
        } content: {
            BrandListScrollView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            viewModel.refresh()
        }
    }
    
    var NavBar: some View {
        CustomNavBar(
            left: {
                Text("following")
                    .font(.customFont(size: 24, type: .fontBold))
            },
            right: {
                
            })
        .foregroundColor(.deneysizTextColor)
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var BrandListScrollView: some View {
        VStack(alignment: .leading) {
            if !viewModel.brands.isEmpty {
                Text(String(format: NSLocalizedString("category-brand-found", comment: ""), viewModel.brands.count))
                    .padding(.horizontal, 16)
                    .font(.customFont(size: 12, type: .fontRegular))
                    .foregroundColor(.deneysizTextColor)
                
                List {
                    ForEach(viewModel.brands, id: \.name) { brand in
                        Button {
                            brandSelection = brand.id
                        } label: {
                            BrandFollowCell(brandDetail: brand)
                            // To get tap gesture event on Spacer
                                .contentShape(Rectangle())
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                        .background(NavigationLink(
                            destination: BrandDetailView(viewModel: container.makeBrandDetailViewModel(brandID: brand.id)),
                            tag: brand.id,
                            selection: $brandSelection,
                            label: {}
                        )
                        .opacity(0))
                    }
                    .onDelete(perform: viewModel.removeRows(at:))
                }
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                .buttonStyle(PlainButtonStyle())
                .listStyle(PlainListStyle())
            }
        }
    }
}

private struct BrandFollowCell: View {
    let brandDetail: BrandDetail
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(brandDetail.name)
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(.deneysizTextColor)
                    Text(brandDetail.parentCompany?.name ?? "")
                        .font(.customFont(size: 17))
                        .foregroundColor(.deneysizText2Color)
                }
                
                Spacer()
                
                Text(brandDetail.pointTitle)
                    .lineLimit(1)
                    .font(.customFont(size: 17))
                    .foregroundColor(.white)
                    .padding(8)
                    .background(brandDetail.color.cornerRadius(8))
            }
            .padding(16)
            
            Divider()
        }
    }
}

struct FollowingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FollowingContainerView()
                .environmentObject(FollowingDependencyContainer())
        }
    }
}
