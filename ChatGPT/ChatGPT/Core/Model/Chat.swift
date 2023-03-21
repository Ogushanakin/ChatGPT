//
//  User.swift
//  ChatGPT
//
//  Created by AKIN on 17.03.2023.
//

import UIKit

struct Chat {
    let isSender: Bool
    let date: Date
    let message: String
    
    init(data: [String : Any]) {
        self.isSender = data["isSender"] as? Bool ?? false
        self.message = data["message"] as? String ?? ""
        self.date = data["date"] as? Date ?? Date()
    }
}
