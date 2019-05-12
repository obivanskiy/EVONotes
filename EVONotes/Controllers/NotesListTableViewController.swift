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
    
    enum SeguesToDetailController: String {
        case noteDetailSegueID = "NoteDetail"
        case addNoteSegueID = "AddNote"
        case editNoteSegueID = "EditNote"
    }
    
    @IBOutlet weak var noteSearchBar: UISearchBar!
    
    private var managedObjectContexs: NSManagedObjectContext!
    private var notes: [Note]!
    private var filteredNotes = [Note]()

    private(set) var isFiltered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = globalBackgroundColor
        navigationItem.title = "EVONotes"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContexs = appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchNotes()
        setUpSearchBar()
        refresh()
    }
    
    func setUpSearchBar() {
        noteSearchBar.delegate = self
        noteSearchBar.backgroundColor = globalBackgroundColor
        noteSearchBar.returnKeyType = UIReturnKeyType.done
        noteSearchBar.placeholder = "Search for your note"
        filteredNotes = notes
    }
    
    //MARK: - Fetch notes entity
    func fetchNotes() {
        let notesRequest = NSFetchRequest<Note>(entityName: "Note")

        do {
            self.notes = try self.managedObjectContexs.fetch(notesRequest)
        } catch let error as NSError {
            print("Could not fetch notes: \(error), \(error.userInfo )")
        }
        
        self.tableView.reloadData()
    }
    
    //MARK: - function for fetching sorted entity using NSSortDescriptor
    func sortNotes(for key: String?, isAccending: Bool) {
        let notesRequest = NSFetchRequest<Note>(entityName: "Note")

        
        let descriptor = NSSortDescriptor(key: key, ascending: isAccending)
        notesRequest.sortDescriptors = [descriptor]
        
        do {
            self.notes = try self.managedObjectContexs.fetch(notesRequest)
        } catch let error as NSError {
            print("Could not fetch notes: \(error), \(error.userInfo )")
        }
        self.tableView.reloadData()
    }
    
    //MARK: - refresh notes entity
    func refresh() {
        do{
            notes = try managedObjectContexs.fetch(Note.fetchRequest())
        } catch let error as NSError {
            print("Failed refresh \(error), \(error.userInfo)")
        }
    }
    
    private func checkStringLenght(noteText: String) -> String {
        if noteText.count >= 100 {
            let trimPoint = noteText.index(noteText.startIndex, offsetBy: 100)
            let trimmedString = noteText[..<trimPoint]
            return String(trimmedString)
        } else {
            return noteText
        }
    }
    
    @IBAction func addNotePressed(_ sender: Any) {
        performSegue(withIdentifier: SeguesToDetailController.addNoteSegueID.rawValue, sender: nil)
    }
    
    @IBAction func sortNotesPressed(_ sender: Any) {
        #warning("shoud be refactored, method is way too big")
        let sortMenuAlert = UIAlertController(title: "Sort your notes", message: nil, preferredStyle: .actionSheet)
        
        let sortByName = UIAlertAction(title: "Sort by name", style: .default) { (_) in
            let nameSortAlert = UIAlertController(title: "Sort by name", message: nil, preferredStyle: .actionSheet)
            
            let accending = UIAlertAction(title: "Accending", style: .default, handler: { (_) in
                self.sortNotes(for: "noteText", isAccending: true)
            })
            let decending = UIAlertAction(title: "Decending", style: .default, handler: { (_) in
                self.sortNotes(for: "noteText", isAccending: false)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            nameSortAlert.addAction(accending)
            nameSortAlert.addAction(decending)
            nameSortAlert.addAction(cancelAction)
            
            self.present(nameSortAlert, animated: true, completion: nil)
        }
        
        let sortByDate = UIAlertAction(title: "Sort by date", style: .default) { (_) in
            let dateSortAlert = UIAlertController(title: "Sort by name", message: nil, preferredStyle: .actionSheet)
            
            let accending = UIAlertAction(title: "Accending", style: .default, handler: { (_) in
                self.sortNotes(for: "date", isAccending: true)
            })
            let decending = UIAlertAction(title: "Decending", style: .default, handler: { (_) in
                self.sortNotes(for: "date", isAccending: false)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            dateSortAlert.addAction(accending)
            dateSortAlert.addAction(decending)
            dateSortAlert.addAction(cancelAction)
            
            self.present(dateSortAlert, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        sortMenuAlert.addAction(sortByName)
        sortMenuAlert.addAction(sortByDate)
        sortMenuAlert.addAction(cancelAction)
        present(sortMenuAlert, animated: true, completion: nil)
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
        
        cell.noteTextPreview.text = checkStringLenght(noteText: note.noteText ?? "")
        
        cell.noteDate.text = note.date?.formatDate()
        cell.layer.cornerRadius = 5
        return cell
    }
    
    //MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let note = self.notes[indexPath.row]
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit note") { (rowAction, indexPath) in
            self.performSegue(withIdentifier: SeguesToDetailController.editNoteSegueID.rawValue, sender: note)
        }
        editAction.backgroundColor = colorPicker.colorPicker(r: 0, g: 235, b: 239)
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            self.managedObjectContexs.delete(note)
            self.notes.remove(at: indexPath.row)
            
            self.tableView.reloadData()
        }
        deleteAction.backgroundColor = colorPicker.colorPicker(r: 255, g: 76, b: 0)
        
        let shareAction = UITableViewRowAction(style: .normal, title: "Share") { (rowAction, indexPath) in
            let activityController = UIActivityViewController(activityItems: [note.noteText ?? ""], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
        shareAction.backgroundColor = colorPicker.colorPicker(r: 0, g: 234, b: 97)
        
        return [deleteAction ,editAction, shareAction]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let note = notes[indexPath.row]
        self.performSegue(withIdentifier: SeguesToDetailController.noteDetailSegueID.rawValue, sender: note)
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! NoteDetailViewController
        detailViewController.note = sender as? NSManagedObject

        switch segue.identifier {
        case SeguesToDetailController.addNoteSegueID.rawValue:
            detailViewController.navigationItem.title = "Create new note"
        case SeguesToDetailController.noteDetailSegueID.rawValue:
            detailViewController.viewElementIsEnabled = false
        default:
            detailViewController.navigationItem.title = "Edit your EVONote"
        }
    }
}

extension NotesListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = true
        
        guard let input = noteSearchBar.text else {
            return
        }
        
        let request = Note.fetchRequest() as NSFetchRequest<Note>
        request.predicate = NSPredicate(format: "noteText CONTAINS %@", input)
        
        do {
            self.notes = try self.managedObjectContexs.fetch(request)
        } catch let error as NSError {
            print("Search failed \(error), \(error.userInfo)")
        }
        searchBar.resignFirstResponder()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refresh()
        searchBar.text = nil
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
}
