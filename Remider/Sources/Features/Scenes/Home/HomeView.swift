//
//  HomeView.swift
//  Remider
//
//  Created by Niceplanet T.I on 19/06/25.
//

import Foundation
import UIKit

class HomeView: UIView {
    weak public var delegate: HomeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.backgroundColor = Colors.gray600
        addSubview(profileTop)
        profileTop.addSubview(profileImage)
        profileTop.addSubview(welcomeLabel)
        profileTop.addSubview(nameTextField)
        
        addSubview(contentBackground)
        contentBackground.addSubview(feedbackButton)
        setupConstraints()
        setupImageGesture()
    }
    
    private let profileTop: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray600
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Metrics.medium
        view.layer.masksToBounds = true
        view.backgroundColor = Colors.gray800
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let profileImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = Metrics.small
        imageView.image = UIImage(named: "user")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "home.welcome".localizes
        label.textColor = Colors.gray200
        label.font = Typography.input
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Insira seu nome"
        textField.returnKeyType = .done
        textField.textColor = Colors.gray100
        textField.font = Typography.heading
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let feedbackButton: UIButton = {
        let button = UIButton()
        button.setTitle("home.avaliar".localizes, for: .normal)
        button.setTitleColor(Colors.gray800, for: .normal)
        button.backgroundColor = Colors.gray100
        button.layer.cornerRadius = Metrics.medium
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            profileTop.topAnchor.constraint(equalTo: topAnchor),
            profileTop.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileTop.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileTop.heightAnchor.constraint(equalToConstant: 230),
            
            profileImage.topAnchor.constraint(equalTo: profileTop.topAnchor, constant: 60),
            profileImage.leadingAnchor.constraint(equalTo: profileTop.leadingAnchor, constant: Metrics.medium),
            profileImage.heightAnchor.constraint(equalToConstant: 68),
            profileImage.widthAnchor.constraint(equalToConstant: 68),
            
            welcomeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: Metrics.medium),
            welcomeLabel.leadingAnchor.constraint(equalTo: profileTop.leadingAnchor, constant: Metrics.medium),
            
            nameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: Metrics.small),
            nameTextField.leadingAnchor.constraint(equalTo: profileTop.leadingAnchor, constant: Metrics.medium),
            
            contentBackground.topAnchor.constraint(equalTo: profileTop.bottomAnchor),
            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            feedbackButton.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor, constant: -Metrics.gg),
            feedbackButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.medium),
            feedbackButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.medium),
            feedbackButton.heightAnchor.constraint(equalToConstant: Metrics.xl)
            
        ])
    }
    
    private func setupTextField(){
        nameTextField.addTarget(self,
                                action: #selector(nameTextFieldDidEndEditing),
                                for: .editingDidEnd)
        nameTextField.delegate = self
    }
    
    private func setupImageGesture(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(profileImageTapped))
        
        profileImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func profileImageTapped(){
        delegate?.didTapProfileImage()
    }
    
    @objc
    private func nameTextFieldDidEndEditing(){
        let userName = nameTextField.text ?? ""
        UserDefaultManager.saveUserName(name: userName)
    }
}

extension HomeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let userName = nameTextField.text ?? ""
        UserDefaultManager.saveUserName(name: userName)
        return true
    }
}
