//
//  SearchView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 12/08/2022.
//

import SwiftUI

struct SearchBrandViewContainerView: View {
    @EnvironmentObject var container: SearchBrandDependencyContainer
    @Binding var barStyle: UIStatusBarStyle

    var body: some View {
        SearchBrandView(viewModel: container.makeSearchViewModel(), barStyle: $barStyle)
    }
}

struct SearchContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBrandViewContainerView(barStyle: .constant(.lightContent))
    }
}
