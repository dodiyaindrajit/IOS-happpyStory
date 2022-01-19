//
//  SettingsViewController.swift
//  scrollViewTest
//
//  Created by karmaln technology on 24/12/21.
//

import SafariServices
import UIKit

struct SettingsCellModel {
    let title: String
    let handle: () -> Void
}

// view controller to show user settings
final class SettingsViewController: UIViewController {
    // MARK: - constant

    struct K {
        static let settngsCell = "setingsCell"
    }

    // MARK: - setup UI variable

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.settngsCell)
        return tableView
    }()

    private var data = [[SettingsCellModel]]()

    // MARK: - Override Method

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModel()
        addSubView()
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func addSubView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }

    // MARK: - Methods

    private func configureModel() {
        data.append([
            SettingsCellModel(title: "Edit Profile") { [self] in
                self.didTapEditProfile()
            },
            SettingsCellModel(title: "Invite Friends") { [self] in
                self.didTapInviteFriends()
            },
            SettingsCellModel(title: "Save Original Posts") { [self] in
                self.didTapSavePost()
            },
        ])
        data.append([
            SettingsCellModel(title: "Terms of Service") { [self] in
                self.openUrl(type: .terms)
            },
            SettingsCellModel(title: "Privacy Policy") { [self] in
                self.openUrl(type: .privacy)
            },
            SettingsCellModel(title: "Help / Feedback") { [self] in
                self.openUrl(type: .help)
            },

        ])
        data.append([SettingsCellModel(title: "Logout") { [self] in
            self.didTapLogOut()
        }])
    }

    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let newVc = UINavigationController(rootViewController: vc)
        newVc.modalPresentationStyle = .fullScreen
        present(newVc, animated: true, completion: nil)
    }

    private func didTapInviteFriends() {
        // show share sheet to invite frineds
    }

    private func didTapSavePost() {
    }

    enum SettingUrlType {
        case terms, privacy, help
    }

    private func openUrl(type: SettingUrlType) {
        let urlString: String
        switch type {
        case .terms: urlString = "https://help.instagram.com/581066165581870"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .help: urlString = "https://help.instagram.com/"
        }

        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }

    private func didTapLogOut() {
        // Logout Logic

        let actionsheet = UIAlertController(title: "Logout", message: "Are You Sure You Want To Logout ?", preferredStyle: .actionSheet)

        actionsheet.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        actionsheet.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: {
            _ in DispatchQueue.main.async {
                let loginvc = LoginViewController()
                loginvc.modalPresentationStyle = .fullScreen
                self.present(loginvc, animated: false, completion: nil)
                print("User Logiout Sucessfully... -> LoginScreen")
                CommanStruc.isLogin = false
                self.navigationController?.popToRootViewController(animated: true)
                self.tabBarController?.selectedIndex = 0
            }
        }))

        actionsheet.popoverPresentationController?.sourceView = tableView
        actionsheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionsheet, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate , DataSource

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.settngsCell, for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle Cell Selecation
        data[indexPath.section][indexPath.row].handle()
    }
}

