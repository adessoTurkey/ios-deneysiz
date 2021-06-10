//
//  DashboardTabView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 28.05.2021.
//

import SwiftUI

struct DashboardTabView: View {
    @State private var selectedtab = DashboardTabViewEnum.first()

    var body: some View {
        TabView(selection: $selectedtab) {
            FirstContainerView()
                .tabItem { Image(systemName: "gear") }
                .tag(DashboardTabViewEnum.first())
                .environmentObject(FirstDependencyContainer())
            FirstContainerView()
                .tabItem { Image(systemName: "gear") }
                .tag(DashboardTabViewEnum.first())
                .environmentObject(FirstDependencyContainer())
            FirstContainerView()
                .tabItem { Image(systemName: "gear") }
                .tag(DashboardTabViewEnum.third())
                .environmentObject(FirstDependencyContainer())
        }
    }
}

struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabView()
    }
}

enum DashboardTabViewEnum: String {
    case first
    case second
    case third
    func callAsFunction() -> String {
        self.rawValue
    }
}
