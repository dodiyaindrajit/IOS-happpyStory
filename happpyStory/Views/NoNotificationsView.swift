//
//  NoNotificationsView.swift
//  Instagram
//
//  Created by karmaln technology on 07/01/22.
//

import UIKit

class NoNotificationsView: UIView {

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.text = "No Notifications Yet."
        label.numberOfLines = 1
        return label
    }()

    private let photoimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "bell")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(photoimageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        photoimageView.frame = CGRect(x: (width - 50) / 2 , y: 0, width: 50, height: 50)
        label.frame = CGRect(x: 0, y: photoimageView.bottom, width: width, height: height - 50)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
