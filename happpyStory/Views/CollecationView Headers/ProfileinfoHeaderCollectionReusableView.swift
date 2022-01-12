//
//  ProfileinfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by karmaln technology on 06/01/22.
//

import UIKit

protocol ProfileinfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostButton(_ header: ProfileinfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowerButton(_ header: ProfileinfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileinfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileinfoHeaderCollectionReusableView)
}

final class ProfileinfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileinfoHeaderCollectionReusableView"

    public weak var delegate: ProfileinfoHeaderCollectionReusableViewDelegate?

    private let profilePhotoimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "karmaln")
        return imageView
    }()

    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follwing", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follwers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "Sansa Modem"
        return label
    }()

    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0 // line wrap
        label.text = "Android Devloper @KarmaLn since 2022"
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        addsubview()
        addButtonAction()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }

    private func addsubview() {
        addSubview(profilePhotoimageView)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(postsButton)
        addSubview(bioLabel)
        addSubview(nameLabel)
        addSubview(editProfileButton)
    }

    private func addButtonAction() {
        postsButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollwingButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
    }

    @objc private func didTapPostButton() {
        delegate?.profileHeaderDidTapPostButton(self)
    }

    @objc private func didTapFollwingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }

    @objc private func didTapFollowersButton() {
        delegate?.profileHeaderDidTapFollowerButton(self)
    }

    @objc private func didTapEditButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let profilePhotoSize = width / 4
        profilePhotoimageView.frame = CGRect(x: 5, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
        profilePhotoimageView.raduis(reduisSize: profilePhotoimageView.height / 2)

        let buttonHeight = profilePhotoSize / 2
        let countButtonWidth = (width - 10 - profilePhotoSize) / 3

        postsButton.frame = CGRect(x: profilePhotoimageView.right, y: 5, width: countButtonWidth, height: buttonHeight).integral

        followersButton.frame = CGRect(x: postsButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral

        followingButton.frame = CGRect(x: followersButton.right, y: 5, width: countButtonWidth, height: buttonHeight).integral

        editProfileButton.frame = CGRect(x: profilePhotoimageView.right, y: 5 + buttonHeight, width: countButtonWidth * 3, height: buttonHeight).integral

        nameLabel.frame = CGRect(x: 5, y: 5 + profilePhotoimageView.bottom, width: width - 10, height: 50).integral

        let bioLabelSize = bioLabel.sizeThatFits(frame.size) // Expanded Size like Flutter
        bioLabel.frame = CGRect(x: 5, y: 5 + nameLabel.bottom, width: width - 10, height: bioLabelSize.height).integral
    }
}
