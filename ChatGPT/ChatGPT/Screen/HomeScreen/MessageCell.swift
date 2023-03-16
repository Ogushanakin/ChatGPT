//
//  MessageCell.swift
//  ChatGPT
//
//  Created by AKIN on 14.03.2023.
//

import UIKit

final class MessageCell: UICollectionViewCell {
    // MARK: - Properties
    var message: String? {
        didSet { configure() }
    }
    
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        return tv
    }()
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2923462689, green: 0.6272404194, blue: 0.5064268708, alpha: 1)
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(4)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = self.frame.height / 3
        bubbleContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        bubbleContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
            make.left.equalTo(profileImageView.snp_rightMargin).offset(12)
        }
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        bubbleContainer.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalTo(bubbleContainer.snp_topMargin).offset(6)
            make.left.equalTo(bubbleContainer.snp_leftMargin).offset(14)
            make.right.equalTo(bubbleContainer.snp_rightMargin).inset(14)
            make.bottom.equalTo(bubbleContainer.snp_bottomMargin).inset(6)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        textView.text = message
        profileImageView.image = UIImage(named: "Ellipse 3")
    }
    
}

