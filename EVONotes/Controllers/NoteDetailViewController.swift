//
//  NotesViewController.swift
//  EVONotes
//
//  Created by Ivan Obodovskyi on 5/6/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit
import CoreData

class NoteDetailViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var note: NSManagedObject!
    

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var noteDetailDate: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        if note != nil {
            self.noteTextView.text = note.value(forKey: "noteText") as? String
        } else {
            self.noteTextView.text = ""
        }
    }
    
    @IBAction func donePressed(_ sender: Any) {
        if note != nil {
            self.updateNote()
        } else {
            if noteTextView.text != "" {
                self.createNewNote()
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateNote() {
        let noteEntity = NSEntityDescription.entity(forEntityName: "Note", in: self.managedObjectContext)!
        let noteObject = NSManagedObject(entity: noteEntity, insertInto: self.managedObjectContext)
        
        noteObject.setValue(self.noteTextView.text, forKey: "noteText")
        noteObject.setValue(Date(), forKey: "date")
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Couldn't save an object \(error.description)")
        }
    }
    
    func createNewNote() {
        
    }

}
