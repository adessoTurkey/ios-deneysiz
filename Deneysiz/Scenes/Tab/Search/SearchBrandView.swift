//
//  SearchBrandView.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 13.08.2022.
//

import SwiftUI

struct SearchBrandView: View {
    
    @EnvironmentObject var container: SearchBrandDependencyContainer
    @StateObject var viewModel: SearchBrandViewModel
    // for sticky header view
    @State private var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State private var show = false
    @State private var isSearching = false
    
    // For fixing navigation link stuck error. add tag & selection
    @State private var infoViewNavigationSelection: String?
    @State private var brandSelection: Int?
    
    private let multiplier: CGFloat = 0.65
    
    var body: some View {
        ZStack {
            GeometryReader { outerGeometry in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        if !isSearching {
                            GeometryReader { geometry in
                                Image("searchRabbit")
                                    .resizable()
                                // fixing the view to the top will give strechy effect
                                    .offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY : 0)
                                // increasing height by drag amount
                                    .frame(
                                        height: geometry.frame(in: .global).minY > 0 ?
                                        outerGeometry.size.height * multiplier + geometry.frame(in: .global).minY :
                                            outerGeometry.size.height * multiplier)
                                    .onReceive(self.time) { _ in
                                        let y = geometry.frame(in: .global).minY
                                        withAnimation {
                                            self.show = -y > (outerGeometry.size.height * multiplier) - 50
                                        }
                                    }
                            }
                            // fixing default height
                            .frame(height: outerGeometry.size.height * multiplier)
                        }
                        
                        SearchBar(searchText: $viewModel.searchText, isSearching: $isSearching)
                            .padding(.top, isSearching ?  outerGeometry.safeAreaInsets.top : 40)
                            .padding(.horizontal, 24)
                            .anchorPreference(
                                key: BoundsPreferenceKey.self,
                                value: .bounds
                            ) { $0 }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.top)
            }
            
            if !isSearching {
                VStack {
                    NavBar
                        .padding(.top, 24)
                        .padding(.horizontal, 24)
                    Spacer()
                }
            }
        }
        .overlayPreferenceValue(BoundsPreferenceKey.self) { preferences in
            GeometryReader { geometry in
                if isSearching {
                    preferences.map { val in
                        BrandListScrollView
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.top, geometry[val].maxY + 24)
                    }
                }
            }
        }
    }
    
    var NavBar: some View {
        CustomNavBar(
            left: {
                Text("Deneysiz")
                    .font(.customFont(size: 24, type: .fontBold))
            },
            right: {
                NavigationLink(
                    destination: WhoAreWeView(),
                    tag: "who-are-we",
                    selection: $infoViewNavigationSelection,
                    label: {
                        HStack(spacing: 4) {
                            Text("who-are-we")
                                .font(.customFont(size: 14, type: .fontMedium))
                            Image("whiteInfo")
                        }
                    })
            })
        .foregroundColor(.white)
    }
    
    private var BrandListScrollView: some View {
        VStack(alignment: .leading) {
            Text(String(format: NSLocalizedString("category-brand-found", comment: ""), viewModel.brands.count))
                .padding(.horizontal, 16)
                .font(.customFont(size: 12, type: .fontRegular))
                .foregroundColor(.deneysizTextColor)
                .opacity(showBrandCount ? 1 : 0)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(viewModel.brands, id: \.name) { brand in
                        NavigationLink(
                            destination: BrandDetailView(viewModel: container.makeBrandDetailViewModel(brandID: brand.id)),
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
    
    private var showBrandCount: Bool {
        !viewModel.brands.isEmpty
    }
}

struct SearchBrandView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBrandView(viewModel: .init(searchBrandService: BrandSearchService()))
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.secondary)
                TextField("search-for-brand", text: $searchText, onEditingChanged: { editing in
                    if editing {
                        withAnimation {
                            isSearching = true
                        }
                    }
                })
                .disableAutocorrection(true)
                if !searchText.isEmpty {
                    Spacer()
                    Image(systemName: "multiply.circle.fill")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            searchText = ""
                        }
                }
            }
            .padding(8)
            .frame(height: 36)
            .background(Color.textFieldBackground)
            .cornerRadius(10)
            
            if isSearching {
                Button {
                    withAnimation {
                        searchText = ""
                        isSearching = false
                        dismissKeyboard()
                    }
                } label: {
                    Text("give-up")
                    
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
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
