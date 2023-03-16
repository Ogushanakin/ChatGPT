//
//  ViewController.swift
//  ChatGPT
//
//  Created by AKIN on 14.03.2023.
//

import UIKit

final class FirstOnboardingController: UIViewController {
    // MARK: - Properties
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Group 1171274876")
        return iv
    }()
    private lazy var nextButton = CustomButton(title: "Next")
    private let loremLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    private let ipsumLabel: UILabel = {
        let label = UILabel()
        label.text = "Ipsum dolor sit"
        label.textColor = #colorLiteral(red: 0.2923462689, green: 0.6272404194, blue: 0.5064268708, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        return label
    }()
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Ask the bot anything, It's always ready to help!"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    private let pageControlImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "slider_1")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    // MARK: - Helpers
    func configure() {
        nextButton.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        view.backgroundColor = .black
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(view.snp.width)
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().inset(40)
            make.height.equalTo(nextButton.snp.width).multipliedBy(0.18)
        }
        let stack = UIStackView(arrangedSubviews: [loremLabel, ipsumLabel])
        stack.spacing = 6
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(50)
            make.centerX.equalTo(view.center)
        }
        view.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(loremLabel.snp_bottomMargin).offset(50)
            make.left.equalToSuperview().offset(80)
            make.right.equalToSuperview().inset(80)
        }
        view.addSubview(pageControlImage)
        pageControlImage.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp_bottomMargin).inset(80)
            make.centerX.equalTo(view.center)
            make.width.equalTo(140)
        }
    }
    // MARK: - Selectors
    @objc func handleNextPage() {
        let controller = SecondOnboardingController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

