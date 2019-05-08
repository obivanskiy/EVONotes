//
//  DateAndTimeFormatterAsTimeAgo.swift
//  EVONotes
//
//  Created by Ivan Obodovskyi on 5/6/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import Foundation

extension Date {
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:MM"
        let dateString = dateFormatter.string(from: self)
        
        return dateString
    }
}
