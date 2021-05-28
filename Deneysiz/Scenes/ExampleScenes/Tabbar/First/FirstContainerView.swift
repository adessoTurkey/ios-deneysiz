//
//  FirstView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 28.05.2021.
//

import SwiftUI

struct FirstContainerView: View {
    
    @EnvironmentObject var container: FirstDependencyContainer
    
    var body: some View {
        FirstView(firstViewModel: container.makeFirstViewModel())
    }
}

struct FirstContainerView_Previews: PreviewProvider {
    static var previews: some View {
        FirstContainerView()
            .environmentObject(FirstDependencyContainer())
    }
}
