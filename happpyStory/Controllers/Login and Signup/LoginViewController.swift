//
//  LoginViewController.swift
//  scrollViewTest
//
//  Created by karmaln technology on 23/12/21.
//

import SafariServices
import UIKit

class LoginViewController: UIViewController {
    var gradientLayer: CAGradientLayer!
    struct Constant {
        static let cornerRadius: CGFloat = 10
    }

    // MARK: - Define Components

    private var titleText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Instagram"
        label.font = UIFont(name: "Savoye LET", size: 80)
        label.textColor = UIColor.white
        return label
    }()

    private var headerView: UIView = {
        let view = UIView()
        let bgImage = UIImageView(image: UIImage(named: "logo"))
        bgImage.contentMode = .scaleAspectFill
        bgImage.layer.masksToBounds = true
        bgImage.layer.cornerRadius = Constant.cornerRadius
        view.addSubview(bgImage)
        view.clipsToBounds = true
        return view
    }()

    private var userEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constant.cornerRadius
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        return field
    }()

    private var passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Enter Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.layer.cornerRadius = Constant.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        return field
    }()

    private var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = Constant.cornerRadius
        loginButton.backgroundColor = UIColor(named: "AccentColor")
        return loginButton
    }()

    private var createAccountButton: UIButton = {
        let createButton = UIButton()
        createButton.setTitle("New User? Create an account.", for: .normal)
        createButton.setTitleColor(.label, for: .normal)
        return createButton
    }()

    private var termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms and Condition", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()

    private var privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // hide navigation bar
        navigationController?.isNavigationBarHidden = true

        // register deleagate of textfield
        userEmailField.delegate = self
        passwordField.delegate = self

        // assign button click Methods (addTarget)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)

        // creating background gradient color
        createGradientLayer()

        // adding
        addSubViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // assign frames
        let size = view.frame.size.width - 50
        titleText.frame = CGRect(x: (view.frame.size.width - size) / 2, y: 80, width: size, height: 120)

        headerView.frame = CGRect(x: 0, y: titleText.frame.size.height + 20, width: view.frame.size.width, height: view.frame.size.height / 3.0)

        userEmailField.frame = CGRect(x: 25, y: headerView.frame.origin.y + headerView.frame.size.height + 10, width: view.frame.size.width - 50, height: 52)

        passwordField.frame = CGRect(x: 25, y: userEmailField.frame.origin.y + userEmailField.frame.size.height + 10, width: view.frame.size.width - 50, height: 52)

        loginButton.frame = CGRect(x: 25, y: passwordField.frame.origin.y + passwordField.frame.size.height + 10, width: view.frame.size.width - 50, height: 52)

        createAccountButton.frame = CGRect(x: 25, y: loginButton.frame.origin.y + loginButton.frame.size.height + 10, width: view.frame.size.width - 50, height: 52)

        termsButton.frame = CGRect(x: 0, y: view.frame.size.height - 50, width: view.frame.size.width - 20, height: 40)

        privacyButton.frame = CGRect(x: 0, y: view.frame.size.height - view.safeAreaInsets.bottom - 40, width: view.frame.size.width - 20, height: 40)

        configureHeaderView()
    }

    private func configureHeaderView() {
        guard let bgView = headerView.subviews.first else {
            return
        }
        bgView.frame = CGRect(x: 20, y: view.safeAreaInsets.top, width: view.frame.size.width - view.frame.size.width / 10, height: view.frame.size.height / 4)
    }

    // MARK: - AddSubViews

    private func addSubViews() {
        view.addSubview(titleText)
        view.addSubview(headerView)
        view.addSubview(userEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }

    // MARK: - OBJ-C Methods ( AddTarget / OnClick )

    @objc private func didTapLoginButton() {
        passwordField.resignFirstResponder()
        userEmailField.resignFirstResponder()

        // checking not empty and password >= 5
        guard let userEmail = userEmailField.text, !userEmail.isEmpty, let pass = passwordField.text, !pass.isEmpty, pass.count >= 5 else {
            return
        }

        // Login user to Instagram
        if userEmail == "amit@gmail.com" && pass == "123123" {
            CommanStruc.isLogin = true
            dismiss(animated: true, completion: nil) // close current screen
        } else {
            let alert = UIAlertController(title: "Sorry... User Not Found !", message: "\nEmail: amit@gmail.com \nPassword: 123123\n", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Let's Try", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://www.consumerreports.org/privacy/instagram-privacy-settings-a3036233134/") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }

    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://www.consumerreports.org/privacy/instagram-privacy-settings-a3036233134/") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }

    @objc private func didTapCreateAccountButton() {
        let vc = RegisterViewController()
        present(vc, animated: true, completion: nil)
    }

    private func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.red.cgColor, UIColor.yellow.cgColor]
        view.layer.addSublayer(gradientLayer)
        view.clipsToBounds = true
    }
}

// MARK: - UITextField Delegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
}
