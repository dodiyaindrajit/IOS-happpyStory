//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by karmaln technology on 06/01/22.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate : AnyObject{
    func didTapGridButton()
    func didTapTaggedButton()
    func didTapReelButton()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"

    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?

    struct Constants {
        static let padding : CGFloat = 6
    }

    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()

    private let reelButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "list.and.film"), for: .normal)
        return button
    }()

    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addsubview()
        addButtonAction()
    }

    private func addsubview() {
        addSubview(gridButton)
        addSubview(taggedButton)
        addSubview(reelButton)
    }

    private func addButtonAction() {
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
        reelButton.addTarget(self, action: #selector(didTapReelButton), for: .touchUpInside)
    }

    @objc private func didTapGridButton() {
        delegate?.didTapGridButton()
        gridButton.tintColor = .label
        reelButton.tintColor = .systemGray
        taggedButton.tintColor = .systemGray
    }

    @objc private func didTapReelButton() {
        delegate?.didTapTaggedButton()
        gridButton.tintColor = .systemGray
        reelButton.tintColor = .label
        taggedButton.tintColor = .systemGray
    }

    @objc private func didTapTaggedButton() {
        delegate?.didTapTaggedButton()
        gridButton.tintColor = .systemGray
        reelButton.tintColor = .systemGray
        taggedButton.tintColor = .label
    }



    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - (Constants.padding * 3)
        let gridButtonx = ((width / 3) - size) / 2
        gridButton.frame = CGRect(x: gridButtonx, y: Constants.padding, width: size, height: size)
        reelButton.frame = CGRect(x: (width / 2) - (size / 2), y: Constants.padding, width: size, height: size)
        taggedButton.frame = CGRect(x: width - (width / 3) + (((width / 3) / 2)-(size/2)), y: Constants.padding, width: size, height: size)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
