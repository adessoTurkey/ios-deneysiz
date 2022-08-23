//
//  FollowingContainerView.swift
//  Deneysiz
//
//  Created by ogulcan keskin on 23.08.2022.
//

import SwiftUI

struct FollowingContainerView: View {
    @EnvironmentObject var container: FollowingDependencyContainer

    init() {
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        FollowingView(viewModel: container.makeFollowingViewModel())
    }
}

struct FollowingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        FollowingContainerView()
    }
}
