//
//  FixedImage.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 14.07.2021.
//

import SwiftUI

struct FixedImage: UIViewRepresentable {

    var imageName: String

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.image = UIImage(named: imageName)
    }
}
