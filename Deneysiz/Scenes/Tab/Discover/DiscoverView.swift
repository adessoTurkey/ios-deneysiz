//
//  DiscoverView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var container: DiscoverDependencyContainer
   
    // For fixing navigation link stuck error. add tag & selection
    @State private var detailSelection: String?
    
    var body: some View {
        CustomNavBarContainer {
            NavBar
        } content: {
            CategoryListView(viewModel: container.makeCategoryViewModel())
                .navBarTopSpacing(32)
        }
        .padding(.horizontal, 24)
    }
    
    var NavBar: some View {
        CustomNavBar(
            left: {
                Text("discover")
                    .font(.customFont(size: 24, type: .fontExtraBold))
                    .foregroundColor(.deneysizTextColor)
            },
            right: {
                NavigationLink(
                    destination: WhoAreWeView(),
                    tag: "who-are-we",
                    selection: $detailSelection,
                    label: {
                        HStack(spacing: 4) {
                            Text("who-are-we")
                                .font(.customFont(size: 14, type: .fontMedium))
                                .foregroundColor(.deneysizBlueTextColor)
                            Image("Group")
                        }
                    })
            })
            .foregroundColor(.deneysizTextColor)
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(DiscoverDependencyContainer())
    }
}
