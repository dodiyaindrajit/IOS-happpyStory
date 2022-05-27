//
//  IGFeedPostGeneralTableViewCell.swift
//  Instagram
//
//  Created by karmaln technology on 31/12/21.
//

import UIKit

class IGFeedPostGeneralTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostGeneralTableViewCell"

    private let like1Button: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(named: "karmaln"), for: .normal)
        return button
    }()

    private let like2Button: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "karmaln1"), for: .normal)
        return button
    }()

    private let like3Button: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "karmaln2"), for: .normal)
        return button
    }()

    private let likeByButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitleColor(UIColor.label, for: .normal)
        button.setTitle("Like By @home.flutter and 34,545 others", for: .normal)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        return button
    }()

    private let quoteButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitleColor(UIColor.label, for: .normal)
        button.setTitle("home.flutter Last week at IceLand Here is Picture of that day. Feeling alive in nature.", for: .normal)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        return button
    }()

    private let commentsButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitleColor(UIColor.label, for: .normal)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        button.setTitle("Nice Picture we also planning for the same place. I will call you for more detials", for: .normal)
        return button
    }()

    private let timeButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitleColor(UIColor.label, for: .normal)
        button.setTitle("45 min ago.", for: .normal)
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        addsubview()
    }

    private func addsubview() {
        contentView.addSubview(like1Button)
        contentView.addSubview(like2Button)
        contentView.addSubview(like3Button)
        contentView.addSubview(likeByButton)
        contentView.addSubview(quoteButton)
        contentView.addSubview(commentsButton)
        contentView.addSubview(timeButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let size = 30
        like1Button.frame = CGRect(x: 5, y: 5, width: size, height: size)
        like1Button.border(borderSize: 1)
        like1Button.raduis(reduisSize: CGFloat(size / 2))
        like2Button.frame = CGRect(x: Int(like1Button.left) + size / 2, y: 5, width: size, height: size)
        like2Button.border(borderSize: 1)
        like2Button.raduis(reduisSize: CGFloat(size / 2))
        like3Button.frame = CGRect(x: Int(like2Button.left) + size / 2, y: 5, width: size, height: size)
        like3Button.border(borderSize: 1)
        like3Button.raduis(reduisSize: CGFloat(size / 2))

        likeByButton.frame = CGRect(x: Int(like3Button.right) + 5, y: 5, width: Int(contentView.width), height: size)
        quoteButton.frame = CGRect(x: 5, y: size + 10, width: Int(contentView.width), height: size / 2)
        commentsButton.frame = CGRect(x: 5, y: quoteButton.bottom + 5, width: contentView.width, height: CGFloat(size / 2))
        timeButton.frame = CGRect(x: 5, y: commentsButton.bottom + 5, width: contentView.width, height: CGFloat(size / 2))
    }
}
