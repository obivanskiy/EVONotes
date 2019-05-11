//
//  NoteTableViewCell.swift
//  EVONotes
//
//  Created by Ivan Obodovskyi on 5/6/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noteTextPreview: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = colorPicker.colorPicker(r: 31, g: 33, b: 45)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
