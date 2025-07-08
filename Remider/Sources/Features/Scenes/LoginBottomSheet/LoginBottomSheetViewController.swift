//
//  LoginBottomSheetViewController.swift
//  Remider
//
//  Created by Murilo Alves on 01/04/25.
//

import Foundation
import UIKit

class LoginBottomSheetViewController:  UIViewController {
    let loginModel = LoginBottomSheetViewModel()
    let contentView: LoginBottomSheetView
    var handleAreaHeight: CGFloat = 50.0
    public weak var flowDelegate: LoginBottomSheetFlowDelegate?
    
    
    init(contentView: LoginBottomSheetView,
         flowDelegate: LoginBottomSheetFlowDelegate){
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        contentView.delegate = self
        setupUI()
        setupGesture()
        handlePanGesture()
        bindViewModel()
        setupTapToDismissKeyboard()
    }
    
    private func setupUI(){
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func presentSaveLoginAlert(email: String) {
        let alertController = UIAlertController(title: "Salvar Acesso",
                                                message: "Deseja se manter conectado?",
                                                preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Salvar", 
                                       style: .default){ _ in
            let user = User(email: email, isUserSaved: true)
            UserDefaultManager.saveUser(user: user)
            self.flowDelegate?.navigateToHome()
        }
        
        let cancelAction = UIAlertAction(title: "Não", style: .cancel){_ in
            self.flowDelegate?.navigateToHome()
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    private func presentErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Ops!",
                                                message: message,
                                                preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Tentar novamente",
                                        style: .default)
        
        alertController.addAction(retryAction)
        self.present(alertController, animated: true)
    }
    
    private func setupGesture() {
        //
    }
    
    private func handlePanGesture(){
        //
    }
    
    private func setupTapToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    public func animateShow(completion: (()-> Void)? = nil) {
        self.view.layoutIfNeeded()
        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = .identity
            self.view.layoutIfNeeded()
        }) {_ in
            completion?()
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func bindViewModel(){
        loginModel.succesResult = {[weak self] usernameLogin in
            self?.presentSaveLoginAlert(email: usernameLogin)
        }
        
        loginModel.errorResult = {[weak self] errorMessage in
            self?.presentErrorAlert(message: errorMessage)
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        self.view.frame.origin.y = -keyboardHeight / 2
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

/* MARK: - SendLoginData */
extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate{
    func sendLoginData(user: String, password: String) {
        loginModel.doAuth(usernameLogin: user, password: password)
    }
}

