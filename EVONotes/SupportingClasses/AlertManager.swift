//
//  Alert.swift
//  EVONotes
//
//  Created by Ivan Obodovskyi on 5/9/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit

//MARK: - Finish alert manager

struct AlertManager {
    
    enum NotesAlert {
        case mainAlert
        case dateSortAlert
        case nameSortAlert
    }
    
    enum SortType {
        case accending
        case deccending
    }
    
    func createAlert(title: String?, message: String?, style: UIAlertController.Style) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        return alert
    }
    
    func createAlertAction(for controller: UIAlertController, title: String?, style: UIAlertAction.Style, completion: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        let alertAction = UIAlertAction(title: title, style: style, handler: completion)
        return alertAction
    }
}

