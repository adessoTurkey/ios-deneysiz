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
    
    var url: (appURL: URL?, webURL: URL?) {
        var appURL: URL?
        var webURL: URL?
        
        switch self {
        case .facebook:
            appURL = URL(string: "fb://profile/deneyehayir")
            webURL = URL(string: "https://facebook.com/deneyehayir")
        case .instagram:
            appURL = URL(string: "instagram://user?username=deneye_hayir")
            webURL = URL(string: "https://instagram.com/deneye_hayir")
        case .twitter:
            appURL = URL(string: "twitter://user?screen_name=deneyehayir")
            webURL = URL(string: "https://twitter.com/deneyehayir")
        case .youtube:
            appURL = URL(string: "youtube://www.youtube.com/user/DeneyeHayir/videos")
            webURL = URL(string: "https://www.youtube.com/user/DeneyeHayir/videos")
        }
        return (appURL, webURL)
    }
}

struct SocialMediaButton: View {
    
    var socialMedia: SocialMedia
    
    var body: some View {
        
        Button(action: {
            OpenWebsite.shared.openURL(appURL: socialMedia.url.appURL, webURL: socialMedia.url.webURL)
        }) {
            Image(socialMedia.imageName)
                .resizable()
                .scaledToFit()
        }
    }
}
