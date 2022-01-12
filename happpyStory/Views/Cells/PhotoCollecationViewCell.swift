//
//  PhotoCollecationViewCell.swift
//  Instagram
//
//  Created by karmaln technology on 06/01/22.
//

import SDWebImage
import UIKit

class PhotoCollecationViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollecationViewCell"

    private let photoimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func layoutSubviews() {
        superview?.layoutSubviews()
        photoimageView.frame = contentView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoimageView.image = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoimageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double-Tap to open post"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with model: UserPost) {
        let url = model.thumbnilImage
        photoimageView.sd_setImage(with: url, completed: nil)
    }

    public func configure(debug imageName: String) {
        photoimageView.image = UIImage(named: imageName)
    }
}
