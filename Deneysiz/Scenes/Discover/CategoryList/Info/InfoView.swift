//
//  InfoView.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 22.06.2021.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Close")
        })
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
