//
//  HIghLightViewController.swift
//  happpyStory
//
//  Created by karmaln technology on 13/01/22.
//

import UIKit

class HIghLightViewController: UIViewController {
    private let highLightimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "large1")
        return imageView
    }()

    private let userImageButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "karmaln"), for: .normal)
        return button
    }()

    private let userNameButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitle("highLight.ios", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.label, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()

    private let optionButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()

    private var messageField: UITextField = {
        let field = UITextField()
        field.placeholder = "message"
        field.returnKeyType = .send
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = 20
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.backgroundColor = .none
        return field
    }()

    private let sendButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.sizeToFit()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.hideKeyboardWhenTappedAround()

        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)


//        self.navigationController?.hidesBarsOnTap = true
        addsubview()
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
//        self.navigationController?.isToolbarHidden = false
    }

    private func addsubview() {
        view.addSubview(highLightimageView)
        view.addSubview(userImageButton)
        view.addSubview(userNameButton)
        view.addSubview(optionButton)
        view.addSubview(messageField)
        view.addSubview(sendButton)
    }

    override func viewDidLayoutSubviews() {
        highLightimageView.frame = view.bounds
        let size = 50
        userImageButton.frame = CGRect(x: 10, y: size, width: size, height: size)
        userImageButton.raduis(reduisSize: 25)
        userImageButton.border(borderSize: 2)
        userNameButton.frame = CGRect(x: userImageButton.right + 10, y: CGFloat(size), width: view.width - CGFloat(size * 3), height: CGFloat(size))
        optionButton.frame = CGRect(x: Int(view.width) - size - 10, y: size, width: size, height: size)

        messageField.frame = CGRect(x: 10, y: Int(view.height) - size - 20, width: Int(view.width) - size - 10, height: size)
        sendButton.frame = CGRect(x: Int(messageField.right), y:Int(view.height) - size - 20, width: size, height: size)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    var viewTranslation = CGPoint(x: 0, y: 0)
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        // The rest of the code we will write here
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
        case .ended:
            if viewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = .identity
                })
            } else {
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
