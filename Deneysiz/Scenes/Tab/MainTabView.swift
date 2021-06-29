//
//  TabView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedtab = TabViewEnum.discover()
    
    var body: some View {
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
            
            Text("Tab Content 2")
                .tabItem {
                    VStack {
                        Image("rabbit")
                        Text("tab-info")
                    }
                }
                .tag(TabViewEnum.info())
        }
        .accentColor(.orange)
    }
}

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

enum TabViewEnum: String {
    case discover
    case info
    
    func callAsFunction() -> String {
        self.rawValue
    }
}

struct AppFont {
    static func commonFont(fontSize: CGFloat) -> Font {
        return Font.custom("Poppins-Regular", size: fontSize)
    }
}
