//
//  LoginBottomSheetViewModel.swift
//  Remider
//
//  Created by Murilo Alves on 07/04/25.
//

import Foundation
import Firebase
class LoginBottomSheetViewModel {
    var succesResult: (() -> Void)?
    
    func doAuth(user: String, password: String) {
        Auth.auth().signIn(withEmail: user, password: password) {[weak self] authResult, error in
            if let error = error {
                print("azedou \(error)")
            }else{
                self?.succesResult?()
            }
        }
        
    }
}
