//
//  TabView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedtab = TabViewEnum.search()
    @State private var showLottie = true
    @State private var barStyle: UIStatusBarStyle = .lightContent

    init() {
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        if showLottie {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showLottie.toggle()
                }
            }
            return LottieRabbit()
                .statusBar(style: barStyle)
                .eraseToAnyView()

        } else {
            return NavigationView {
                TabView(selection: $selectedtab) {
                    SearchBrandViewContainerView(barStyle: $barStyle)
                        .tabItem {
                            VStack {
                                Image("tabBarSearch")
                                Text("search")
                            }
                        }
                        .tag(TabViewEnum.search())
                        .environmentObject(SearchBrandDependencyContainer())
                        .navigationBarTitle("")
                        .navigationBarHidden(true)

                    DiscoverView()
                        .tabItem {
                            VStack {
                                Image("tabBarDiscover")
                                Text("discover")
                            }
                        }
                        .tag(TabViewEnum.discover())
                        .environmentObject(DiscoverDependencyContainer())
                        .navigationBarTitle("")
                        .navigationBarHidden(true)

                    InfoView()
                        .tabItem {
                            VStack {
                                Image("tabBarQuestionMark")
                                Text("do_you_know")
                            }
                        }
                        .tag(TabViewEnum.info())
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    
                    FollowingContainerView()
                        .tabItem {
                            VStack {
                                Image("tabBarFollowing")
                                Text("following")
                            }
                        }
                        .tag(TabViewEnum.following())
                        .environmentObject(FollowingDependencyContainer())
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                }
                .accentColor(.deneysizOrange)
                .statusBar(style: barStyle)
            }
            .onChange(of: selectedtab) { newValue in
                barStyle = newValue == TabViewEnum.search.rawValue ? .lightContent : .darkContent
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .buttonStyle(.plain)
            .eraseToAnyView()
        }
    }
}

enum TabViewEnum: String {
    case search
    case discover
    case info
    case following
    
    func callAsFunction() -> String {
        self.rawValue
    }
}

#if DEBUG
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environment(\.locale, .init(identifier: "tr"))
            .preferredColorScheme(.light)
            .previewDisplayName("Light")
        
        MainTabView()
            .environment(\.locale, .init(identifier: "tr"))
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark")
    }
}
#endif
