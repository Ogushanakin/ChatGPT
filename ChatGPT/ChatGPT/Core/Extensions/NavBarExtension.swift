//
//  NavBarExtension.swift
//  ChatGPT
//
//  Created by AKIN on 14.03.2023.
//

import UIKit

extension UINavigationController {
    func addCustomBottomLine(color:UIColor,height:Double) {
        //Hiding Default Line and Shadow
        navigationBar.setValue(true, forKey: "hidesShadow")
        //Creating New line
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: height))
        lineView.backgroundColor = color
        navigationBar.addSubview(lineView)

        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        lineView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
        lineView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
    }
}
//FIXME: - Mertin extensionları eklenecek medium
