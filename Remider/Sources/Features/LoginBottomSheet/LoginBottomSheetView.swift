//
//  LoginBottoSheetView.swift
//  Remider
//
//  Created by Murilo Alves on 01/04/25.
//

import Foundation
import UIKit

class LoginBottomSheetView: UIView {
    
    public weak var delegate: LoginBottomSheetViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        
        label.text = "login.welcome.title".localizes
        label.font = Typography.subheading
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    private let labelEmail: UILabel = {
        let label = UILabel()
        
        label.text = "login.email.label".localizes
        label.font = Typography.input
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let emailTextField: UITextField = {
        let emailField = UITextField()
        
        emailField.placeholder = "login.email.placeholder".localizes
        emailField.borderStyle = .roundedRect
        emailField.layer.cornerRadius = Metrics.tiny
        emailField.translatesAutoresizingMaskIntoConstraints = false
        
        return emailField
    }()
    
    
    private let labelSenha: UILabel = {
        let label = UILabel()
        
        label.text = "login.password.label".localizes
        label.font = Typography.input
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let passwordField: UITextField = {
       let passwordField = UITextField()
        
        passwordField.placeholder = "login.password.label".localizes
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true
        passwordField.layer.cornerRadius = Metrics.tiny
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        return passwordField
    }()
    
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("login.button.title".localizes, for: .normal)
        button.backgroundColor = Colors.redBase
        button.tintColor = .white
        button.titleLabel?.font = Typography.subheading
        button.layer.cornerRadius = Metrics.medium
        button.addTarget(self, action: #selector(loginButtonDidTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = Metrics.small
        
        addSubview(titleLabel)
        addSubview(labelEmail)
        addSubview(emailTextField)
        addSubview(labelSenha)
        addSubview(passwordField)
        addSubview(loginButton)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.gg),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            
            labelEmail.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.medium),
            labelEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            
            emailTextField.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: Metrics.tiny),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.medium),
            emailTextField.heightAnchor.constraint(equalToConstant: Metrics.xl),
            
            labelSenha.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Metrics.medium),
            labelSenha.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            
            passwordField.topAnchor.constraint(equalTo: labelSenha.bottomAnchor, constant: Metrics.tiny),
            passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.medium),
            passwordField.heightAnchor.constraint(equalToConstant: Metrics.xl),
            
            
            loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metrics.huge),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            loginButton.heightAnchor.constraint(equalToConstant: Metrics.xl),
        ])
    }
    
    @objc
    private func loginButtonDidTapped(){
        let user = emailTextField.text ?? ""
        let password = passwordField.text ?? ""
        delegate?.sendLoginData(user: user, password: password)
    }
}
