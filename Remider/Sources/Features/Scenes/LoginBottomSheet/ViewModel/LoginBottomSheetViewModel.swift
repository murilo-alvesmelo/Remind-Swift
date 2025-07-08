//
//  LoginBottomSheetViewModel.swift
//  Remider
//
//  Created by Murilo Alves on 07/04/25.
//

import Foundation
import Firebase
class LoginBottomSheetViewModel {
    var succesResult: ((String) -> Void)?
    var errorResult: ((String) -> Void)?
    
    func doAuth(usernameLogin: String, password: String) {
        Auth.auth().signIn(withEmail: usernameLogin, password: password) {[weak self] authResult, error in
            if let error = error {
                self?.errorResult?("Erro ao realizar login")
            }else{
                self?.succesResult?(usernameLogin)
            }
        }
        
    }
}
