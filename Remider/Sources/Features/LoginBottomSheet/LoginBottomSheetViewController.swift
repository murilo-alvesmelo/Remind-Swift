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
    var handleAreaHeight: CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
        handlePanGesture()
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
}
