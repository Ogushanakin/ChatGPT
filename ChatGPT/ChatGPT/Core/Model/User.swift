//
//  User.swift
//  ChatGPT
//
//  Created by AKIN on 17.03.2023.
//

import UIKit

struct Chat {
    let isSender: Bool
    let date: Double
    let message: String
    
    init(isSender: Bool, date: Double, message: String) {
        self.isSender = isSender
        self.date = date
        self.message = message
    }
}
