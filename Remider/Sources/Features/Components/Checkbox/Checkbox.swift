//
//  Checkbox.swift
//  Remider
//
//  Created by Murilo Alves on 04/11/25.
//

import Foundation
import UIKit

class Checkbox: UIView {
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = Typography.input
        label.textColor = Colors.gray200
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkbox: UIButton = {
        let checkbox = UIButton()
        checkbox.setImage(UIImage(systemName: "square"), for: .normal)
        checkbox.tintColor = Colors.gray400
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()
    
    init(title: String){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(checkbox)
        addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            checkbox.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkbox.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkbox.widthAnchor.constraint(equalToConstant: 30),
            checkbox.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: Metrics.small),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
