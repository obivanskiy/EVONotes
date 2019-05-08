//
//  ViewControlDelegate.swift
//  EVONotes
//
//  Created by Ivan Obodovskyi on 5/7/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import Foundation

protocol ViewControlDelegate: class {
    func disableTextInput(for controller: NoteDetailViewController)
}
