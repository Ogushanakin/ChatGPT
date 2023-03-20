//
//  ImageButton.swift
//  ChatGPT
//
//  Created by AKIN on 18.03.2023.
//

import UIKit

final class ImageButton: UIButton {

    init(normal: String, selected: String) {
        super.init(frame: .zero)
        
        imageView?.contentMode = .scaleAspectFit
        setImage(UIImage(named : normal)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        setImage(UIImage(named : selected)?.withRenderingMode(.alwaysOriginal), for: UIControl.State.selected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
