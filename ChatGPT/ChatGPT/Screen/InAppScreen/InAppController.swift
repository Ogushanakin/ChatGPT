//
//  InAppController.swift
//  ChatGPT
//
//  Created by AKIN on 15.03.2023.
//

import UIKit

final class InAppController: UIViewController {
    // MARK: - Properties
    private lazy var tryButton = CustomButton(title: "Try It Now")
    private lazy var weeklyImageButton = ImageButton(normal: "weekly", selected: "weekly_selected")
    private lazy var monthlyImageButton = ImageButton(normal: "monthly", selected: "monthly_selected")
    private lazy var annualyImageButton = ImageButton(normal: "annualy", selected: "annualy_selected")
    private let logoImage = CustomImageView(imageNamed: "ChatGPT")
    private let labelImage = CustomImageView(imageNamed: "inapp_label")
    private let unlockImage = CustomImageView(imageNamed: "unlock_label")
    private lazy var policyButton = UnderlineTextButton(title: "Privacy Policy")
    private lazy var purchaseButton = UnderlineTextButton(title: "Restore Purchase")
    private lazy var termsButton = UnderlineTextButton(title: "Terms of Use")
    private let lineImage = CustomImageView(imageNamed: "text_line")
    private let lineeImage = CustomImageView(imageNamed: "text_line")
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    // MARK: - Helpers
    func configure() {
        weeklyImageButton.addTarget(self, action: #selector(myButtonTapped), for: UIControl.Event.touchUpInside)
        monthlyImageButton.addTarget(self, action: #selector(monthlyButtonTapped), for: UIControl.Event.touchUpInside)
        annualyImageButton.addTarget(self, action: #selector(annualyButtonTapped), for: UIControl.Event.touchUpInside)
        view.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_close")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(closePage))
        navigationController?.isNavigationBarHidden = false
        view.addSubview(tryButton)
        tryButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(34)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().inset(40)
            make.height.equalTo(tryButton.snp.width).multipliedBy(0.18)
        }
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(120)
            make.right.equalToSuperview().inset(120)
            make.height.equalTo(50)
        }
        view.addSubview(labelImage)
        labelImage.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp_bottomMargin).offset(30)
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().inset(35)
            make.height.equalTo(55)
        }
        view.addSubview(unlockImage)
        unlockImage.snp.makeConstraints { make in
            make.top.equalTo(labelImage.snp_bottomMargin).offset(42)
            make.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().inset(100)
            make.height.equalTo(50)
        }
        let plansStack = UIStackView(arrangedSubviews: [weeklyImageButton, monthlyImageButton, annualyImageButton])
        plansStack.axis = .vertical
        plansStack.distribution = .fillEqually
        plansStack.spacing = 10
        
        view.addSubview(plansStack)
        plansStack.snp.makeConstraints { make in
            make.top.equalTo(unlockImage.snp_bottomMargin).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalTo(tryButton.snp_topMargin).inset(-30)
        }
        let buttonsStack = UIStackView(arrangedSubviews: [policyButton, lineImage, purchaseButton, lineeImage, termsButton])
        buttonsStack.axis = .horizontal
        buttonsStack.distribution = .equalCentering
        view.addSubview(buttonsStack)
        buttonsStack.snp.makeConstraints { make in
            make.top.equalTo(tryButton.snp_bottomMargin).offset(12)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().inset(30)
        }
    }
    // MARK: - Selectors
    @objc func myButtonTapped(){
      if weeklyImageButton.isSelected == true {
        weeklyImageButton.isSelected = false
      }else {
        weeklyImageButton.isSelected = true
        monthlyImageButton.isSelected = false
        annualyImageButton.isSelected = false
      }
    }
    @objc func monthlyButtonTapped(){
      if monthlyImageButton.isSelected == true {
          monthlyImageButton.isSelected = false
      }else {
          monthlyImageButton.isSelected = true
          weeklyImageButton.isSelected = false
          annualyImageButton.isSelected = false
      }
    }
    @objc func annualyButtonTapped(){
      if annualyImageButton.isSelected == true {
          annualyImageButton.isSelected = false
      }else {
          annualyImageButton.isSelected = true
          weeklyImageButton.isSelected = false
          monthlyImageButton.isSelected = false
      }
    }
    @objc func closePage() {
        self.dismiss(animated: true)
    }
}
