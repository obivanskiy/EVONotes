//
//  NotesListTableViewController.swift
//  EVONotes
//
//  Created by Ivan Obodovskyi on 5/6/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit
import CoreData

class NotesListTableViewController: UITableViewController {
    
    private let editNoteSegueID: String = "EditNote"
    private let addNoteSegueID: String = "AddNote"
    var managedObjectContexs: NSManagedObjectContext!
    var notes: [NSManagedObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "EVONotes"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContexs = appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fetchNotes()
    }
    
    func fetchNotes() {
        let notesRequest = NSFetchRequest<Note>(entityName: "Note")
        
        do {
            let noteObjects = try self.managedObjectContexs.fetch(notesRequest)
            self.notes = noteObjects
        } catch let error as NSError {
            print("Could not fetch notes: \(error), \(error.userInfo )")
        }
        self.tableView.reloadData()
    }
    
    @IBAction func addNotePressed(_ sender: Any) {
        performSegue(withIdentifier: addNoteSegueID, sender: nil)
    }
    
    @IBAction func sortNotesPressed(_ sender: Any) {
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as? NoteTableViewCell else {
            return UITableViewCell()
        }
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.value(forKey: "noteText") as? String
        cell.noteDate.text = note.value(forKey: "date") as! String        
        return cell
    }
}
