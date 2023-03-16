//
//  CustomButton.swift
//  ChatGPT
//
//  Created by AKIN on 14.03.2023.
//

import UIKit

final class CustomButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        
        setTitleColor(UIColor(white: 1, alpha: 1), for: .normal)
        setTitle(title, for: .normal)
        backgroundColor = #colorLiteral(red: 0.2923462689, green: 0.6272404194, blue: 0.5064268708, alpha: 1)
        layer.cornerRadius = 18
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
