//
//  UserDefaultManager.swift
//  Remider
//
//  Created by Murilo Alves on 03/06/25.
//

import Foundation
import UIKit

class UserDefaultManager {
    private static let userKey = "userKey"
    private static let userNameKey = "userName"
    private static let userPhotoUriKey = "userPhotoUriKey"
    
    static func savePhotoUser(image: UIImage){
        if let imageDate = image.jpegData(compressionQuality: 1.0){
            UserDefaults.standard.set(imageDate, forKey: userPhotoUriKey)
        }
    }
    
    static func loadPhotoUser() -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: userPhotoUriKey){
            return UIImage(data: imageData)
        }
        return UIImage(named: "user")
    }

    
    static func saveUserName(name: String){
        UserDefaults.standard.set(name, forKey: userNameKey)
        UserDefaults.standard.synchronize()
    }
    
    static func loadUserName() -> String? {
        return UserDefaults.standard.string(forKey: userNameKey)
    }
    
    static func removeUserName(){
        UserDefaults.standard.removeObject(forKey: userNameKey)
        UserDefaults.standard.synchronize()
    }
    
    static func saveUser(user: User){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user){
            UserDefaults.standard.set(encoded, forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func loadUser() -> User? {
        if let userData = UserDefaults.standard.data(forKey: userKey){
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: userData){
                return user
            }
        }
        
        return nil
    }
    
    static func removeUser(){
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.removeObject(forKey: userNameKey)
        UserDefaults.standard.removeObject(forKey: userPhotoUriKey)
        UserDefaults.standard.synchronize()
    }
}
