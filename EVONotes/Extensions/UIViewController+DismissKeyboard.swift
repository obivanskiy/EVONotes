//
//  UIViewController+DismissKeyboard.swift
//  EVONotes
//
//  Created by Ivan Obodovskyi on 5/10/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
