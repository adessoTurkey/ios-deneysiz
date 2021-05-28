//
//  FirstView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 28.05.2021.
//

import SwiftUI

struct FirstView: View {
    
    @ObservedObject var firstViewModel: FirstViewModel
    
    var body: some View {
        Text("FirstView")
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(firstViewModel: FirstDependencyContainer().makeFirstViewModel())
    }
}
