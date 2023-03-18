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
    let viewModel = ChatViewModel()
    private lazy var customInputView: CustomInputAccessoryView = {
        let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0,
                                                        width: view.frame.width,
                                                        height: 50))
        return iv
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavBar()
        viewModel.fetchChat()
    }
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override var inputAccessoryView: UIView? {
        get { return customInputView }
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    // MARK: - Helpers
    func configureUI() {
        viewModel.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        customInputView.delegate = self
        
        collectionView.backgroundColor = .black
        collectionView.scrollsToTop = true
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
    func configureNavBar() {
        let controller = InAppController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon _refresh")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleRefresh))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_settings")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleSettings))
        navigationItem.titleView = UIImageView(image: UIImage(named: "ChatGPT"))
        self.navigationController?.addCustomBottomLine(color: #colorLiteral(red: 0.07923045009, green: 0.249772191, blue: 0.2033925056, alpha: 1) ,height: 0.6)
        navigationController?.isNavigationBarHidden = false
    }
    // MARK: - Selectors
    @objc func handleRefresh() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    @objc func handleSettings() {
        let controller = SettingsController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
    // MARK: - CollectionView Delegate&DataSource
extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberofRows()
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.message = viewModel.chatForRow(at: indexPath.row)
        return cell
    }
}
    // MARK: - CollectionView DelegateFlowLayout
extension ChatController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimatedSizeCell = MessageCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 50))
        estimatedSizeCell.message = viewModel.chatForRow(at: indexPath.row)
        estimatedSizeCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}
    // MARK: - UITextFieldDelegate
extension ChatController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
    // MARK: - ChatViewModelDelegate
extension ChatController: ViewModelDelegate {
    func responseSuccess() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
    // MARK: - ChatInputDelegate
extension ChatController: ChatInputDelegate {
    func inputView(_ view: CustomInputAccessoryView, input: String) {
        self.customInputView.sendAction = { [self] in
            self.viewModel.getResponse(input: input) { result in
                switch result {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}
