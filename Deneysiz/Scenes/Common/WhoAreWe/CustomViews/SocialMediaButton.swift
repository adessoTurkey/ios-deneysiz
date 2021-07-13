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
            appURL = URL(string: "fb://profile/adessoturkey")
            webURL = URL(string: "https://facebook.com/adessoturkey")
        case .instagram:
            appURL = URL(string: "instagram://user?username=adessoturkey")
            webURL = URL(string: "https://instagram.com/adessoturkey")
        case .twitter:
            appURL = URL(string: "twitter://user?screen_name=adessoturkey")
            webURL = URL(string: "https://twitter.com/adessoturkey")
        case .youtube:
            appURL = URL(string: "youtube://www.youtube.com/channel/UCAqJjT5M8nWlMx-ARnHvuhg/videos")
            webURL = URL(string: "https://www.youtube.com/channel/UCAqJjT5M8nWlMx-ARnHvuhg/videos")
        }
        return (appURL, webURL)
    }
}

struct SocialMediaButton: View {
    
    var socialMedia: SocialMedia
    
    var body: some View {
        
        Button(action: {
            openURL(appURL: socialMedia.url.appURL, webURL: socialMedia.url.webURL)
        }) {
            Image(socialMedia.imageName)
                .resizable()
                .scaledToFit()
        }
    }
    
    func openURL(appURL: URL?, webURL: URL?) {
        
        if let url = appURL, UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else if let url = webURL {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
