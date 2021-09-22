//
//  DiscoverView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 18.06.2021.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var container: DiscoverDependencyContainer
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            NavBar
                .padding(.top)
                        
            CategoryListView(viewModel: container.makeCategoryViewModel())
            
        }
        .padding(.horizontal, 24)
    }
    
    var NavBar: some View {
        CustomNavBar(
            left: {
                Text("tab-discover")
                    .font(.customFont(size: 24, type: .fontBold))
                    .foregroundColor(.deneysizTextColor)
            },
            right: {
                NavigationLink(
                    destination: WhoAreWeView(),
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
