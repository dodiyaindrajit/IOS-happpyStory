//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by karmaln technology on 31/12/21.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String
}

class EditProfileViewController: UIViewController {
    // MARK: - Define Variable

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormFeildTableViewCell.self, forCellReuseIdentifier: FormFeildTableViewCell.identifier)
        return tableView
    }()

    private var models = [[EditProfileFormModel]]()

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configurModel()
        tableView.tableHeaderView = createTableHeaderView()
        tableView.dataSource = self
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }

    private func configurModel() {
        let section1Labels = ["Name", "Username", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: "")
            section1.append(model)
        }
        models.append(section1)

        let section2Labels = ["email", "Phone", "Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: "")
            section2.append(model)
        }
        models.append(section2)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    // MARK: - UIMethods

    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3).integral)

        let size = header.frame.size.height / 1.5
        let button: UIButton = UIButton(frame: CGRect(x: (view.frame.size.width - size) / 2, y: 50, width: size, height: size))
        button.layer.masksToBounds = true
        button.layer.cornerRadius = size / 2
        button.tintColor = .gray
        button.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)

        header.addSubview(button)
        return header
    }

    // MARK: - Obj C Methods

    @objc private func buttonClicked() {
        print("Button Clicked")
    }

    @objc private func didTapProfilePhoto() {
    }

    @objc private func didTapSave() {
        // save info to database
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change Profile Picture", preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in }))

        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionSheet, animated: true)
    }
}

// MARK: - TableViewDataSource

extension EditProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormFeildTableViewCell.identifier, for: indexPath) as! FormFeildTableViewCell

        cell.delegate = self

        cell.configure(with: model)

//        cell.textLabel?.text = model.label

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Information"
    }
}

// MARK: - FormFeildTable Delegate

extension EditProfileViewController: FormFeildTableViewCellDelegate {
    func formTableViewCell(_ cell: FormFeildTableViewCell, didUpadateField updatedModel: EditProfileFormModel) {
        print("Updated Content: \(updatedModel.value)")
    }
}
