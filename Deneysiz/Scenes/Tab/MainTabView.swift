//
//  TabView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedtab = TabViewEnum.discover()
    @State private var showLottie = true
    
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
            return LottieRabbit().eraseToAnyView()
        } else {
            return NavigationView {
                TabView(selection: $selectedtab) {
                    DiscoverView()
                        .tabItem {
                            VStack {
                                Image("compass")
                                Text("tab-discover")
                            }
                        }
                        .tag(TabViewEnum.discover())
                        .environmentObject(DiscoverDependencyContainer())
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    
                    InfoView()
                        .tabItem {
                            VStack {
                                Image("rabbit")
                                Text("tab-info")
                            }
                        }
                        .tag(TabViewEnum.info())
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                }
                .accentColor(.orange)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .eraseToAnyView()
        }
    }
}

enum TabViewEnum: String {
    case discover
    case info
    
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
            .previewDisplayName("iPhone 12")
        
        MainTabView()
            .environment(\.locale, .init(identifier: "tr"))
            .preferredColorScheme(.dark)
            .previewDisplayName("iPhone 11")
        
    }
}
#endif
