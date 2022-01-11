//
//  UINavigationController+Extension.swift
//  Deneysiz
//
//  Created by Ogulcan Keskin on 11.01.2022.
//

import UIKit

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
