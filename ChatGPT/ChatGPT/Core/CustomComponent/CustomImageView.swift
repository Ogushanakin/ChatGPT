//
//  CustomImageView.swift
//  ChatGPT
//
//  Created by AKIN on 18.03.2023.
//

import UIKit

final class CustomImageView: UIImageView {

    init(imageNamed: String) {
        super.init(frame: .zero)
        image = UIImage(named: imageNamed)
        contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
