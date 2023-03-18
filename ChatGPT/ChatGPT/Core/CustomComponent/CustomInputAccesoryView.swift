//
//  CustomInputAccesoryView.swift
//  ChatGPT
//
//  Created by AKIN on 14.03.2023.
//

import UIKit

protocol ChatInputDelegate: AnyObject {
    func inputView(_ view: CustomInputAccessoryView, input: String)
}
final class CustomInputAccessoryView: UIView {    
    // MARK: - Properties
    weak var delegate: ChatInputDelegate?
    var sendAction: (() -> Void)? = nil
    var messageInputTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.layer.cornerRadius = 8
        tv.isScrollEnabled = false
        tv.autocorrectionType = .no
        return tv
    }()
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_send_selected"), for: .normal)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return button
    }()
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Say Something..."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2923462689, green: 0.6272404194, blue: 0.5064268708, alpha: 1)
        return view
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        autoresizingMask = .flexibleHeight
        
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = #colorLiteral(red: 0.2923462689, green: 0.6272404194, blue: 0.5064268708, alpha: 1)
        
        addSubview(seperatorView)
        seperatorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(0.3)
        }
        
        addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(14)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        addSubview(messageInputTextView)
        messageInputTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(6)
            make.right.equalTo(sendButton.snp_leftMargin).inset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.left.equalTo(messageInputTextView.snp_leftMargin).offset(18)
            make.centerY.equalTo(messageInputTextView)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange),
                                               name: UITextView.textDidChangeNotification, object: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    // MARK: - Selectors
    @objc func handleTextInputChange() {
        placeholderLabel.isHidden = !messageInputTextView.text.isEmpty
    }
    @objc func handleSendMessage() {
        sendAction?()
        guard let input = messageInputTextView.text else { return }
        delegate?.inputView(self, input: input)
    }
    // MARK: - Helpers
    func clearMessageText() {
        messageInputTextView.text = nil
        placeholderLabel.isHidden = false
    }
}

