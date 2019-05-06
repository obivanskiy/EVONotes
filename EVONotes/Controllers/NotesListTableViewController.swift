//
//  NotesListTableViewController.swift
//  EVONotes
//
//  Created by Ivan Obodovskyi on 5/6/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit

class NotesListTableViewController: UITableViewController {
    
    private let editNoteSegueID: String = "EditNote"
    private let addNoteSegueID: String = "AddNote"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "EVONotes"
    }
    
    @IBAction func addNotePressed(_ sender: Any) {
        
    }
    
    @IBAction func sortNotesPressed(_ sender: Any) {
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}
