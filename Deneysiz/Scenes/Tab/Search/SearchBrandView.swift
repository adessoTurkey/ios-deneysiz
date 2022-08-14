//
//  SearchBrandView.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 13.08.2022.
//

import SwiftUI

struct SearchBrandView: View {
    // for sticky header view
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    @State var isSearching = false
    // For fixing navigation link stuck error. add tag & selection
    @State private var infoViewNavigationSelection: String?
    
    var body: some View {
        
        ZStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack {
                    if !isSearching {
                        GeometryReader { g in
                            
                            Image("searchRabbit")
                                .resizable()
                            // fixing the view to the top will give strechy effect
                            
                                .offset(y: g.frame(in: .global).minY > 0 ?
                                        -g.frame(in: .global).minY : 0)
                            // increasing height by drag amount
                                .frame(height: g.frame(in: .global).minY > 0 ?
                                       UIScreen.main.bounds.width * 1.17 + g.frame(in: .global).minY :
                                        UIScreen.main.bounds.width * 1.17)
                                .onReceive(self.time) { _ in
                                    let y = g.frame(in: .global).minY
                                    
                                    withAnimation {
                                        self.show = -y > (UIScreen.main.bounds.width * 1.17) - 50
                                    }
                                }
                        }
                        // fixing default height
                        .frame(height: UIScreen.main.bounds.width * 1.17)
                        
                    }
                    VStack {
                        SearchView(searching: $isSearching)
                    }
                    .padding(.horizontal)
                }
            })
                .edgesIgnoringSafeArea(.top)

            if !isSearching {
                VStack {
                    
                CustomNavBar(
                    left: {
                        Text("Deneysiz")
                            .font(.customFont(size: 24, type: .fontBold))
                            .foregroundColor(.white)
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
                                        .foregroundColor(.white)
                                    Image("whiteInfo")
                                }
                            })
                    })
                    Spacer()
                }
                .padding(.top, 24)
                .padding(.horizontal, 24)
            }
            
        }
        
        if self.show {
            SearchView(searching: $isSearching)
        }
    }
}

struct SearchBrandView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBrandView()
    }
}

struct SearchView: View {
    
    @Binding var searching: Bool
    @State var searchText = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            SearchBar(searchText: $searchText, isSearching: $searching)
            if !searching {
                Text("search_view.description")
                    .padding(16)
            }
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 :
                    (UIApplication.shared.windows.first?.safeAreaInsets.top) ?? 0 + 5)
    }
    
}

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            
            TextField("", text: $searchText)
                .placeholder(when: searchText.isEmpty) {
                    Text("search-for-brand").foregroundColor(.black)
                }
                .padding(8)
                .padding(.horizontal, 25)
                .background(Color.textFieldBackground)
                .foregroundColor(Color.black)
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.deneysizText2Color)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        //                        if isEditing {
                        //                            Button(action: {
                        //                                withAnimation {
                        //                                    self.isEditing = false
                        //                                    self.text = ""
                        //                                    dismissKeyboard()
                        //                                }
                        //                            }) {
                        //                                Image(systemName: "multiply.circle.fill")
                        //                                    .foregroundColor(.gray)
                        //                                    .padding(.trailing, 8)
                        //                            }
                        //                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    withAnimation {
                        self.isSearching = true
                    }
                }
            if isSearching {
                Button(action: {
                    withAnimation {
                        self.isSearching = false
                        self.searchText = ""
                        dismissKeyboard()
                    }
                }) {
                    Text("give-up")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
