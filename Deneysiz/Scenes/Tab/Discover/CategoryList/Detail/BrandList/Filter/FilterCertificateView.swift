//
//  FilterCertificateView.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 25.12.2022.
//

import SwiftUI

struct FilterCertificateView: View {
    
    @State var isSelected: Bool
    let cert: Certificate
    let action: ((_ isSelected: Bool) -> Void)?
    
    var body: some View {
        Button {
            self.isSelected.toggle()
            
            action?(isSelected)
        } label: {
            FixedImage(imageName: cert.name)
                .frame(maxWidth: 75, maxHeight: 75)
                .shadow(color: .certificateShadow, radius: 10, x: 0, y: 3)
                .opacity(isSelected ? 1 : 0.3)
        }
    }
}

struct FilterCertificateView_Previews: PreviewProvider {
    static var previews: some View {
        FilterCertificateView(isSelected: false, cert: .beautyWithoutBunniesCert, action: nil)
    }
}
