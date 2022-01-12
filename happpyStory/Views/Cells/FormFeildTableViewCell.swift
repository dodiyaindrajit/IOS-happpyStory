//
//  FormFeildTableViewCell.swift
//  Instagram
//
//  Created by karmaln technology on 05/01/22.
//

import UIKit

// MARK: - Protocal

protocol FormFeildTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormFeildTableViewCell, didUpadateField updateModel: EditProfileFormModel)
}

class FormFeildTableViewCell: UITableViewCell, UITextFieldDelegate {
    // MARK: - Define Variable

    static let identifier = "FormFeildTabelViewCell"

    private var model: EditProfileFormModel?

    public weak var delegate: FormFeildTableViewCellDelegate?

    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1

        return label
    }()

    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()

    // MARK: - Override Mothods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(field)
        contentView.addSubview(formLabel)
        field.delegate = self
        selectionStyle = .none
    }

    public func configure(with model: EditProfileFormModel) {
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // assign field subviews
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width / 3, height: contentView.frame.size.height)

        field.frame = CGRect(x: formLabel.frame.origin.x + formLabel.frame.size.width + 5, y: 0, width: contentView.frame.size.width - 10 - formLabel.frame.size.width, height: contentView.frame.size.height)
    }

    // MARK: - TextField Delegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text!
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell(self, didUpadateField: model)
        textField.resignFirstResponder()
        return true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
