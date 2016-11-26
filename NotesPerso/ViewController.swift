//
//  ViewController.swift
//  NotesPerso
//
//  Created by Maxime REBIBO on 24/11/2016.
//  Copyright © 2016 Maxime. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Notes: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NoteManager.createNote(title: "titre4", text: "note4")
        NoteManager.listNotes()
        var isEmpty = NoteManager.isEmpty()
        NoteManager.deleteNote(title: "titre3")
        NoteManager.listNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

