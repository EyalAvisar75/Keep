//
//  NoteController.swift
//  NewKeep
//
//  Created by eyal avisar on 04/10/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

class NoteController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteContent: UITextView!
    
    let placeholderText = "Note"
    var changed = false
    var noteToEdit = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        noteContent.delegate = self
        if noteToEdit != -1 {
            noteTitle.text = notes[noteToEdit].title
            noteContent.text = notes[noteToEdit].content
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == placeholderText {
            textView.text = ""
            changed = true
            textView.textColor = .black
        }
        else if textView.text.count > 0 {
            textView.textColor = .black
        }
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if !changed && noteContent.text == placeholderText && noteToEdit == -1 {
            noteContent.text = ""
        }
        
        writeNote(title: noteTitle.text, content: noteContent.text, noteToEdit: noteToEdit)
    }
}
