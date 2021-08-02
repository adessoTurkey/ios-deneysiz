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
            VStack {
                CustomNavBar(
                    left: {
                        Text("tab-discover")
                            .font(.title)
                            .bold()
                    },
                    right: {
                        NavigationLink(
                            destination: WhoAreWeView(),
                            label: {
                                    HStack(spacing: 4) {
                                        Text("who-are-we")
                                            .foregroundColor(.blue)
                                        Image("Group")
                                    }
                            })
                    })
                    .foregroundColor(.deneysizTextColor)
                    .padding()
                
                // TODO: add filter text field
                
                CategoryListView(viewModel: container.makeCategoryViewModel())
                    .padding(.horizontal, 23)
            }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(DiscoverDependencyContainer())
    }
}
