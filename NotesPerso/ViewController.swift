//
//  ViewController.swift
//  NotesPerso
//
//  Created by Maxime REBIBO on 24/11/2016.
//  Copyright © 2016 Maxime. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Notes: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        
//        NoteManager.createOrEditNote(title: "titre4", text: "note4")
//        NoteManager.listNotes()
//        NoteManager.isEmpty()
//        NoteManager.deleteNote(title: "titre3")
//        NoteManager.listNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = Array(notes.keys)[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedNote = [Array(notes.keys)[indexPath.row], Array(notes.values)[indexPath.row]]
        performSegue(withIdentifier: "showDetail", sender: detailedNote)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let destinationVC : DetailViewController = segue.destination as! DetailViewController
            destinationVC.array = sender as! Array
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let noteTitle = Array(notes.keys)[indexPath.row]
        
        let delete = UITableViewRowAction(style: .destructive, title: "Supprimer") { (action, indexPath) in
            NoteManager.deleteNote(title: noteTitle)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let rename = UITableViewRowAction(style: .default, title: "Renommer") { (action, indexPath) in
            
            let renameAlert = UIAlertController(title: "Nouveau titre pour la note \"\(noteTitle)\"", message: nil, preferredStyle: .alert)
            
            renameAlert.addTextField { (textField) in
                textField.text = noteTitle
            }
            
            renameAlert.addAction(UIAlertAction(title: "Enregistrer", style: .default, handler: { [weak renameAlert] (_) in
                let newTitle = renameAlert?.textFields![0] // Force unwrapping because we know it exists.

                NoteManager.renameNote(oldTitle: noteTitle, newTitle: (newTitle?.text)!)
                print("nouveau titre: \(newTitle?.text)")
                
                self.Notes.reloadData()
            }))
            
            self.present(renameAlert, animated: true, completion: nil)
        }
        
        rename.backgroundColor = UIColor.blue

        return [delete, rename]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Notes.reloadData()
    }
}

