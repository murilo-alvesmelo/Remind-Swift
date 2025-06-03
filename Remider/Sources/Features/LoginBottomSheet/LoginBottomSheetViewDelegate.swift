//
//  LoginBottomSheetViewDelegate.swift
//  Remider
//
//  Created by Murilo Alves on 07/04/25.
//

import Foundation
import UIKit

protocol LoginBottomSheetViewDelegate: AnyObject {
    func sendLoginData(user: String, password: String)
}
