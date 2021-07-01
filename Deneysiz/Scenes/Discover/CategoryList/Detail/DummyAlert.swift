//
//  DummyAlert.swift
//  OKRSwiftUIPhase1
//
//  Created by Ogulcan Keskin on 22.06.2021.
//

import SwiftUI

struct DummyAlert: Alertable {
    var onDismiss: (() -> Void)
    
    var body: some View {
        VStack {
            Text("Dummy Alert")
            Button(
                action: {
                    onDismiss()
                },
                label: {
                Text("Dismiss")
            })
        }
        .padding()
        .background(Color.white)
        
    }
}
