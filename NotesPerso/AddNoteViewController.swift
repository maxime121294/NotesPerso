//
//  AddNoteViewController.swift
//  NotesPerso
//
//  Created by Maxime REBIBO on 27/11/2016.
//  Copyright © 2016 Maxime. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var inputTitle: UITextField!
    @IBOutlet weak var inputDetail: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inputDetail.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        DispatchQueue.main.async {
            textView.selectAll(nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        if inputTitle.text == "" {
            let emptyTitleAlert = UIAlertController(title: "Veuillez ajouter un titre à la note", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            
            emptyTitleAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                print("OK")
            }))
            
            present(emptyTitleAlert, animated: true, completion: nil)
        }
        else {
            NoteManager.createOrEditNote(title: inputTitle.text!, text: inputDetail.text!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // Hide keyboard when user touches outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Hide keyboard when user touches return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTitle.resignFirstResponder()
        inputDetail.resignFirstResponder()
        return true
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
