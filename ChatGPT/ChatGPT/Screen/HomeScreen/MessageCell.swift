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
    private lazy var clipboardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "icon_copy")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(target, action: #selector(MessageCell.handleClipboard(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var unlockImageButton = ImageButton(normal: "unlock_chat", selected: "unlock_chat")
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(4)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        addSubview(bubbleContainer)
        bubbleContainer.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(4)
            make.top.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview().offset(-12)
        }
        bubbleContainer.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalTo(bubbleContainer.snp.top).offset(8)
            make.left.equalTo(bubbleContainer.snp.left).offset(8)
            make.right.equalTo(bubbleContainer.snp.right).inset(24)
            make.bottom.equalTo(bubbleContainer.snp.bottom).inset(8)
        }
        bubbleContainer.layer.cornerRadius =  24
        bubbleContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - ConfigureChatBubbleContainer
    func configure(chat: Chat) {
        self.textView.text = chat.message
        bubbleContainer.backgroundColor = chat.isSender ? #colorLiteral(red: 0.2923462689, green: 0.6272404194, blue: 0.5064268708, alpha: 1) : #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
        profileImageView.isHidden = chat.isSender
        if chat.isSender {
            bubbleContainer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
            bubbleContainer.snp.remakeConstraints { make in
                make.leading.equalTo(self.snp.centerX)
                make.top.equalToSuperview().offset(6)
                make.trailing.equalToSuperview().offset(-5)
                make.bottom.equalToSuperview().offset(-12)
            }
            layoutIfNeeded()
        } else {
            contentView.addSubview(clipboardButton)
            addSubview(clipboardButton)
            clipboardButton.snp.makeConstraints { make in
                make.top.equalTo(bubbleContainer.snp_topMargin)
                make.right.equalTo(bubbleContainer.snp_rightMargin).offset(6)
                make.height.equalTo(40)
                make.width.equalTo(40)
            }
            bubbleContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
            bubbleContainer.snp.remakeConstraints { make in
                make.leading.equalTo(profileImageView.snp.trailing).offset(4)
                make.top.equalToSuperview().offset(6)
                make.trailing.equalToSuperview().multipliedBy(0.5)
                make.bottom.equalToSuperview().offset(-12)
            }
            layoutIfNeeded()
        }
    }
    // MARK: - Selectors
    @objc func handleClipboard(_ sender: UIButton) {
        print("asdkjalsşdkalskdasdasd")
    }
}

