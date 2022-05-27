//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by karmaln technology on 31/12/21.
//

import UIKit

protocol IGFeedPostTableViewCellDelegate: AnyObject {
    func didTapdoubleTap()
}

// cell for primary post content
final class IGFeedPostTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostTableViewCell"
    private let like = false

    weak var delegate: IGFeedPostTableViewCellDelegate?

    private let postimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "test")

        return imageView
    }()

    private let likeimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.isHidden = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(postimageView)
        contentView.addSubview(likeimageView)
        selectionStyle = .none

        //doubleTap Gesture-Recognization
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(doubleTap)
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


    //animation Heart
    @objc func handleDoubleTap() {
        Configuration.value(value: "my_value", forKey: "key_1")
        UIView.transition(with: likeimageView,
                          duration: 1,
                          options: .transitionCrossDissolve,
                          animations: { self.likeimageView.isHidden = false },
                          completion: { _ in self.likeimageView.isHidden = true })
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let size = 100
        postimageView.frame = contentView.bounds
        likeimageView.frame = CGRect(x: Int(width) / 2 - 50, y: Int(width) / 2 - 50, width: size, height: size)
    }
}
