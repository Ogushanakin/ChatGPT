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
    private lazy var weeklyImageButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named : "weekly")?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        button.setImage(UIImage(named : "weekly_selected")?.withRenderingMode(.alwaysOriginal), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(myButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    private lazy var monthlyImageButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named : "monthly")?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        button.setImage(UIImage(named : "monthly_selected")?.withRenderingMode(.alwaysOriginal), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(monthlyButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    private lazy var annualyImageButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named : "annualy")?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        button.setImage(UIImage(named : "annualy_selected")?.withRenderingMode(.alwaysOriginal), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(annualyButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    private let logoImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ChatGPT")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let labelImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "inapp_label")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let unlockImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "unlock_label")
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
        view.backgroundColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_close")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(closePage))
        navigationController?.isNavigationBarHidden = false
        view.addSubview(tryButton)
        tryButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
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
