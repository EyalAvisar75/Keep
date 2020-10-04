//
//  NoteController.swift
//  NewKeep
//
//  Created by eyal avisar on 04/10/2020.
//  Copyright © 2020 eyal avisar. All rights reserved.
//

import UIKit

class NoteController: UIViewController {

    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("\(noteTitle.text), \(noteContent.text)")
        writeNote(title: noteTitle.text, content: noteContent.text)
    }
    
    
//    @IBAction func getContent(_ sender: UITextView) {
//        guard let content = sender.text else { return }
//        note = writeNoteContent(note: note, content: content)
//    }
}
