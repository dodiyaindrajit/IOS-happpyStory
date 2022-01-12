//
//  NotificationLikeEventTableViewCell.swift
//  Instagram
//
//  Created by karmaln technology on 10/01/22.
//

import SDWebImage
import UIKit

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationLikeEventTableViewCell"

    weak var delegate: NotificationLikeEventTableViewCellDelegate?

    private var model: UserNotification?

    private let profileimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "karmaln")
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@amit.flutter like Your Photos"
        return label
    }()

    private let postButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setImage(UIImage(named: "test"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileimageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        addButtonAction()
        selectionStyle = .none
    }

    private func addButtonAction(){
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
    }

    @objc private func didTapPostButton (){
        guard let model = model else {
            return
        }
        delegate?.didTapRelatedPostButton(model: model)
    }

    public func configure(with model: UserNotification) {
        self.model = model

        switch model.type {
        case let .like(post):
            let thumbnail = post.thumbnilImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            postButton.sd_setImage(with: thumbnail, for: .normal, completed: nil)
        case .follow:
            break
        }

        label.text = model.text
        profileimageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileimageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        profileimageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)

        let size = contentView.height - 4
        postButton.frame = CGRect(x: contentView.width - 5 - size, y: 2, width: size, height: size)

        label.frame = CGRect(x: profileimageView.right + 5, y: 0, width: contentView.width - size - profileimageView.width - 16, height: contentView.height)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
