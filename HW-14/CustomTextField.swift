//
//  CustomTextField.swift
//  HW-14
//
//  Created by Кирилл Курочкин on 10.06.2024.
//

import UIKit

class CustomTextField: UIControl {
    private let backgroundView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
//        view.layer.shadowOpacity = 1.0
//        view.layer.shadowRadius = 20.0
      //  view.layer.cornerRadius = 10.0
        view.clipsToBounds = false
        return view
    }()
    
    private let textField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        textField.borderStyle = .none
        return textField
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

    }
    
    var userDefaultsKey: String? {
         didSet {
             // Load text from UserDefaults when the key is set
             if let key = userDefaultsKey {
                 textField.text = UserDefaults.standard.string(forKey: key)
             }
         }
     }
    
    var text: String {
        get {
            textField.text ?? ""
        }
        
        set {
            textField.text = newValue
        }
    }
    var placeholder: String = "" {
        didSet {
            let placeholderString = AttributedString(
                placeholder,
                attributes: AttributeContainer()
                    .foregroundColor(UIColor.secondaryLabel)
                    .font(UIFont.systemFont(ofSize: 12.0, weight: .regular)))
            
            textField.attributedPlaceholder = NSAttributedString(placeholderString)
        }
    }
    
    
    private func setup() {
        backgroundColor = .clear
        clipsToBounds = false
        
        
        addSubview(backgroundView)
        addSubview(textField)
        
        textField.addTarget(self, action: #selector(textFieldEditingBegin(_:)),
                            for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldEditingEnd(_:)),
                            for: .editingDidEnd)
        textField.addTarget(self, action: #selector(textFieldEditingEndOnExit(_:)), for: .editingDidEndOnExit)
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.addTarget(self, action: #selector(tapGestureAction(_:)))
        addGestureRecognizer(tapGestureRecognizer)
        
        
        
        NSLayoutConstraint.activate([
                backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
                backgroundView.topAnchor.constraint(equalTo: topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
                textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                textField.centerYAnchor.constraint(equalTo: centerYAnchor),
                textField.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 10),
                textField.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10),
                heightAnchor.constraint(equalToConstant: 42) // Set height constraint
            ])
        
    

    }
    @objc
    private func tapGestureAction(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else {
            return
        }
        
        textField.becomeFirstResponder()
    }
    
    @objc
    private func textFieldEditingBegin(_ sender: UITextField) {
        sendActions(for: .editingDidBegin)
    }
    
    @objc
    private func textFieldEditingEnd(_ sender: UITextField) {
        sendActions(for: .editingDidEnd)
        
    }
    
    @objc
    private func textFieldEditingEndOnExit(_ sender: UITextField) {
        sendActions(for: .editingDidEndOnExit)
    }
    
    @objc
    private func textFieldEditingChanged(_ sender: UITextField) {
        sendActions(for: .editingChanged)
        if let key = userDefaultsKey {
                   UserDefaults.standard.set(sender.text, forKey: key)
               }
    }
}


//#Preview {
//    CustomTextField()
//}
