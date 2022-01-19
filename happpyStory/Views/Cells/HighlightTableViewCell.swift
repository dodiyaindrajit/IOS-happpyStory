//
//  HighlightTableViewCell.swift
//  happpyStory
//
//  Created by karmaln technology on 12/01/22.
//

import UIKit

protocol HighlightTableViewCellDelegate: AnyObject {
    func didTapRelatedHighLightButton(model: String)
}

class HighlightTableViewCell: UICollectionViewCell {
    static let identifier = "HighlightTableViewCell"

    weak var delegate:HighlightTableViewCellDelegate?

//    private let highLightButton: UIImageView = {
//        let imageView = UIImageView()
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.borderWidth = 2
//        imageView.layer.borderColor = UIColor.gray.cgColor
//        return imageView
//    }()

    private let highLightButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setImage(UIImage(named: "test"), for: .normal)
        return button
    }()

    private let highlightNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.text = "Arijit+Love=􀊹"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(highLightButton)
        contentView.addSubview(highlightNameLabel)
        contentView.clipsToBounds = true
        addButtonAction()
    }

    private func addButtonAction() {
        highLightButton.addTarget(self, action: #selector(didTapRelatedHighLightButton), for: .touchUpInside)
    }

    @objc private func didTapRelatedHighLightButton() {
        delegate?.didTapRelatedHighLightButton(model: "")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        superview?.layoutSubviews()
        highLightButton.frame = CGRect(x: 10, y: 0, width: width - 20, height: height - 20)
        highLightButton.raduis(reduisSize: (height - 20) / 2)
        highlightNameLabel.frame = CGRect(x: 0, y: highLightButton.bottom + 1, width: width, height: 20)
    }

//    public func configure(with model: UserPost) {
//        let url = model.thumbnilImage
//        highLightButton.sd_setImage(with: url, completed: nil)
//    }

//    public func configure(debug imageName: String) {
//        highLightButton.image = UIImage(named: imageName)
//    }
}
