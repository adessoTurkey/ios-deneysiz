//
//  SocialMediaButton.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 27.06.2021.
//

import SwiftUI

enum SocialMedia {
    
    case facebook
    case twitter
    case youtube
    case instagram
    
    var imageName: String {
        switch self {
        case .facebook:
            return "facebook"
        case .instagram:
            return "instagram"
        case .twitter:
            return "twitter"
        case .youtube:
            return "youtube"
        }
    }
    
    var action: () -> Void {
        switch self {
        case .facebook:
            return {
                print("open facebook")
            }
        case .instagram:
            return {
                print("open instagram")
            }
        case .twitter:
            return {
                print("open twitter")
            }
        case .youtube:
            return {
                print("open youtube")
            }
        }
    }
}

struct SocialMediaButton: View {
    
    var socialMediaType: SocialMedia
    
    var body: some View {
        
        Button(action: socialMediaType.action) {
            Image(socialMediaType.imageName)
                .resizable()
                .scaledToFit()
        }
    }
    
}
