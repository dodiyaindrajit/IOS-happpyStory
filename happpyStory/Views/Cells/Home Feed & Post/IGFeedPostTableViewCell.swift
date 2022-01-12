//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by karmaln technology on 31/12/21.
//

import UIKit

// cell for primary post content
final class IGFeedPostTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostTableViewCell"

    private let postimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "test")
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(postimageView)
        contentView.backgroundColor = .orange
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with post: UserPost) {
        switch post.postType {
        case .photo:
            // image
            break
        case .video:
            // video
            break
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        postimageView.frame = contentView.bounds
    }
}
