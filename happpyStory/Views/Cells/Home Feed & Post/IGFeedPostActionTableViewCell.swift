//
//  IGFeedPostActionTableViewCell.swift
//  Instagram
//
//  Created by karmaln technology on 31/12/21.
//

import UIKit

protocol IGFeedPostActionTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapShareButton()
    func didTapSaveButton()
}

class IGFeedPostActionTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostActionTableViewCell"

    weak var delegate: IGFeedPostActionTableViewCellDelegate?

    private static var isLike = false
    private static var isSave = false

    private let LikeButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        return button
    }()

    private let CommentButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        return button
    }()

    private let ShareButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        return button
    }()

    private let SaveButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "bookmark", withConfiguration: config)
        button.setImage(image, for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addsubview()
        addButtonAction()
        selectionStyle = .none
    }

    private func addsubview() {
        contentView.addSubview(LikeButton)
        contentView.addSubview(CommentButton)
        contentView.addSubview(ShareButton)
        contentView.addSubview(SaveButton)
    }

    private func addButtonAction() {
        LikeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        CommentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        ShareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        SaveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }

    @objc private func didTapLikeButton() {
        IGFeedPostActionTableViewCell.isLike = !IGFeedPostActionTableViewCell.isLike
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: IGFeedPostActionTableViewCell.isLike ? "heart.fill" : "heart", withConfiguration: config)
        LikeButton.setImage(image, for: .normal)
        LikeButton.tintColor = IGFeedPostActionTableViewCell.isLike ? .red : .label

        delegate?.didTapLikeButton()
    }

    @objc private func didTapCommentButton() {
        delegate?.didTapCommentButton()
    }

    @objc private func didTapShareButton() {
        delegate?.didTapShareButton()
    }

    @objc private func didTapSaveButton() {
        IGFeedPostActionTableViewCell.isSave = !IGFeedPostActionTableViewCell.isSave
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: IGFeedPostActionTableViewCell.isSave ? "bookmark.fill" : "bookmark", withConfiguration: config)
        SaveButton.setImage(image, for: .normal)
        SaveButton.tintColor = IGFeedPostActionTableViewCell.isSave ? .systemBlue : .label

        delegate?.didTapSaveButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure() {
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonSize = contentView.height - 20
        let buttons = [LikeButton, CommentButton, ShareButton]
        for i in 0 ..< buttons.count {
            let button = buttons[i]
            button.frame = CGRect(x: (CGFloat(i) * buttonSize) + (10 * CGFloat(i == 0 ? 1 : i + 1)), y: 10, width: buttonSize, height: buttonSize)
        }

        SaveButton.frame = CGRect(x: contentView.width - buttonSize - 10, y: 10, width: buttonSize, height: buttonSize)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
