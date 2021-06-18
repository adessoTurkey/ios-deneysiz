//
//  TabView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

enum TabViewEnum: String {
    case discover
    case info
    
    func callAsFunction() -> String {
        self.rawValue
    }
}
