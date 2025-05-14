//
//  LoginBottomSheetViewController.swift
//  Remider
//
//  Created by Murilo Alves on 01/04/25.
//

import Foundation
import UIKit

class LoginBottomSheetViewController:  UIViewController {
    let loginView = LoginBottomSheetView()
    let loginModel = LoginBottomSheetViewModel()
    var handleAreaHeight: CGFloat = 50.0
    public weak var flowDelegate: LoginBottomSheetFlowDelegate?
    
    
    init(delegate: LoginBottomSheetFlowDelegate){
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.delegate = self
        setupUI()
        setupGesture()
        handlePanGesture()
        bindViewModel()
    }
    
    private func setupUI(){
        self.view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupGesture() {
        //
    }
    
    private func handlePanGesture(){
        //
    }
    
    public func animateShow(completion: (()-> Void)? = nil) {
        self.view.layoutIfNeeded()
        loginView.transform = CGAffineTransform(translationX: 0, y: loginView.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.loginView.transform = .identity
            self.view.layoutIfNeeded()
        }) {_ in
            completion?()
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        let heightConstraint = loginView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func bindViewModel(){
        loginModel.succesResult = {[weak self] in
            self?.delegate?.navigateToHome()
            self?.dismiss(animated: false)
        }
    }
}

/* MARK: - SendLoginData */
extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate{
    func sendLoginData(user: String, password: String) {
        loginModel.doAuth(user: user, password: password)
    }
}
