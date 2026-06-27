//
//  NewReceipt.swift
//  Remider
//
//  Created by Murilo Alves on 30/10/25.
//

import Foundation
import UIKit
import Lottie

class NewReceiptViewController: UIViewController {
    private let newReceiptView =  NewReceiptView()
    private let viewModel = NewReceiptViewModel()
    
    
    private let successView: AnimationView = {
        let animationView = AnimationView(name: "success")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.isHidden = true
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
    }
    
    private func setupView() {
        view.backgroundColor = Colors.gray800
        view.addSubview(newReceiptView)
        view.addSubview(successView)
        setupConstraints()
    }
    
    private func setupConstraints(){
        newReceiptView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newReceiptView.topAnchor.constraint(equalTo: view.topAnchor),
            newReceiptView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newReceiptView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newReceiptView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            successView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 220),
            successView.heightAnchor.constraint(equalToConstant: 120),
            successView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupActions(){
        newReceiptView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        newReceiptView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func addButtonTapped(){
        
        let remedy = newReceiptView.remedyInput.getText()
        let time = newReceiptView.timeInput.getText()
        let recurrence = newReceiptView.recurrenceInput.getText()
        let takeNoew = newReceiptView.takeNowCheckbox.isHidden ? false : newReceiptView.takeNowCheckbox.isOpaque
           
        viewModel.addReceipt(remedy: remedy,
                             time: time,
                             recurrence: recurrence,
                             takeNow: takeNoew)
        playSuccessAnimation()
        clearForm()
        print("receita \(remedy) adicionado com sucesso!")
    }
    
    private func playSuccessAnimation() {
        successView.isHidden = false
        successView.play{ [weak self] finished in
            if finished {
                self?.successView.isHidden = true
            }
        }
    }
    
    private func clearForm() {
        newReceiptView.remedyInput.textField.text = ""
        newReceiptView.timeInput.textField.text = ""
        newReceiptView.recurrenceInput.textField.text = ""
        newReceiptView.addButton.isEnabled = false
    }
}
