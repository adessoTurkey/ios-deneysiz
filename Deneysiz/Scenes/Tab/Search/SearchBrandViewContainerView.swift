//
//  SearchView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 12/08/2022.
//

import SwiftUI

struct SearchBrandViewContainerView: View {
    @EnvironmentObject var container: SearchBrandDependencyContainer

    var body: some View {
        SearchBrandView(viewModel: container.makeSearchViewModel())
    }
}

struct SearchContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBrandViewContainerView()
    }
}