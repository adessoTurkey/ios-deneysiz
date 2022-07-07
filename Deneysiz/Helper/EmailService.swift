//
//  EmailService.swift
//  Deneysiz
//
//  Created by Ilker Bagci on 4.07.2021.
//

import Foundation
import MessageUI

final class EmailService: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = EmailService()
    
    private override init() { }
    
    func sendEmail(subject: String = "", body: String = "", mailTo: String = "info@deneyehayir.org", completion: @escaping (Bool) -> Void) {

        let mailTo = "mailto:\(mailTo)?subject=\(subject)&body=\(body)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let to = mailTo, let mailtoUrl = URL(string: to), UIApplication.shared.canOpenURL(mailtoUrl) {
            UIApplication.shared.open(mailtoUrl, options: [:])
        } else {
            completion(false)
        }
    }
}
