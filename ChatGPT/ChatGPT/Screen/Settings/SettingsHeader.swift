//
//  ProfileHeader.swift
//  ChatGPT
//
//  Created by AKIN on 14.03.2023.
//

import UIKit

final class SettingsHeader: UIView {
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1014245674, green: 0.2025031447, blue: 0.1666375399, alpha: 1)
        view.layer.cornerRadius = 22
        return view
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Get Premium!"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    private let icon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "img_diamond")
        return iv
    }()
    private let arrowIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "icon_arrowright")
        return iv
    }()
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2923462689, green: 0.6272404194, blue: 0.5064268708, alpha: 1)
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(80)
        }
        backgroundView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundView.snp_centerYWithinMargins)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(54)
            make.width.equalTo(54)
        }
        backgroundView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundView.snp_centerYWithinMargins)
            make.left.equalTo(icon.snp_rightMargin).offset(20)
        }
        backgroundView.addSubview(arrowIcon)
        arrowIcon.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundView.snp_centerYWithinMargins)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(54)
            make.width.equalTo(54)
        }
        addSubview(seperatorView)
        seperatorView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(50)
            make.right.equalToSuperview()
            make.height.equalTo(0.4)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
