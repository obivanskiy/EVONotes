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
    
    private var managedObjectContext: NSManagedObjectContext!
    private var date: Date!
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var viewElementIsEnabled = true
    var note: NSManagedObject!

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var noteTextView: UITextView!
    
    // MARK: - ViewController lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        controlUIElements()
        self.date = Date()
        managedObjectContext = appDelegate.persistentContainer.viewContext
        checkTextField()
        self.hideKeyboardWhenTappedAround()
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
    
    private func updateNote() {
        let noteDateUpdated = Date()
        note.setValue(self.noteTextView.text, forKey: "noteText")
        note.setValue(noteDateUpdated, forKey: "date")
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError{
            print("Update of the value has failed \(error.description)")
        }
    }
    
    private func checkTextField() {
        if note != nil {
            self.noteTextView.text = note.value(forKey: "noteText") as? String
        } else {
            self.noteTextView.text = ""
        }
    }
    
    private func controlUIElements() {
        noteTextView.isUserInteractionEnabled = viewElementIsEnabled
        doneButton.isEnabled = viewElementIsEnabled
    }
    
    private func createNewNote() {
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
