//
//  NewReceiptView.swift
//  Remider
//
//  Created by Murilo Alves on 30/10/25.
//

import Foundation
import UIKit

class NewReceiptView: UIView {
    let backButton: UIButton =  {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = Colors.gray100
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = Typography.heading
        label.textColor = Colors.redBase
        label.text = "Nova receita"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = Typography.body
        label.textColor = Colors.gray200
        label.text = "Adicione a sua prescrição médica para receber lembretes de quando tomar seu medicamento"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ Adicionar", for: .normal)
        button.titleLabel?.font = Typography.subheading
        button.backgroundColor = Colors.redBase
        button.layer.cornerRadius = 12
        button.setTitleColor(Colors.gray800, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let remedyInput = InputView(title: "Remédio", placeholder: "Nome do medicamento")
    let timeInput = InputView(title: "Horário", placeholder: "12:00")
    let recurrenceInput = InputView(title: "Recorrência", placeholder: "Selecione")
    let takeNowCheckbox = Checkbox(title: "Tomar agora?")
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(remedyInput)
        addSubview(timeInput)
        addSubview(recurrenceInput)
        addSubview(takeNowCheckbox)
        addSubview(addButton)
        
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.small),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.gg),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.small),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.gg),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.gg),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.gg),
            
            remedyInput.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Metrics.small),
            remedyInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.gg),
            remedyInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.gg),
            
            timeInput.topAnchor.constraint(equalTo: remedyInput.bottomAnchor, constant: Metrics.small),
            timeInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.gg),
            timeInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.gg),
            
            recurrenceInput.topAnchor.constraint(equalTo: timeInput.bottomAnchor, constant: Metrics.small),
            recurrenceInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.gg),
            recurrenceInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.gg),
            
            takeNowCheckbox.topAnchor.constraint(equalTo: recurrenceInput.bottomAnchor, constant: Metrics.gg),
            takeNowCheckbox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.gg),
            takeNowCheckbox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.gg),
            
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.gg),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.gg),
            addButton.heightAnchor.constraint(equalToConstant: 56),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.huge)
            
        ])
    }
}
