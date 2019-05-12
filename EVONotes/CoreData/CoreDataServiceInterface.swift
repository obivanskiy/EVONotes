//
//  CoreDataServiceInterface.swift
//  EVONotes
//
//  Created by Ivan Obodovskyi on 5/12/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataServiceInterface {
    func fetchNotes()
    func sortNotes(for key: String?, isAccending: Bool)
    func refresh()
}
