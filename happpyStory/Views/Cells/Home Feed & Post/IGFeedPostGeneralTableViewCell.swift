//
//  IGFeedPostGeneralTableViewCell.swift
//  Instagram
//
//  Created by karmaln technology on 31/12/21.
//

import UIKit

class IGFeedPostGeneralTableViewCell: UITableViewCell {


    static let identifier = "IGFeedPostGeneralTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(){

    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
