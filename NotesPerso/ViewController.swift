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
        // Do any additional setup after loading the view, typically from a nib.
        
        NoteManager.createNote(title: "titre4", text: "note4")
        NoteManager.listNotes()
        NoteManager.isEmpty()
        NoteManager.deleteNote(title: "titre3")
        NoteManager.listNotes()
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
        performSegue(withIdentifier: "showDetail", sender: Array(notes.values)[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let guest = segue.destination as! DetailViewController
            
            guest.detail = sender as! String
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            NoteManager.deleteNote(title: Array(notes.keys)[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

