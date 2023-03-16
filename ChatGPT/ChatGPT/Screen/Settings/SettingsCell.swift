//
//  SettingsCell.swift
//  ChatGPT
//
//  Created by AKIN on 14.03.2023.
//

import UIKit

final class SettingsCell: UITableViewCell {
    // MARK: - Properties
    var viewModel: SettingsViewModel? {
        didSet { configure() }
    }
    
    private lazy var iconView: UIView = {
        let view = UIView()
        
        view.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        view.layer.cornerRadius = 40 / 2
        return view
    }()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        iv.tintColor = .black
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let arrowImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "right")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.width.equalTo(22)
        }
        iv.tintColor = .black
        return iv
    }()
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2923462689, green: 0.6272404194, blue: 0.5064268708, alpha: 1)
        return view
    }()
    
    private let leftseperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2923462689, green: 0.6272404194, blue: 0.5064268708, alpha: 1)
        return view
    }()
    
    private let rightseperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2923462689, green: 0.6272404194, blue: 0.5064268708, alpha: 1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [iconView, titleLabel])
        stack.spacing = 14
        stack.axis = .horizontal
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalToSuperview().offset(14)
        }
        
        addSubview(arrowImage)
        arrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(stack)
            make.right.equalToSuperview().inset(12)
        }
        
        addSubview(seperatorView)
        seperatorView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(0.3)
        }
        addSubview(leftseperatorView)
        leftseperatorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(0.3)
        }
        addSubview(rightseperatorView)
        rightseperatorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(0.3)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        iconImage.image = UIImage(named: viewModel.iconImageName)
        titleLabel.text = viewModel.description
    }
}

