//
//  CustomButton.swift
//  HW-14
//
//  Created by Кирилл Курочкин on 11.06.2024.
//

import UIKit

class CustomButton: UIButton {
    
    var onTap: (() -> Void)?

    private let backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .colorButton
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10.0
        view.clipsToBounds = false
        return view
    }()
    
    private let innerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        clipsToBounds = false
        
        addSubview(backgroundView)
        addSubview(innerButton)
        sendSubviewToBack(backgroundView)

        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: 50),
            innerButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            innerButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            innerButton.topAnchor.constraint(equalTo: topAnchor),
            innerButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        innerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        onTap?()
    }
}

extension CustomButton {
    func fontInstall(textButton: String, fontName: String, size: CGFloat) -> NSAttributedString {
        if let customFont = UIFont(name: fontName, size: size) {
            let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: customFont]
            return NSAttributedString(string: textButton, attributes: attributes)
        } else {
            return NSAttributedString(string: textButton, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)])
        }
    }
}

//#Preview {
//    CustomButton()
//}


