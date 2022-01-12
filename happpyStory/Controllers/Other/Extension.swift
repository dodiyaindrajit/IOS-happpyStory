//
//  extension.swift
//  scrollViewTest
//
//  Created by karmaln technology on 24/12/21.
//
import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }

    var height: CGFloat {
        return frame.size.height
    }

    var top: CGFloat {
        return frame.origin.y
    }

    var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }

    var left: CGFloat {
        return frame.origin.x
    }

    var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}

extension UIImageView {
    func raduis(reduisSize: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = reduisSize
    }
}

extension UIButton {
    func raduis(reduisSize: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = reduisSize
    }
}
