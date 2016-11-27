//
//  DetailViewController.swift
//  NotesPerso
//
//  Created by Maxime REBIBO on 26/11/2016.
//  Copyright © 2016 Maxime. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var noteDetail: UITextView!
    
    var array = [String]()
    var detail = ""
    var titre = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        titre = self.array[0]
        detail = self.array[1]
        
        self.title = titre
        
        noteDetail.text = detail
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editNote(_ sender: Any) {
        if navigationItem.rightBarButtonItem?.title == "Modifier"{
            noteDetail.isEditable = true
            noteDetail.becomeFirstResponder()
            navigationItem.rightBarButtonItem?.title = "Enregistrer"
        }
        else if navigationItem.rightBarButtonItem?.title == "Enregistrer"{
            noteDetail.isEditable = false
            navigationItem.rightBarButtonItem?.title = "Modifier"
            NoteManager.createNote(title: titre, text: noteDetail.text)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
