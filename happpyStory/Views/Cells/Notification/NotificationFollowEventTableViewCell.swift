//
//  NotificationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by karmaln technology on 10/01/22.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnFollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationFollowEventTableViewCell"

    weak var delegate: NotificationFollowEventTableViewCellDelegate?

    private var model: UserNotification?

    private let profileimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "karmaln2")
//        imageView.backgroundColor = .red
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
//        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "@Vandana Started Follwing You"
        return label
    }()

    private let followButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .link
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true

        contentView.addSubview(profileimageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        addButtonAction()
        selectionStyle = .none
    }

    private func addButtonAction() {
        followButton.addTarget(self, action: #selector(didTapfollowButton), for: .touchUpInside)
    }

    @objc private func didTapfollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnFollowButton(model: model)
    }

    public func configure(with model: UserNotification) {
        self.model = model

        switch model.type {
        case .like:
            break
        case .follow:
            break
        }

        label.text = model.text
        profileimageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileimageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        profileimageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileimageView.raduis(reduisSize: profileimageView.height / 2)

        let size = contentView.height - 4
        followButton.frame = CGRect(x: contentView.width - 5 - 80, y: 10, width: 80, height: size / 1.5)
        followButton.raduis(reduisSize: followButton.height / 2)

        label.frame = CGRect(x: profileimageView.right + 5, y: 0, width: contentView.width - size - profileimageView.width - 16, height: contentView.height)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
