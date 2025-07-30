//
//  HomeViewController.swift
//  Remider
//
//  Created by Niceplanet T.I on 19/06/25.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    let contentView: HomeView
    let viewModel: HomeViewModel
    public weak var flowDelagate: HomeFlowDelegate?
    
    init(contentView: HomeView,
         flowDelagate: HomeFlowDelegate? = nil) {
        self.contentView = contentView
        self.flowDelagate = flowDelagate
        self.viewModel = HomeViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        checkForExistingData()
    }
    
    private func setupNavigationBar(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        let logoutButton = UIBarButtonItem(image: UIImage(named: "log-out"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(logoutAction))
        logoutButton.tintColor = Colors.redBase
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    private func setupUI(){
        self.view.addSubview(contentView)
        contentView.delegate = self
        setupConstraints()
    }
    
    private func setupConstraints(){
        setupContentViewToBounds(contentView: contentView)
    }
    
    @objc
    private func logoutAction(){
        UserDefaultManager.removeUser()
        self.flowDelagate?.logout()
    }
    
    private func checkForExistingData (){
        if UserDefaultManager.loadUser() != nil{
            contentView.nameTextField.text = UserDefaultManager.loadUserName()
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapProfileImage() {
        selectProfileImage()
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func selectProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editImage = info[.editedImage] as? UIImage {
            contentView.profileImage.image = editImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            contentView.profileImage.image = originalImage
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
