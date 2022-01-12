//
//  IGFeedHeaderTableViewCell.swift
//  Instagram
//
//  Created by karmaln technology on 31/12/21.
//

import SDWebImage
import UIKit

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapmoreButton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {

    weak var delegate : IGFeedPostHeaderTableViewCellDelegate?

    private let photoimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "karmaln")
        return imageView
    }()

    private let userLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "@amit.flutter"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()

    private let moreButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)

        return button
    }()

    static let identifier = "IGFeedHeaderTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .green
        contentView.addSubview(photoimageView)
        contentView.addSubview(userLabel)
        contentView.addSubview(moreButton)
        selectionStyle = .none
        addButtonAction()
    }

    private func addButtonAction() {
        moreButton.addTarget(self, action: #selector(didTapmoreButton), for: .touchUpInside)
    }

    @objc private func didTapmoreButton() {
        print("Tap on Options..!")
        delegate?.didTapmoreButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with model: User) {
        userLabel.text = model.userName
//        photoimageView.sd_setImage(with: model.profilePhoto, completed: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height - 4
        photoimageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
        photoimageView.raduis(reduisSize: size / 2)

        moreButton.frame = CGRect(x: contentView.width - size - 2, y: 2, width: size, height: size)

        userLabel.frame = CGRect(x: photoimageView.right + 10, y: 2, width: contentView.width - (size * 2) - 15, height: size)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        userLabel.text = nil
//        photoimageView.image = nil
    }
}
