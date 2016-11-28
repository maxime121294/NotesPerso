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
        let oldTitle = Array(notes.keys)[indexPath.row]
        
        let delete = UITableViewRowAction(style: .destructive, title: "Supprimer") { (action, indexPath) in
            
            let deleteAlert = UIAlertController(title: "Voulez-vous vraiment supprimer la note \"\(oldTitle)\" ?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            
            deleteAlert.addAction(UIAlertAction(title: "Supprimer", style: .destructive, handler: { (action: UIAlertAction!) in
                print("Supprimé")
                NoteManager.deleteNote(title: oldTitle)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            
            deleteAlert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Annulé")
            }))
            
            self.present(deleteAlert, animated: true, completion: nil)
        }
        
        let rename = UITableViewRowAction(style: .default, title: "Renommer") { (action, indexPath) in
            
            let renameAlert = UIAlertController(title: "Nouveau titre pour la note \"\(oldTitle)\"", message: nil, preferredStyle: .alert)
            
            renameAlert.addTextField { (textField) in
                textField.text = oldTitle
            }
            
            renameAlert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Annulé")
            }))
            
            renameAlert.addAction(UIAlertAction(title: "Enregistrer", style: .default, handler: { [weak renameAlert] (_) in
                let textField = renameAlert?.textFields![0] // Force unwrapping because we know it exists.
                let newTitle = textField?.text
                
                NoteManager.renameNote(oldTitle: oldTitle, newTitle: (newTitle)!)
                print("nouveau titre: \(newTitle)")
                
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

