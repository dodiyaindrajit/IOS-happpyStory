//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by karmaln technology on 07/01/22.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: String)
}

class UserFollowTableViewCell: UITableViewCell {
    static let identifier = "UserFollowTableViewCell"

    private weak var delegate: UserFollowTableViewCellDelegate?

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "karmaln")
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "Amit Prajapati"
        return label
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "amit_ap_237"
        return label
    }()

    private let followButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .link
        button.setTitle("Follow", for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
    }

    public func configure(with model: String) {}

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        userNameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.tintColor = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileImageView.raduis(reduisSize: profileImageView.height / 2)

        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width / 3

        followButton.frame = CGRect(x: contentView.width - 5 - buttonWidth, y: (contentView.height / 2) - 15 , width: buttonWidth, height: contentView.height - 30)
        followButton.raduis(reduisSize: followButton.height / 2)

        let labelHeight = contentView.height / 2
        nameLabel.frame = CGRect(x: profileImageView.right + 10, y: 0, width: contentView.width - 8 - profileImageView.width - buttonWidth, height: labelHeight)
        userNameLabel.frame = CGRect(x: profileImageView.right + 10, y: nameLabel.bottom, width: contentView.width - 8 - profileImageView.width - buttonWidth, height: labelHeight)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
