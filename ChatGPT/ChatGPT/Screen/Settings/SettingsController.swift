//
//  SettingsController.swift
//  ChatGPT
//
//  Created by AKIN on 14.03.2023.
//

import UIKit

private let reuseIdentifier = "ProfileCell"

final class SettingsController: UITableViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_arrowleft")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleDismiss))
        navigationItem.title = "Settings"
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.addCustomBottomLine(color: #colorLiteral(red: 0.07923045009, green: 0.249772191, blue: 0.2033925056, alpha: 1) ,height: 0.6)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 72
        tableView.tableHeaderView = SettingsHeader(frame: .init(x: 0, y: 0,
                                                               width: view.frame.width,
                                                               height: 210))
        self.tableView.clipsToBounds = true
        self.tableView.layer.cornerRadius = 50
    }
    // MARK: - Selectors
    @objc func handleDismiss() {
        navigationController?.popViewController(animated: true)
    }
}
// MARK: - UITableViewDataSource
extension SettingsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsViewModel.allCases.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        
        let viewModel = SettingsViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        cell.selectionStyle = .none
            
        return cell
    }
}
// MARK: - UITableViewDelegate
extension SettingsController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = SettingsViewModel(rawValue: indexPath.row) else { return }
        
        switch viewModel {
        case .rateus:
            print("DEBUG: Show cart page...")
        case .contact:
            print("DEBUG: Show profile page...")
        case .policy:
            print("DEBUG: Show bildirimler...")
        case .terms:
            print("DEBUG: Show iadeler...")
        case .purchase:
            print("DEBUG: Show settings page...")
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}



