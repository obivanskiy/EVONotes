//
//  NotesViewController.swift
//  EVONotes
//
//  Created by Ivan Obodovskyi on 5/6/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit
import CoreData

final class NoteDetailViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var note: NSManagedObject!
    var date: Date!

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var noteTextView: UITextView!
    var viewElementIsEnabled = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controlUIElements() 
        noteTextView.isUserInteractionEnabled = viewElementIsEnabled
        self.date = Date()
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
        let noteDateUpdated = Date()
        note.setValue(self.noteTextView.text, forKey: "noteText")
        note.setValue(noteDateUpdated, forKey: "date")
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError{
            print("Update of the value has failed \(error.description)")
        }
    }
    
    func controlUIElements() {
        noteTextView.backgroundColor = globalBackgroundColor
        noteTextView.textColor = globalTintColor
        noteTextView.isUserInteractionEnabled = viewElementIsEnabled
        doneButton.isEnabled = viewElementIsEnabled
    }
    
    func createNewNote() {
        let noteEntity = NSEntityDescription.entity(forEntityName: "Note", in: self.managedObjectContext)!
        let noteObject = NSManagedObject(entity: noteEntity, insertInto: self.managedObjectContext)
        
        noteObject.setValue(self.noteTextView.text, forKey: "noteText")
        noteObject.setValue(self.date, forKey: "date")
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Couldn't save an object \(error.description)")
        }
    }
}
