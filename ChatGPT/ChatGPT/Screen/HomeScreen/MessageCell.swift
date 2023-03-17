//
//  MessageCell.swift
//  ChatGPT
//
//  Created by AKIN on 14.03.2023.
//

import UIKit

final class MessageCell: UICollectionViewCell {
    // MARK: - Properties
    var message: Chat? {
        didSet { configure(chat: message!) }
    }
    
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "Ellipse 3")
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
        bubbleContainer.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(4)
            make.top.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        bubbleContainer.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalTo(bubbleContainer.snp.top)
            make.left.equalTo(bubbleContainer.snp.left)
            make.right.equalTo(bubbleContainer.snp.right)
            make.bottom.equalTo(bubbleContainer.snp.bottom)
        }
        
//        bubbleContainer.layer.cornerRadius = self.frame.height / 3
//        bubbleContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure(chat: Chat) {
        bubbleContainer.backgroundColor = chat.isSender ? #colorLiteral(red: 0.2923462689, green: 0.6272404194, blue: 0.5064268708, alpha: 1) : .gray
        profileImageView.isHidden = chat.isSender
        
        self.textView.text = chat.message
        if chat.isSender {
            bubbleContainer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
            bubbleContainer.snp.remakeConstraints { make in
                make.leading.equalTo(self.snp.centerX)
                make.top.equalToSuperview().offset(6)
                make.trailing.equalToSuperview().offset(-5)
                make.bottom.equalToSuperview().offset(-12)
            }
            layoutIfNeeded()
        }
    }
}

