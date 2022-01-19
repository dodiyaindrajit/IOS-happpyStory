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
    func profileHeaderDidTapHighLightProfileButton()
}

final class ProfileinfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileinfoHeaderCollectionReusableView"

    public weak var delegate: ProfileinfoHeaderCollectionReusableViewDelegate?
    private var highLightCollectionView: UICollectionView?

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
        return button
    }()

    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follwing", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follwers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    private let numOfPost: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "69"
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()

    private let numOfFollower: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "391"
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()

    private let numOfFollowing: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "306"
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = " amit prajapati"
        return label
    }()

    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 3 // line wrap
        label.text = " IT - Aspirent \n Let's Make better World Togethter. \n infoonclick.000webhostapp.com"
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
        addSubview(numOfPost)
        addSubview(numOfFollower)
        addSubview(numOfFollowing)
        configureHighLightCollectionView()
    }

    private func configureHighLightCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width / 4, height: width / 4)
        layout.scrollDirection = .horizontal
        highLightCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        highLightCollectionView?.register(HighlightTableViewCell.self, forCellWithReuseIdentifier: HighlightTableViewCell.identifier)
        highLightCollectionView?.backgroundColor = .systemBackground
        highLightCollectionView?.showsHorizontalScrollIndicator = false
        guard let highLightCollectionView = highLightCollectionView else {
            return
        }
        highLightCollectionView.delegate = self
        highLightCollectionView.dataSource = self
        addSubview(highLightCollectionView)
    }

    // MARK: - ButtonAction Method

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

    // MARK: - LayoutsubViews

    override func layoutSubviews() {
        super.layoutSubviews()

        let profilePhotoSize = width / 4
        profilePhotoimageView.frame = CGRect(x: 5, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
        profilePhotoimageView.raduis(reduisSize: profilePhotoimageView.height / 2)

        let buttonHeight = profilePhotoSize / 2
        let countButtonWidth = (width - 15 - profilePhotoSize) / 3

        numOfPost.frame = CGRect(x: profilePhotoimageView.right + 5, y: 5, width: countButtonWidth, height: buttonHeight).integral

        numOfFollower.frame = CGRect(x: numOfPost.right, y: 5, width: countButtonWidth, height: buttonHeight).integral

        numOfFollowing.frame = CGRect(x: numOfFollower.right, y: 5, width: countButtonWidth, height: buttonHeight).integral

        postsButton.frame = CGRect(x: profilePhotoimageView.right + 5, y: buttonHeight - 15, width: countButtonWidth, height: buttonHeight).integral

        followersButton.frame = CGRect(x: postsButton.right, y: buttonHeight - 15, width: countButtonWidth, height: buttonHeight).integral

        followingButton.frame = CGRect(x: followersButton.right, y: buttonHeight - 15, width: countButtonWidth, height: buttonHeight).integral

        nameLabel.frame = CGRect(x: 5, y: 5 + profilePhotoimageView.bottom, width: width - 10, height: 50).integral

        let bioLabelSize = bioLabel.sizeThatFits(frame.size) // Expanded Size like Flutter
        bioLabel.frame = CGRect(x: 5, y: nameLabel.bottom - 5, width: width - 10, height: bioLabelSize.height).integral

        editProfileButton.frame = CGRect(x: 5, y: bioLabel.bottom + 5, width: width - 10, height: buttonHeight - 15).integral
        editProfileButton.raduis(reduisSize: 5.0)
        editProfileButton.border(borderSize: 2.0)

        highLightCollectionView?.frame = CGRect(x: 5, y: editProfileButton.bottom + 5, width: width - 10, height: height / 4)
    }
}

// MARK: - UICollectionViewDelegate

extension ProfileinfoHeaderCollectionReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HighlightTableViewCell.identifier, for: indexPath) as? HighlightTableViewCell else {
            return UICollectionViewCell()
        }
//        cell.configure(debug: "karmaln")
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - HightLightTableView Delegate

extension ProfileinfoHeaderCollectionReusableView: HighlightTableViewCellDelegate {
    func didTapRelatedHighLightButton(model: String) {
        delegate?.profileHeaderDidTapHighLightProfileButton()
    }
}
