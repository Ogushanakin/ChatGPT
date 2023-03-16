//
//  HomeController.swift
//  ChatGPT
//
//  Created by AKIN on 14.03.2023.
//

import UIKit

private let reuseIdentifier = "MessageCell"

final class ChatController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var models = [String]()
    
    var formCurrentUser = false
    
    private lazy var customInputView: CustomInputAccessoryView = {
        let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0,
                                                        width: view.frame.width,
                                                        height: 50))
        return iv
    }()
    
    // MARK: - Lifecycle
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomInputAccessoryView.messageInputTextView.delegate = self
        configureUI()
        if let text = CustomInputAccessoryView.messageInputTextView.text, !text.isEmpty {
            models.append(text)
            APICaller.shared.getResponse(input: text) { [weak self] result in
                switch result {
                case .success(let output):
                    self?.models.append(output)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                case .failure:
                    print("Failed")
                }
            }
        }

    }
    override var inputAccessoryView: UIView? {
        get { return customInputView }
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    // MARK: - API
    
    // MARK: - Helpers
    func configureUI() {
        let controller = InAppController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
        
        collectionView.backgroundColor = .black
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon _refresh")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleRefresh))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_settings")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleSettings))
        navigationItem.titleView = UIImageView(image: UIImage(named: "ChatGPT"))
        self.navigationController?.addCustomBottomLine(color: #colorLiteral(red: 0.07923045009, green: 0.249772191, blue: 0.2033925056, alpha: 1) ,height: 0.6)
        navigationController?.isNavigationBarHidden = false
    }
    // MARK: - Selectors
    @objc func handleRefresh() {
        print("handleRefresh")
    }
    @objc func handleSettings() {
        let controller = SettingsController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.message = models[indexPath.row]
        return cell
    }
}

extension ChatController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let estimatedSizeCell = MessageCell(frame: frame)
        estimatedSizeCell.message = models[indexPath.row]
        estimatedSizeCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}

extension ChatController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
