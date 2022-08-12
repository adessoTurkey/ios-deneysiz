//
//  SearchView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 12/08/2022.
//

import SwiftUI

struct SearchView: View {

    @StateObject var viewModel: SearchViewModel
    @State private var COLLAPSE = false
    @State private var isEditing = false

    // For fixing navigation link stuck error. add tag & selection
    @State private var brandSelection: Int?

    var body: some View {
        GeometryReader { geometry in
            CustomNavBarContainer {
                ZStack(alignment: .top) {
                    Image("searchBunny")
                        .resizable()
                        .ignoresSafeArea(.all, edges: .top)

                    NavBar
                        .padding(.top)
                        .padding(.horizontal, 24)
                }
                .opacity(COLLAPSE ? 0 : 1)
                .frame(height: COLLAPSE ? 0 : geometry.size.height / 2)
            } content: {
                VStack(spacing: 24) {
                    SearchBar
                        .padding(.horizontal, 24)

                    if viewModel.brands.isEmpty {
                        LottieEmpty()
                    } else {
                        VStack(alignment: .leading) {
                            Text(String(format: NSLocalizedString("category-brand-found", comment: ""), viewModel.brands.count))
                                .padding(.horizontal, 16)
                                .font(.customFont(size: 12, type: .fontRegular))
                                .foregroundColor(.deneysizTextColor)
                                .opacity(showBrandCount ? 1 : 0)

                            BrandListScrollView
                        }
                    }
                }
                .navBarTopSpacing(40)
            }
        }
    }

    private var BrandListScrollView: some View {
        ScrollViewReader { reader in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(viewModel.brands, id: \.name) { brand in
                        NavigationLink(
                            destination: Text("as"),
                            tag: brand.id,
                            selection: $brandSelection,
                            label: {
                                BrandSearchCell(brandSearch: brand)
                                // To get tap gesture event on Spacer
                                    .contentShape(Rectangle())
                            }
                        )
                    }
                }
            }
        }
    }

    var NavBar: some View {
        CustomNavBar(
            left: {
                Text("search-title")
                    .font(.customFont(size: 24, type: .fontBold))
            },
            right: {
                NavigationLink(
                    destination: WhoAreWeView(),
                    tag: "who-are-we",
                    selection: .constant("asfa"),
                    label: {
                        HStack(spacing: 4) {
                            Text("who-are-we")
                                .font(.customFont(size: 14, type: .fontMedium))
                            Image("Group")
                        }
                    })
            })
        .foregroundColor(.white)
    }

    var SearchBar: some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.secondary)
            TextField(
                NSLocalizedString("search", comment: ""),
                text: $viewModel.searchText,
                onEditingChanged: {
                    print("onEditingChanged", viewModel.searchText, $0, separator: "  ")
                    isEditing = $0
                    if isEditing {
                        withAnimation {
                            COLLAPSE = true
                        }
                    } else if viewModel.searchText.isEmpty {
                        withAnimation {
                            COLLAPSE = false
                        }
                    }
                }
            )
            .disableAutocorrection(true)
            Spacer()
            Image(systemName: "multiply.circle.fill")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.secondary)
                .opacity(viewModel.searchText.isEmpty ? 0 : 1)
                .onTapGesture {
                    viewModel.searchText = ""
                    if !isEditing, viewModel.searchText.isEmpty {
                        withAnimation {
                            COLLAPSE = false
                        }
                    }
                }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(Color.primary.opacity(0.05))
        .cornerRadius(10)
    }

    private var showBrandCount: Bool {
        !viewModel.brands.isEmpty
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: .init(searchBrandService: BrandSearchService()))
    }
}

private struct BrandSearchCell: View {
    let brandSearch: BrandSearch

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(brandSearch.name)
                        .font(.customFont(size: 20, type: .fontBold))
                        .foregroundColor(.deneysizTextColor)
                    Text(brandSearch.parentCompany.name ?? "")
                        .font(.customFont(size: 17))
                        .foregroundColor(.deneysizText2Color)
                }

                Spacer()

                Text(brandSearch.pointTitle)
                    .font(.customFont(size: 17))
                    .foregroundColor(.white)
                    .frame(width: 50)
                    .padding(8)
                    .background(brandSearch.color.cornerRadius(8))
            }
            .padding(16)

            Divider()
        }
    }
}
