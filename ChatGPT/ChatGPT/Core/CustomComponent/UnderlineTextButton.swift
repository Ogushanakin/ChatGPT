//
//  UnderlineTextButton.swift
//  ChatGPT
//
//  Created by AKIN on 18.03.2023.
//

import UIKit

final class UnderlineTextButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        
        let attributedTitle = NSMutableAttributedString(string: title,
                                                        attributes: [.font: UIFont.systemFont(ofSize: 10),
                                                                     .foregroundColor: #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1),
                                                                     .underlineStyle: NSUnderlineStyle.single.rawValue])
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
