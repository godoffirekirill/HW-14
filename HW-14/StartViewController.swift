//
//  ViewController.swift
//  HW-14
//
//  Created by Кирилл Курочкин on 02.06.2024.
//

import UIKit

class StartViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let outerStackView = UIStackView()
    let innerStackView = UIStackView()
    let innerStackViewTwo = UIStackView()
    let printLabel = UILabel()
    let addressLabelOne = UILabel()
    let forgotPassLabel = UILabel()
    let createAccountLabel = UILabel()
 //   let logInButton = UIButton(type: .system)
    let emailTextField = CustomTextField()
    let passTextField = CustomTextField()
    let customButton = CustomButton()
    let flexibleSpacerView = UIView()
    
    var flexibleSpacerMinHeightConstraint: NSLayoutConstraint!
    var flexibleSpacerMaxHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground(imageNammed: "BackgroundImage2")
        setupScrollView()
        setupOuterStackView()
        
        customButton.onTap = { [weak self] in
                    self?.customButtonTapped()
                }
        
        
        // Adding the button action
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func customButtonTapped() {
//        let viewController = SecondViewController()
//        viewController.modalPresentationStyle = .fullScreen
//        present(viewController, animated: true)
//        
        let secondVC = SecondViewController()
                navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func setupBackground(imageNammed: String) {
        let backgroundImageView = UIImageView(frame: self.view.bounds)
        backgroundImageView.image = UIImage(named: imageNammed)
        backgroundImageView.contentMode = .scaleAspectFill
        
        backgroundImageView.contentMode = .bottomRight
        
        self.view.addSubview(backgroundImageView)
        self.view.sendSubviewToBack(backgroundImageView)
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupOuterStackView() {
        outerStackView.axis = .vertical
        outerStackView.spacing = 24
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(outerStackView)
        
        printLabel.text = "YOUR\nART\nMUSEUM"
        printLabel.font = UIFont(name: "Helvetica", size: 36)
        printLabel.textColor = .white
        printLabel.textAlignment = .left
        printLabel.numberOfLines = 0
        
        addressLabelOne.text = "151 3rd St\nSan Francisco, CA 94103 "
        addressLabelOne.textAlignment = .left
        addressLabelOne.font = UIFont(name: "Helvetica", size: 12)
        addressLabelOne.numberOfLines = 0
        addressLabelOne.textColor = .white
        
        innerStackView.axis = .vertical
        innerStackView.spacing = 1
        innerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.placeholder = "Email address"
        emailTextField.userDefaultsKey = "login"

        passTextField.placeholder = "Password"
        passTextField.userDefaultsKey = "password"

        
        
        forgotPassLabel.text = "Forgot your password?"
        forgotPassLabel.textAlignment = .right
        forgotPassLabel.font = UIFont(name: "Helvetica", size: 10)
        forgotPassLabel.numberOfLines = 0
        forgotPassLabel.textColor = .white
        forgotPassLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([forgotPassLabel.heightAnchor.constraint(equalToConstant: 24.0)])
        
        innerStackViewTwo.axis = .vertical
        innerStackViewTwo.spacing = 12
        innerStackViewTwo.translatesAutoresizingMaskIntoConstraints = false
        innerStackViewTwo.addArrangedSubview(customButton)
        innerStackViewTwo.addArrangedSubview(createAccountLabel)
        
        let attr = customButton.fontInstall(textButton: "Log In", fontName: "Helvetica", size: 12)
        customButton.setAttributedTitle(attr, for: .normal)
        customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)

        createAccountLabel.text = "Don’t have an account?"
        createAccountLabel.textAlignment = .left
        createAccountLabel.font = UIFont(name: "Helvetica", size: 10)
        createAccountLabel.numberOfLines = 0
        createAccountLabel.textColor = .white
        
        flexibleSpacerView.translatesAutoresizingMaskIntoConstraints = false
        
        innerStackView.addArrangedSubview(emailTextField)
        innerStackView.addArrangedSubview(passTextField)
        innerStackView.addArrangedSubview(forgotPassLabel)
        outerStackView.addArrangedSubview(flexibleSpacerView)
        outerStackView.addArrangedSubview(printLabel)
        outerStackView.addArrangedSubview(addressLabelOne)
        outerStackView.addArrangedSubview(innerStackView)
        outerStackView.addArrangedSubview(innerStackViewTwo)
        
        flexibleSpacerMinHeightConstraint = flexibleSpacerView.heightAnchor.constraint(equalToConstant: 100)
        flexibleSpacerMinHeightConstraint.priority = .defaultLow
        
        flexibleSpacerMaxHeightConstraint = flexibleSpacerView.heightAnchor.constraint(equalToConstant: 181.5)
        flexibleSpacerMaxHeightConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 68),
            outerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -60),
            outerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            outerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -128),
            flexibleSpacerMinHeightConstraint,
            flexibleSpacerMaxHeightConstraint
        ])
    }
    
    @objc
    func keyboardWillChangeFrame(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
            return
        }

        let isKeyboardShowing = keyboardFrame.origin.y < UIScreen.main.bounds.height
        let keyboardHeight = isKeyboardShowing ? keyboardFrame.height : 0

        additionalSafeAreaInsets = UIEdgeInsets(
            top: 0, left: 0,
            bottom: keyboardHeight - (view.window?.safeAreaInsets.bottom ?? 0), right: 0)

        flexibleSpacerMinHeightConstraint.isActive = isKeyboardShowing
        flexibleSpacerMaxHeightConstraint.isActive = !isKeyboardShowing

        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve << 16), animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)

        let textFields = [emailTextField, passTextField]
        guard let tf = textFields.first(where: { $0.isFirstResponder }) else {
            return
        }

        let convertedFrame = scrollView.convert(tf.frame, from: tf.superview)
        scrollView.scrollRectToVisible(convertedFrame, animated: true)
    }

    @objc
    func keyboardWillHide(_ notification: Notification) {
        additionalSafeAreaInsets = .zero

        flexibleSpacerMinHeightConstraint.isActive = false
        flexibleSpacerMaxHeightConstraint.isActive = true
    }

    @objc
    func tapGestureHandler(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        view.endEditing(true)
    }
    
    @objc
    func nextActionTapped(_ sender: CustomTextField) {
        switch sender {
        case emailTextField:
            passTextField.becomeFirstResponder()
        default:
            break
        }
    }
    @objc private func emailTextFieldEditingChanged(_ textField: UITextField) {
            UserDefaultsManager.login = textField.text // Save to UserDefaults
        }
        
        @objc private func passwordTextFieldEditingChanged(_ textField: UITextField) {
            UserDefaultsManager.password = textField.text // Save to UserDefaults
        }
}

//#Preview {
//    StartViewController()
//}
