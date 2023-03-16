//
//  SettingsViewModel.swift
//  ChatGPT
//
//  Created by AKIN on 14.03.2023.
//

import Foundation

enum SettingsViewModel: Int, CaseIterable {
    case rateus
    case contact
    case policy
    case terms
    case purchase
    
    var description: String {
        switch self {
        case .rateus: return "Rate Us"
        case .contact: return "Contact Us"
        case .policy: return "Privacy Policy"
        case .terms: return "Terms of Use"
        case .purchase: return "Restore Purchase"
        }
    }
    
    var iconImageName: String {
        switch self {
        case .rateus: return "icon_rateus"
        case .contact: return "icon_contactus"
        case .policy: return "icon_privacypolicy"
        case .terms: return "icon_termsofuse"
        case .purchase: return "icon_restorepurchase"
        }
    }
}

