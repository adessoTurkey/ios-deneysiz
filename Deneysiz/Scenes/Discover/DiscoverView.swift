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
        NavigationView {
            VStack {
                CustomNavBar(
                    left: {
                        Text("tab-discover")
                            .font(.title)
                            .bold()
                    },
                    right: {
                        
                        NavigationLink(
                            destination: InfoView(),
                            label: {
                                    HStack(spacing: 4) {
                                        Text("Biz Kimiz")
                                        Image(systemName: "gear")
                                    }
                            })
                    })
                    .padding()
                
                // TODO: add filter text field
                
                CategoryListView(viewModel: container.makeCategoryViewModel())
            }
            .navigationBarHidden(true)
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(DiscoverDependencyContainer())
    }
}
